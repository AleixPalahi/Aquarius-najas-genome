#!/bin/bash -l

#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -n 48
#SBATCH -t 3-12:00:00
#SBATCH -J BLAST_Hemi
#SBATCH -o 20251205_BLAST_Hemi.log
#SBATCH --mail-type=END

# Load modules
module load BLAST+/2.17.0-gompi-2024a BLAST_databases/lates

InFAA=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/01.interpro/00.input/braker_nostop.faa
OutDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/02.BLAST

#Hemiptera NCBI taxid: 7524
blastp -db nr -taxids 7524 -query $InFAA -outfmt 6 -max_target_seqs 10 -evalue 1e-3 -out ${OutDIR}/Hemiptera_blast.out -num_threads 48
