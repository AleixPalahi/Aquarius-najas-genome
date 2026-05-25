#!/bin/bash -l

#SBATCH -A uppmax20XX-X-XX
#SBATCH -p pelle
#SBATCH -n 16
#SBATCH -t 05-00:00:00
#SBATCH -J BLAST_sprot
#SBATCH -o 20YYMMDD_BLAST_sprot.log
#SBATCH --mail-type=END

# Load modules
module load BLAST+/2.17

InFAA=/path/to/braker_nostop.faa
SPROT_DB=/path/to/uniprot_sprot.fasta
OutDIR=/path/to/BLAST_out

#Against all entries regardless of taxonomy
blastp -db ${SPROT_DB} -query $InFAA -outfmt 6 -max_target_seqs 10 -evalue 1e-3 -out ${OutDIR}/Sprot_blast.out -num_threads 16
