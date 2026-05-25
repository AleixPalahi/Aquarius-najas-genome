#!/bin/bash -l

#SBATCH -A uppmax20XX-X-XX
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 20:00:00
#SBATCH -J interproscan
#SBATCH -o 20YYMMDD_interproscan.log
#SBATCH --mail-type=END

# Remove stop codons (denoted with *) from braker output before running:
# sed -e 's/*//g' braker.aa > braker_nostop.faa

# Load modules
module load bioinfo-tools InterProScan/5.62-94.0

InFAA=/path/to/braker_nostop.faa
OutDIR=/path/to/functional/01.interpro/

interproscan.sh -i $InFAA -cpu 8 -t p -dp -pa --goterms --iprlookup -d $OutDIR
