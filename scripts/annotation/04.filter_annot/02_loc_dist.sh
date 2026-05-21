#!/bin/bash
#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J locdist
#SBATCH -o 20260113_locdist.log
#SBATCH --mail-type=END

mamba activate agat

GFF=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/04.merged_annotations/04_interpro_blast_diamond_mmseqsHS_FINAL_MERGED/interpro_blast_diamond_mmseqs.gff
OUTDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/06.filtered/02.loc_dist

agat_sp_filter_by_locus_distance.pl -gff $GFF -d 500 -o ${OUTDIR}/A_najas_locdist_500.gff
