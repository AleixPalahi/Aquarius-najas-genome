#!/bin/bash
#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J GL_min_ORF
#SBATCH -o 20260115_gene_length_min_ORF.log
#SBATCH --mail-type=END

#Add gene length filter over ORF
mamba activate agat

GFFDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/06.filtered/01.ORF_size
OUTDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/06.filtered/03.gene_length

agat_sp_filter_gene_by_length.pl -f ${GFFDIR}/A_najas_ORF_50_sup50.gff -s 150 -t ">" -o ${OUTDIR}/A_najas_gl_ORF50_min150.gff

agat_sp_filter_gene_by_length.pl -f ${GFFDIR}/A_najas_ORF_100_sup100.gff -s 300 -t ">" -o ${OUTDIR}/A_najas_gl_ORF100_min300.gff
