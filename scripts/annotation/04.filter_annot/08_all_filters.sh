#!/bin/bash
#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J Filter_annot
#SBATCH -o 20260116_filterannot.log
#SBATCH --mail-type=END

mamba activate agat

GFF=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/04.merged_annotations/04_interpro_blast_diamond_mmseqsHS_FINAL_MERGED/interpro_blast_diamond_mmseqs.gff
GENOME=/proj/snic2019-35-58/water_strider/ingo/data/raw_internal/01.ref/Anajas_masked_genome.fa
WDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/06.filtered/08.final/

#Filter by ORF size (>= 50 aa)
agat_sp_filter_by_ORF_size.pl -g $GFF -s 50 -t ">=" -o ${WDIR}/A_najas_filt_ORF.gff

#Rename output files
mv ${WDIR}/A_najas_filt_ORF_sup\=50.gff ${WDIR}/A_najas_filt_ORF50.gff
mv ${WDIR}/A_najas_filt_ORF_NOT_sup\=50.gff ${WDIR}/A_najas_filt_ORF50_excluded.gff

#Incomplete CDS
agat_sp_filter_incomplete_gene_coding_models.pl -gff ${WDIR}/A_najas_filt_ORF50.gff -fa $GENOME --ct 1 -o ${WDIR}/A_najas_filt_final.gff
