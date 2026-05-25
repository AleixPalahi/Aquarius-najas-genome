#!/bin/bash -l
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p pelle
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J setID
#SBATCH -o 20YYMMDD_setID.log
#SBATCH --mail-type=END

### Set IDs for merged gff

# Load environment (AGAT v 1.5.1)
mamba activate agat

GFF=/path/to/braker_interpro_blast/braker.gff
WDIR=/path/to/final_annotation

agat_sp_manage_functional_annotation.pl -f $GFF --ID A_najas -o ${WDIR}/braker_interpro_blast_ID
