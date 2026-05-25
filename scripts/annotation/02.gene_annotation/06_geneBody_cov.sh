#!/bin/bash
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 10:00:00
#SBATCH -J geneBody_coverage
#SBATCH -o 20YYMMDD_geneBody_coverage.log
#SBATCH --mail-type=END

ml bioinfo-tools rseqc/2.6.4

BAMDIR=/path/to/bams/
BED=/path/to/braker.bed
OUTDIR=/path/to/geneBodyCov
    
geneBody_coverage.py -r $BED -i $BAMDIR/ -o ${OUTDIR}/ -f 'png'
