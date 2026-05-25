#!/bin/bash -l
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 05:00:00
#SBATCH -J aquarius_gtf2fa
#SBATCH -o 20YYMMDD_gtf2fa.log
#SBATCH --mail-type=END

module load bioinfo-tools cufflinks/2.2.1

GTF=/path/to/braker.gtf
REF=/path/to/masked_genome.fa
OUT=/path/to/gtf_transcriptome.fasta

gffread -x $OUT -g $REF $GTF
