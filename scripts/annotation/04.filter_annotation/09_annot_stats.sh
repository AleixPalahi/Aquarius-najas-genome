#!/bin/bash
#SBATCH -A uppmax20XX-X_XX
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J annot_stats
#SBATCH -o 20YYMMDD_AGAT_stats.log
#SBATCH --mail-type=END

mamba activate agat

WDIR=/path/to/final

agat_sp_statistics.pl -gff ${WDIR}/A_najas_filt_final.gff -o ${WDIR}/filt_annot_stats.txt
