#!/bin/bash -l

#SBATCH -A uppmax2025-2-17
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 03:00:00
#SBATCH -J eggnog_mm_def
#SBATCH -o 20251128_eggnog_mm_def.log
#SBATCH --mail-type=END
#SBATCH --mail-user=ingo.mueller@ebc.uu.se

#Run eggnog-mapper with mmseqs2 and default sensitivity settings (min: 3, max: 7)

# Load modules
module load bioinfo-tools eggNOG-mapper/2.1.9 eggNOG_data/5.0.0

InFAA=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/01.interpro/00.input/braker_nostop.faa
OutDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/03.eggnog/02.mm_def/
GFF=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/01.braker/braker.gff

#Use/Make scratch dir
export scratchDIR=${SNIC_TMP}/A_najas_eggnog_def

if [ -d ${scratchDIR} ]; then
    echo "Scratch directory already exists: ${scratchDIR}"
else
    mkdir $scratchDIR
    echo "created directory in SNIC_TMP: $scratchDIR"
fi


#Limit annotation to Arthropods (6656)
emapper.py -i $InFAA --output_dir $OutDIR -o A_najas_eggnog_mm_def --cpu 16 --scratch_dir $scratchDIR -m mmseqs --start_sens 3 --final_sens 7 --tax_scope 6656 --decorate_gff ${GFF}
