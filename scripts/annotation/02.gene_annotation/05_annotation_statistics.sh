#!/bin/bash
#SBATCH -A uppmax20XX-X-XX
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 1:30:00
#SBATCH -J agat_stats
#SBATCH -o 20YYMMDD_AGAT_stats.log

# Original script by Milena Trabert https://github.com/milena-t/PhD_chapter1/blob/a4d374ca7238768e202e737ef272230729b6efad/bash_scripts/annotation_statistics.sh#L4

module load bioinfo-tools AGAT/1.3.2

GTF=/path/to/braker.gtf
OUTDIR=/path/to/AGAT_stats

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
