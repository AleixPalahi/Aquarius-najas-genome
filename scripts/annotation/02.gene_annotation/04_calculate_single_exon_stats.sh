#!/bin/sh
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 20:00
#SBATCH -J single_exon_stats
#SBATCH -o 20YYMMDD_single_exon_stats.log
#SBATCH --mail-type=END

module load bioinfo-tools python3

GFF=/path/to/braker.gff
OUTFILE=/path/to/A_najas_single_exons.txt

echo "---> A_najas"
python3 calculate_single_exon_stats.py $GFF True > $OUTFILE

