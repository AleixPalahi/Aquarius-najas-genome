# Load modules
module load bioinfo-tools


# Create singularity executable.
#singularity build mitohifi.sif docker://ghcr.io/marcelauliano/mitohifi:master


# Create variables.
INPUT_DIR=/proj/snic2019-35-58/water_strider/Aleix/Anajas_genome_assembly/delivery_assembly/files/HiC_Scaffolding_Results/04-JBAT/review1/
OUTPUT_DIR=/proj/snic2019-35-58/water_strider/Aleix/Anajas_genome_assembly/7_mitohifi


# Create output folder.
#mkdir $OUTPUT_DIR/MitoReference


# Run findMitoReference.py
#./mitohifi.sif findMitoReference.py --species "Aquarius najas" --outfolder MitoReference --min_length 14000


./mitohifi.sif mitohifi.py -c $INPUT_DIR/Anajas_std_settings.p_ctg.yahs.review1.FINAL.fa \
 -f $OUTPUT_DIR/MitoReference/NC_012841.1.fasta \
 -g $OUTPUT_DIR/MitoReference/NC_012841.1.gb \
 -o 5 \
 -t 20