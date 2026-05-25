#!/bin/bash
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p pelle
#SBATCH -c 1
#SBATCH -t 00:30:00
#SBATCH -J incCDN
#SBATCH -o 20YYMMDD_incCDN.log
#SBATCH --mail-type=END

mamba activate agat

GFF=/path/to/interpro_blast_diamond_mmseqs.gff
GENOME=/path/to/masked_genome.fa
OUTDIR=/path/to/04.incomplete_codon

agat_sp_filter_incomplete_gene_coding_models.pl -gff $GFF -fa $GENOME --ct 1 -o ${OUTDIR}/A_najas_incompleteCDN.gff
