#!/bin/bash -l

#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -n 72
#SBATCH -t 10-00:00:00
#SBATCH -J BLAST_Arthro
#SBATCH -o 20251208_BLAST_Arthro.log
#SBATCH --mail-type=END

# Load modules
module load BLAST+/2.17.0-gompi-2024a BLAST_databases/latest

InFAA=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/01.interpro/00.input/braker_nostop.faa
OutDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/02.BLAST

#Artrhopoda NCBI taxid: 6656
blastp -db nr -taxids 6656 -query $InFAA -outfmt 6 -max_target_seqs 10 -evalue 1e-3 -out ${OutDIR}/Arthropoda_blast.out -num_threads 72
