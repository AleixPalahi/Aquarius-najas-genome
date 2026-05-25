#!/bin/bash -l

#SBATCH -A uppmax20XX-X-XX
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 03:00:00
#SBATCH -J eggnog_mm_HS
#SBATCH -o 20YYMMDD_eggnog_mm_HS.log
#SBATCH --mail-type=END

#Run eggnog-mapper with mmseqs2 and higher than default sensitivity settings
#max sensitivity taken from Kallenborn, et al. (2025) GPU-accelerated homology search with MMseqs2. Nature Methods

# Load modules
module load bioinfo-tools eggNOG-mapper/2.1.9 eggNOG_data/5.0.0

InFAA=/path/to/braker_nostop.faa
OutDIR=/path/to/functional/03.eggnog/01.mm_HS
GFF=/path/to/braker.gff

#Use/Make scratch dir
export scratchDIR=${SNIC_TMP}/A_najas_eggnog

if [ -d ${scratchDIR} ]; then
    echo "Scratch directory already exists: ${scratchDIR}"
else
    mkdir $scratchDIR
    echo "created directory in SNIC_TMP: $scratchDIR"
fi


#Limit annotation to Arthropods (6656)
emapper.py -i $InFAA --output_dir $OutDIR -o A_najas_eggnog --cpu 16 --scratch_dir $scratchDIR -m mmseqs --start_sens 3.5 --final_sens 8.5 --tax_scope 6656 --decorate_gff ${GFF} 
