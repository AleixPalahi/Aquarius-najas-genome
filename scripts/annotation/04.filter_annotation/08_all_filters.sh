#!/bin/bash
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J Filter_annot
#SBATCH -o 20YYMMDD_filterannot.log
#SBATCH --mail-type=END

mamba activate agat

GFF=/path/to/interpro_blast_diamond_mmseqs.gff
GENOME=/path/to/masked_genome.fa
WDIR=/path/to/final/

#Filter by ORF size (>= 50 aa)
agat_sp_filter_by_ORF_size.pl -g $GFF -s 50 -t ">=" -o ${WDIR}/A_najas_filt_ORF.gff

#Rename output files
mv ${WDIR}/A_najas_filt_ORF_sup\=50.gff ${WDIR}/A_najas_filt_ORF50.gff
mv ${WDIR}/A_najas_filt_ORF_NOT_sup\=50.gff ${WDIR}/A_najas_filt_ORF50_excluded.gff

#Incomplete CDS
agat_sp_filter_incomplete_gene_coding_models.pl -gff ${WDIR}/A_najas_filt_ORF50.gff -fa $GENOME --ct 1 -o ${WDIR}/A_najas_filt_final.gff
