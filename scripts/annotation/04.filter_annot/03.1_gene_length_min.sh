#!/bin/bash
#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J GL_min
#SBATCH -o 20260115_gene_length_min.log
#SBATCH --mail-type=END

mamba activate agat

GFF=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/04.merged_annotations/04_interpro_blast_diamond_mmseqsHS_FINAL_MERGED/interpro_blast_diamond_mmseqs.gff
OUTDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/06.filtered/03.gene_length

agat_sp_filter_gene_by_length.pl -f $GFF -s 50 -t ">=" -o ${OUTDIR}/A_najas_gl_min50.gff

agat_sp_filter_gene_by_length.pl -f $GFF -s 150 -t ">" -o ${OUTDIR}/A_najas_gl_min150.gff

agat_sp_filter_gene_by_length.pl -f $GFF -s 300 -t ">" -o ${OUTDIR}/A_najas_gl_min300.gff
