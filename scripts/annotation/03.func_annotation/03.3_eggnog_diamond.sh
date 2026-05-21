#!/bin/bash -l

#SBATCH -A uppmax2025-2-17
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 03:00:00
#SBATCH -J eggnog_diamond
#SBATCH -o 20251127_eggnog_diamond.log
#SBATCH --mail-type=END
#SBATCH --mail-user=ingo.mueller@ebc.uu.se

#Run eggnog-mapper with diamond, running with iterations similar to mmseqs2 with the final iteration on ultra-sensitive settings which should be slightly better than
#mmseqs2 at s=7.5 (Buchfink, et al. (2025). Sensitive protein alignments at tree-of-life scale using DIAMOND. Nature methods)

# Load modules
module load bioinfo-tools eggNOG-mapper/2.1.9 eggNOG_data/5.0.0

InFAA=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/01.interpro/00.input/braker_nostop.faa
OutDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/03.eggnog/03.diamond
GFF=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/01.braker/braker.gff

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
