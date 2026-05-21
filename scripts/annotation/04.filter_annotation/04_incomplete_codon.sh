#!/bin/bash
#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J incCDN
#SBATCH -o 20260113_incCDN.log
#SBATCH --mail-type=END

mamba activate agat

GFF=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/04.merged_annotations/04_interpro_blast_diamond_mmseqsHS_FINAL_MERGED/interpro_blast_diamond_mmseqs.gff
GENOME=/proj/snic2019-35-58/water_strider/ingo/data/raw_internal/01.ref/Anajas_masked_genome.fa
OUTDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/06.filtered/04.incomplete_codon

agat_sp_filter_incomplete_gene_coding_models.pl -gff $GFF -fa $GENOME --ct 1 -o ${OUTDIR}/A_najas_incompleteCDN.gff
