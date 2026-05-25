#!/bin/bash -l
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p pelle
#SBATCH -n 8
#SBATCH -t 08:00:00
#SBATCH -J InterProMerge
#SBATCH -o 20YYMMDD_InterProMerge.log
#SBATCH --mail-type=END

#Merge interproscan output into braker annotation

# Load environment (AGAT v 1.5.1) before running
# mamba activate agat

GFF=/path/to/braker.gff
IP_FILE=/path/to/braker_nostop.faa.tsv
OUTDIR=/path/to/01.interpro/01.output

agat_sp_manage_functional_annotation.pl -f $GFF -i $IP_FILE -o ${OUTDIR}/braker_interpro
