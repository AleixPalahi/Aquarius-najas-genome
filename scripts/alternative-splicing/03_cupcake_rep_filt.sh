#!/bin/bash
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p pelle
#SBATCH -c 8
#SBATCH -t 04-00:00:00
#SBATCH -J cupcake_rep_filt
#SBATCH -o 20YYMMDD_cupcake_rep_filt.log
#SBATCH --mail-type=END

#Activate environment before submitting
#mamba activate cupcake

#Collapse mapped isoseq reads into unique isoforms
InDIR=/path/to/collapsed_reads/
CL_report=/path/to/sample0.transcripts.cluster_report.csv

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
		get_abundance_post_collapse.py ${InDIR}/${ID}.collapsed $CL_report

		filter_away_subset.py ${InDIR}/${ID}.collapsed
	done
