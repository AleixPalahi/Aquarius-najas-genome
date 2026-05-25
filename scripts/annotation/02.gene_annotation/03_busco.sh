#!/bin/bash -l
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p core
#SBATCH -n 10
#SBATCH -t 4:00:00
#SBATCH -J aquarius_busco
#SBATCH -o 20YYMMDD_busco.log
#SBATCH --mail-type=END


# Load modules
module load bioinfo-tools
module load augustus/3.5.0
module load BUSCO/5.7.1

INFILE=/path/to/gtf_transcriptome.fasta
OUTFILE=/path/to/A_najas_busco

source $AUGUSTUS_CONFIG_COPY
busco -i $INFILE -o $OUTFILE -l $BUSCO_LINEAGE_SETS/hemiptera_odb10/ -m tran -c 10 -f 
