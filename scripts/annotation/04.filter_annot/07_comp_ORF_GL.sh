#!/bin/bash -l
#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J comp_ORF_GL
#SBATCH -o 20260115_comp_ORF_GL.log
#SBATCH --mail-type=END

mamba activate agat

WDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/06.filtered
OUTDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/06.filtered/07.comp_stat

#ORF50 v GL150
agat_sp_compare_two_annotations.pl -gff1 ${WDIR}/01.ORF_size/A_najas_ORF_50_NOT_sup50.gff \
	-gff2 ${WDIR}/03.gene_length/A_najas_gl_min150_remaining.gff -o ${OUTDIR}/ORF50_GL150

#ORF100 v GL300
agat_sp_compare_two_annotations.pl -gff1 ${WDIR}/01.ORF_size/A_najas_ORF_100_NOT_sup100.gff \
        -gff2 ${WDIR}/03.gene_length/A_najas_gl_min300_remaining.gff -o ${OUTDIR}/ORF100_GL300

#GL50 v GL150
agat_sp_compare_two_annotations.pl -gff1 ${WDIR}/03.gene_length/A_najas_gl_min50_remaining.gff \
        -gff2 ${WDIR}/03.gene_length/A_najas_gl_min150_remaining.gff -o ${OUTDIR}/GL50_GL150

#ORF30 v ORF50
agat_sp_compare_two_annotations.pl -gff1 ${WDIR}/01.ORF_size/A_najas_ORF_30_NOT_sup30.gff \
        -gff2 ${WDIR}/01.ORF_size/A_najas_ORF_50_NOT_sup50.gff -o ${OUTDIR}/ORF30_ORF50

