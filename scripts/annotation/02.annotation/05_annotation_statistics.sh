#!/bin/bash
#SBATCH -A uppmax2025-2-17
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 1:30:00
#SBATCH -J agat_stats
#SBATCH -o 20251117_AGAT_stats.log


module load bioinfo-tools AGAT/1.3.2

GTF=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/A_najas/braker/braker.gtf
OUTDIR=/proj/snic2019-35-58/water_strider/ingo/data/intermediate/nobackup/02.annotation/01.QC/03.AGAT_stats

echo "############"
echo $GTF
    
agat_sp_statistics.pl -gff $GTF -o $OUTDIR/agat_stats.txt

# extract relevant information
echo "unfiltered_stats"> annot_stats_agat.txt

echo "############" >> annot_stats_agat.txt
echo $ANNOT_DIR >> annot_stats_agat.txt
UNFILTERED_STATS=$OUTDIR/agat_stats.txt
    
grep "Number of gene" -m 1 $UNFILTERED_STATS >> annot_stats_agat.txt # only get first occurence since it repeats all the statistics for only the longest isoforms again
grep "Number of transcript" -m 1 $UNFILTERED_STATS >> annot_stats_agat.txt
grep "mean exons per transcript" -m 1 $UNFILTERED_STATS >> annot_stats_agat.txt
grep "mean transcript length (bp)"  -m 1 $UNFILTERED_STATS >> annot_stats_agat.txt
grep "mean exon length (bp)"  -m 1 $UNFILTERED_STATS >> annot_stats_agat.txt
grep "Number gene overlapping" -m 1 $UNFILTERED_STATS >> annot_stats_agat.txt
grep "Number of single exon gene" -m 1 $UNFILTERED_STATS >> annot_stats_agat.txt
