#!/bin/bash
#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J GL_max
#SBATCH -o 20260113_gene_length_max.log
#SBATCH --mail-type=END

mamba activate agat

GFF=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/04.merged_annotations/04_interpro_blast_diamond_mmseqsHS_FINAL_MERGED/interpro_blast_diamond_mmseqs.gff
OUTDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/06.filtered/03.gene_length

#95% quantile (<= 7005 bp)
agat_sp_filter_gene_by_length.pl -f $GFF -s 7005 -t "<=" -o ${OUTDIR}/A_najas_gl_95quant.gff

#90% quantile (<= 4476 bp)
agat_sp_filter_gene_by_length.pl -f $GFF -s 4476 -t "<=" -o ${OUTDIR}/A_najas_gl_90quant.gff
