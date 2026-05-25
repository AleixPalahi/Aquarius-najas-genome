#!/bin/bash
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J overlap
#SBATCH -o 20YYMMDD_OL.log
#SBATCH --mail-type=END

mamba activate agat

GFF=/path/to/interpro_blast_diamond_mmseqs.gff
OUTDIR=/path/to/05.overlap

agat_sp_fix_overlaping_genes.pl -f $GFF -m -o ${OUTDIR}/A_najas_OL.gff
