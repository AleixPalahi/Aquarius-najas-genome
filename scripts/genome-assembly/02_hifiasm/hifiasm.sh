# Load modules
module load bioinfo-tools
module load Hifiasm/20210912-ab80851


# Create variables
INPUT=/proj/snic2019-35-58/water_strider/Aleix/Anajas_genome_assembly/2_adapter_removal/raw_data.filt.fastq.gz


# Run hifiasm
hifiasm -o Anajas_no_primary_assembly \
 -t 20 \
 -f0 \
 --primary \
 /proj/snic2019-35-58/water_strider/Aleix/Anajas_genome_assembly/2_adapter_removal/raw_data.filt.fastq.gz