#!/bin/bash -l
#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -n 8
#SBATCH -t 08:00:00
#SBATCH -J InterProMerge
#SBATCH -o 20251211_InterProMerge.log
#SBATCH --mail-type=END

#Merge interproscan output into braker annotation

# Load environment (AGAT v 1.5.1)
mamba activate agat

GFF=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/01.braker/braker.gff
IP_FILE=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/01.interpro/01.output/braker_nostop.faa.tsv
OUTDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/01.interpro/01.output

agat_sp_manage_functional_annotation.pl -f $GFF -i $IP_FILE -o ${OUTDIR}/braker_interpro
