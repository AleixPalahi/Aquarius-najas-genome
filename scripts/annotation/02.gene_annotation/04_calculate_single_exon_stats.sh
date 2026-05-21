#!/bin/sh
#SBATCH -A uppmax2025-2-17
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 20:00
#SBATCH -J single_exon_stats
#SBATCH -o 20251117_single_exon_stats.log
#SBATCH --mail-type=END
#SBATCH --mail-user ingo.mueller@ebc.uu.se

module load bioinfo-tools python3

GFF=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/A_najas/braker/braker.gff
OUTFILE=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/01.QC/02.single_exon/A_najas_single_exons.txt

echo "---> A_najas"
python3 calculate_single_exon_stats.py $GFF True > $OUTFILE

