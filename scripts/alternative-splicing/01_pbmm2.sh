#!/bin/bash
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p pelle
#SBATCH -c 12
#SBATCH -t 03:00:00
#SBATCH -J pbmm2
#SBATCH -o 20YYMMDD_pbmm2.log
#SBATCH --mail-type=END

#Activate environment before submitting
#mamba activate bold_isoseq

#Collapse mapped isoseq reads into unique isoforms
REFDIR=/path/to/reference_genome/
InDIR=/path/to/isoseq_data/
OutDIR=/path/to/mapped_reads/

ID_list="I1
I2
I3
I4
I5M
I5F
Mad
Fad"

#Index reference using pbmm2
pbmm2 index --preset ISOSEQ -j 12 ${REFDIR}/Anajas_masked_genome.fa ${REFDIR}/Anajas_masked_genome.mmi

#Loop through all 8 isoseq samples
for ID in $ID_list
        do
                pbmm2 align --preset ISOSEQ -j 12 --sort --bam-index BAI \
                        ${REFDIR}/Anajas_masked_genome.mmi ${InDIR}/hq_transcripts-${ID}.fasta ${OutDIR}/${ID}_pbmm2.bam
        done

