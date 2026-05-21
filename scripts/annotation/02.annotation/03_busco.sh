#!/bin/bash -l

#SBATCH -A uppmax2025-2-17
#SBATCH -p core
#SBATCH -n 10
#SBATCH -t 4:00:00
#SBATCH -J aquarius_busco
#SBATCH -o 20251117_busco.log
#SBATCH --mail-type=END
#SBATCH --mail-user=ingo.mueller@ebc.uu.se


# Load modules
module load bioinfo-tools
module load augustus/3.5.0
module load BUSCO/5.7.1

INFILE=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/01.QC/01.busco/gtf_transcriptome.fasta
OUTFILE=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/01.QC/01.busco/A_najas_busco

source $AUGUSTUS_CONFIG_COPY
busco -i $INFILE -o $OUTFILE -l $BUSCO_LINEAGE_SETS/hemiptera_odb10/ -m tran -c 10 -f 
