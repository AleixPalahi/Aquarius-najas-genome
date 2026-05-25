#!/bin/bash
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p pelle
#SBATCH -c 8
#SBATCH -t 08:00:00
#SBATCH -J sqanti_qc
#SBATCH -o 20YYMMDD_sqanti_qc.log
#SBATCH --mail-type=END

#Run before submitting
#export LD_LIBRARY_PATH=/path/to/miniforge3/envs/sqanti3/lib:$LD_LIBRARY_PATH
#Activate conda before submitting
#mamba activate sqanti3

#Collapse mapped isoseq reads into unique isoforms
REF_FA=/path/to/masked_genome.fa
REF_ANN=/path/to/genome_annotation.gtf
GFF_DIR=/path/to/collapsed_reads/
OutDIR=/path/to/sqanti_out/
SQANTI_DIR=/path/to/bin/sqanti3

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
		${SQANTI_DIR}/sqanti3_qc.py --isoforms ${GFF_DIR}/${ID}.collapsed.filtered.gff \
			--refGTF $REF_ANN --refFasta $REF_FA \
			--fl_count ${GFF_DIR}/${ID}.collapsed.filtered.abundance.txt \
			-n 10 -o ${ID} -d $OutDIR/${ID} --report both -t 8
	done
