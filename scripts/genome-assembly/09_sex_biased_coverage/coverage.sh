# Load packages.
module load SAMtools/1.22-GCC-13.3.0
module load mosdepth/0.3.12-GCC-13.3.0


# Copy BAM paired files.
cp /proj/snic2019-35-58/water_strider/Aleix/Anajas_pop_genomics/03-mapping/mapped_files/FR01_*.dedup.bam .

# Sort and index the bam files.
for bam in FR01_*.dedup.bam; do
    base=${bam%.dedup.bam}
    samtools sort -@ 8 -o ${base}.dedup.sorted.bam "$bam"
    samtools index -@ 8 ${base}.dedup.sorted.bam
done

# Run mosdepth to obtain coverage estimates in 1Mb windows.
for bam in FR01_*.dedup.sorted.bam; do
    prefix=${bam%.dedup.sorted.bam}
    mosdepth --threads 8 --by 1000000 "$prefix" "$bam"
done


#samtools sort -o FR01_M01.sorted.bam FR01_M01.pairs.bam
samtools index FR01_M01.sorted.bam
samtools sort -o FR01_M02.sorted.bam FR01_M02.pairs.bam
samtools index FR01_M02.sorted.bam
samtools sort -o FR01_M03.sorted.bam FR01_M03.pairs.bam
samtools index FR01_M03.sorted.bam
samtools sort -o FR01_F01.sorted.bam FR01_F01.pairs.bam
samtools index FR01_F01.sorted.bam
samtools sort -o FR01_F02.sorted.bam FR01_F02.pairs.bam
samtools index FR01_F02.sorted.bam
samtools sort -o FR01_F03.sorted.bam FR01_F03.pairs.bam
samtools index FR01_F03.sorted.bam


# Run mosdepth to obtain coverage estimates in 1Mb windows.
mosdepth --threads 8 --by 1000000 FR01_M01_cov FR01_M01.sorted.bam
mosdepth --threads 8 --by 1000000 FR01_M02_cov FR01_M02.sorted.bam
mosdepth --threads 8 --by 1000000 FR01_M03_cov FR01_M03.sorted.bam
mosdepth --threads 8 --by 1000000 FR01_F01_cov FR01_F01.sorted.bam
mosdepth --threads 8 --by 1000000 FR01_F02_cov FR01_F02.sorted.bam
mosdepth --threads 8 --by 1000000 FR01_F03_cov FR01_F03.sorted.bam


# Unzip the final files.
gunzip *regions.bed.gz
