#!/bin/bash -l

#SBATCH -A uppmax20XX-X-XX
#SBATCH -p pelle
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J BLAST_addGO
#SBATCH -o 20YYMMDD_BLAST_addGO.log
#SBATCH --mail-type=END

### Merge BLAST output with interpro+braker gff

# Load environment (AGAT v 1.5.1) before running
# mamba activate agat

GFF=/path/to/braker_interpro/braker.gff
BLAST_DIR=/path/to/functional/02.BLAST
DB_FA=/path/to/uniprot_sprot.fasta

agat_sp_manage_functional_annotation.pl -f $GFF -b ${BLAST_DIR}/Sprot_blast.out -db $DB_FA -o ${BLAST_DIR}/braker_interpro_blast
