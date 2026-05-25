#!/bin/bash
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J GL_min
#SBATCH -o 20YYMMDD_gene_length_min.log
#SBATCH --mail-type=END

mamba activate agat

GFF=/path/to/interpro_blast_diamond_mmseqs.gff
OUTDIR=/path/to/03.gene_length

agat_sp_filter_gene_by_length.pl -f $GFF -s 50 -t ">=" -o ${OUTDIR}/A_najas_gl_min50.gff

agat_sp_filter_gene_by_length.pl -f $GFF -s 150 -t ">" -o ${OUTDIR}/A_najas_gl_min150.gff

agat_sp_filter_gene_by_length.pl -f $GFF -s 300 -t ">" -o ${OUTDIR}/A_najas_gl_min300.gff
