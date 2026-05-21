#!/bin/bash
#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J ORFsize
#SBATCH -o 20260112_ORFsize.log
#SBATCH --mail-type=END

mamba activate agat

GFF=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/04.merged_annotations/04_interpro_blast_diamond_mmseqsHS_FINAL_MERGED/interpro_blast_diamond_mmseqs.gff
OUTDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/06.filtered/01.ORF_size

agat_sp_filter_by_ORF_size.pl -g $GFF -s 100 -t ">" -o ${OUTDIR}/A_najas_ORF_100.gff

agat_sp_filter_by_ORF_size.pl -g $GFF -s 50 -t ">" -o ${OUTDIR}/A_najas_ORF_50.gff

agat_sp_filter_by_ORF_size.pl -g $GFF -s 30 -t ">" -o ${OUTDIR}/A_najas_ORF_30.gff
