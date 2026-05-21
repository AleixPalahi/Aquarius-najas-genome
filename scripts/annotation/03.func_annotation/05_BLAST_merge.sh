#!/bin/bash -l

#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J BLAST_addGO
#SBATCH -o 20251212_BLAST_addGO.log
#SBATCH --mail-type=END

### Merge BLAST output with interpro/braker gff

# Load environment (AGAT v 1.5.1)
mamba activate agat

GFF=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/01.interpro/01.output/braker_interpro/braker.gff
BLAST_DIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/02.BLAST
DB_FA=/proj/snic2019-35-58/water_strider/ingo/data/raw_external/01.prot/uniprot_sprot.fasta

agat_sp_manage_functional_annotation.pl -f $GFF -b ${BLAST_DIR}/Sprot_blast.out -db $DB_FA -o ${BLAST_DIR}/braker_interpro_blast
