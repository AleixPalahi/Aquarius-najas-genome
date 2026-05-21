#!/bin/bash -l

#SBATCH -A uppmax2025-2-17
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 20:00:00
#SBATCH -J interproscan
#SBATCH -o 20251125_interproscan.log
#SBATCH --mail-type=END
#SBATCH --mail-user=ingo.mueller@ebc.uu.se

# Load modules
module load bioinfo-tools InterProScan/5.62-94.0

InFAA=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/01.interpro/00.input/braker_nostop.faa
OutDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/01.interpro/01.output/

interproscan.sh -i $InFAA -cpu 8 -t p -dp -pa --goterms --iprlookup -d $OutDIR
