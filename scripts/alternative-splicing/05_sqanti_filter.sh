#!/bin/bash
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p pelle
#SBATCH -c 6
#SBATCH -t 01:30:00
#SBATCH -J sqanti_filter_custom
#SBATCH -o 20YYMMDD_sqanti_custom.log
#SBATCH --mail-type=END

#Activate conda before submitting
#mamba activate sqanti3

#Collapse mapped isoseq reads into unique isoforms
InDIR=/path/to/sqanti_out/
OutDIR=/path/to/filtered_transcripts/
SQANTI_DIR=/path/to/bin/sqanti3
FILT=/path/to/custom_filters.json

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
		${SQANTI_DIR}/sqanti3_filter.py rules --sqanti_class ${InDIR}/${ID}/${ID}_classification.txt \
		       	--filter_gtf ${InDIR}/${ID}/${ID}_corrected.gtf --filter_faa ${InDIR}/${ID}/${ID}_corrected.faa \
			--filter_isoforms ${InDIR}/${ID}/${ID}_corrected.fasta -j $FILT \
			-e -o ${ID}_custom_final -d $OutDIR -c 6
	done
