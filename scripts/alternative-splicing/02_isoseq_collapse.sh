#!/bin/bash
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p pelle
#SBATCH -c 4
#SBATCH -t 00:30:00
#SBATCH -J isoseq_collapse
#SBATCH -o 20YYMMDD_isoseq_collapse.log
#SBATCH --mail-type=END

#Activate environment before submitting
#mamba activate isoseq

#Collapse mapped isoseq reads into unique isoforms
InDIR=/path/to/mapped_reads/
OutDIR=/path/to/collapsed_reads/

ID_list="I1
I2
I3
I4
I5M
I5F
Mad
Fad"

#Loop through all 8 isoseq samples
for ID in $ID_list
        do
		isoseq collapse --do-not-collapse-extra-5exons --num-threads 4 \
			${InDIR}/${ID}_pbmm2.bam ${OutDIR}/${ID}.collapsed.gff
	done
