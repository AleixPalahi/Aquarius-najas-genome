#!/bin/bash
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J locdist
#SBATCH -o 20YYMMDD_locdist.log
#SBATCH --mail-type=END

mamba activate agat

GFF=/path/to/interpro_blast_diamond_mmseqs.gff
OUTDIR=/path/to/02.loc_dist

agat_sp_filter_by_locus_distance.pl -gff $GFF -d 500 -o ${OUTDIR}/A_najas_locdist_500.gff
