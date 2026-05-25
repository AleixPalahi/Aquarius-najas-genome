#!/bin/bash -l

#SBATCH -A uppmax20XX-X-XX
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 03:00:00
#SBATCH -J eggnog_diamond
#SBATCH -o 20YYMMDD_eggnog_diamond.log
#SBATCH --mail-type=END

#Run eggnog-mapper with diamond, running with iterations similar to mmseqs2 with the final iteration on ultra-sensitive settings which should be slightly better than
#mmseqs2 at s=7.5 (Buchfink, et al. (2025). Sensitive protein alignments at tree-of-life scale using DIAMOND. Nature methods)

# Load modules
module load bioinfo-tools eggNOG-mapper/2.1.9 eggNOG_data/5.0.0

InFAA=/path/to/braker_nostop.faa
OutDIR=/path/to/functional/03.eggnog/02.diamond
GFF=/path/to/braker.gff

#Use/Make scratch dir
export scratchDIR=${SNIC_TMP}/A_najas_eggnog_diamond

if [ -d ${scratchDIR} ]; then
    echo "Scratch directory already exists: ${scratchDIR}"
else
    mkdir $scratchDIR
    echo "created directory in SNIC_TMP: $scratchDIR"
fi


#Limit annotation to Arthropods (6656)
emapper.py -i $InFAA --output_dir $OutDIR -o A_najas_eggnog_diamond --cpu 16 --scratch_dir $scratchDIR -m diamond --tax_scope 6656 --decorate_gff ${GFF} \
	--sensmode ultra-sensitive --dmnd_iterate yes --matrix BLOSUM62
