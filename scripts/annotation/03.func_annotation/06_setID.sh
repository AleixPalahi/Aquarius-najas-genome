#!/bin/bash -l
#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -n 1
#SBATCH -t 01:00:00
#SBATCH -J setID
#SBATCH -o 20251212_setID.log
#SBATCH --mail-type=END

### Set IDs for merged gff

# Load environment (AGAT v 1.5.1)
mamba activate agat

GFF=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/02.BLAST/braker_interpro_blast/braker.gff
WDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/04.final_annotation


agat_sp_manage_functional_annotation.pl -f $GFF --ID A_najas -o ${WDIR}/braker_interpro_blast_ID
