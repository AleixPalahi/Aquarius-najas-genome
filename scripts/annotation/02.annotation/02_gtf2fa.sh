#!/bin/bash -l
#SBATCH -A uppmax2025-2-17
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 05:00:00
#SBATCH -J aquarius_gtf2fa
#SBATCH -o 20251117_gtf2fa.log
#SBATCH --mail-type=END
#SBATCH --mail-user=ingo.mueller@ebc.uu.se

module load bioinfo-tools cufflinks/2.2.1

GTF=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/A_najas/braker/braker.gtf
REF=/proj/snic2019-35-58/water_strider/ingo/data/raw_internal/01.ref/Anajas_masked_genome.fa
OUT=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/01.QC/01.busco/gtf_transcriptome.fasta

gffread -x $OUT -g $REF $GTF
