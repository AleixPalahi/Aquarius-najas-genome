KMER=27

module load bioinfo-tools
module load jellyfish/2.3.0
module load samtools/1.14

#bgzip -d /proj/snic2019-35-58/water_strider/Anajas_hifi/delivery/files/pr_011/ccsreads/pr_011_001/pr_011_001.ccsreads.fastq.gz > ./pr_011_001.ccsreads.fastq
jellyfish count -C -m $KMER -s 6400000000 -t 10 /proj/snic2019-35-58/water_strider/Anajas_hifi/delivery/files/pr_011/ccsreads/pr_011_001/pr_011_001.ccsreads.fastq
mv mer_counts.jf $KMER_mer_counts.jf
jellyfish histo -t 10 mer_counts_$KMER.jf > Anajas-k_$KMER.histo

# jellyfish count generates an intermediary file names mer_counts.jf, that jellyfish histo uses to generate the final file (Anajas.histo).