#!/bin/bash
#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J annot_stats
#SBATCH -o 20260116_AGAT_stats.log
#SBATCH --mail-type=END

mamba activate agat

WDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/06.filtered/08.final

agat_sp_statistics.pl -gff ${WDIR}/A_najas_filt_final.gff -o ${WDIR}/filt_annot_stats.txt
