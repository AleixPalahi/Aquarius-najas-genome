#!/bin/bash -l

#SBATCH -A uppmax2025-2-17
#SBATCH -p pelle
#SBATCH -n 16
#SBATCH -t 05-00:00:00
#SBATCH -J BLAST_sprot
#SBATCH -o 20251210_BLAST_sprot.log
#SBATCH --mail-type=END

# Load modules
module load BLAST+/2.17

InFAA=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/01.interpro/00.input/braker_nostop.faa
SPROT_DB=/proj/snic2019-35-58/water_strider/ingo/data/raw_external/01.prot/uniprot_sprot.fasta
OutDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/03.functional/02.BLAST

#Against all entries regardless of taxonomy
blastp -db ${SPROT_DB} -query $InFAA -outfmt 6 -max_target_seqs 10 -evalue 1e-3 -out ${OutDIR}/Sprot_blast.out -num_threads 16
