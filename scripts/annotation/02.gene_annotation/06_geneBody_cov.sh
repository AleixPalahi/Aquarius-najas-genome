#!/bin/bash
#SBATCH -A uppmax2025-2-17
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 10:00:00
#SBATCH -J geneBody_coverage
#SBATCH -o 20251119_geneBody_coverage.log
#SBATCH --mail-type=END
#SBATCH --mail-user=ingo.mueller@ebc.uu.se

ml bioinfo-tools rseqc/2.6.4

BAMDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/01.mapping/01.bamqc/00.input/01.all
BED=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/A_najas/braker/braker.bed
OUTDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/01.mapping/04.geneBodyCov
    
geneBody_coverage.py -r $BED -i $BAMDIR/ -o ${OUTDIR}/ -f 'png'
