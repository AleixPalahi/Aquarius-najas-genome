# Load modules
module load bioinfo-tools
module load bwa/0.7.18
module load samtools/1.20


## Create varibles
REFERENCE=/proj/snic2019-35-58/water_strider/Aleix/Anajas_genome_assembly/9_order_chromosomes/Anajas_masked_genome.fa
SAMPLE=$1


# Run bwa for mapping
# IMPORTANT: Refrence genome needs to be indexed with bwa index beforehand!
# This can be done by running the next line:
#bwa index $REFERENCE

bwa mem -t 8 -M $REFERENCE -R "@RG\tID:$1\tSM:$1\tPL:ILLUMINA" \
 /proj/snic2019-35-58/water_strider/Aleix/Anajas_pop_genomics/2-trimgalore/trimmed_fastq/$1*val_1.fq.gz \
 /proj/snic2019-35-58/water_strider/Aleix/Anajas_pop_genomics/2-trimgalore/trimmed_fastq/$1*val_2.fq.gz > $1.sam

samtools flagstat $1.sam > $1.sam.flagstat &
samtools view -b -f 3 $1.sam > $1.pairs.bam
samtools flagstat $1.pairs.bam > $1.pairs.bam.flagstat