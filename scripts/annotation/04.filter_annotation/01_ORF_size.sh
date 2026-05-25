#!/bin/bash
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J ORFsize
#SBATCH -o 20YYMMDD_ORFsize.log
#SBATCH --mail-type=END

mamba activate agat

GFF=/path/to/interpro_blast_diamond_mmseqs.gff
OUTDIR=/path/to/01.ORF_size

agat_sp_filter_by_ORF_size.pl -g $GFF -s 100 -t ">" -o ${OUTDIR}/A_najas_ORF_100.gff

agat_sp_filter_by_ORF_size.pl -g $GFF -s 50 -t ">" -o ${OUTDIR}/A_najas_ORF_50.gff

agat_sp_filter_by_ORF_size.pl -g $GFF -s 30 -t ">" -o ${OUTDIR}/A_najas_ORF_30.gff
