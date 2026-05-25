# Load modules
module load bioinfo-tools
module load RepeatModeler/2.0.4
module load RepeatMasker/4.1.5


# Philipp thesis pdf page 154 repeatmasker settings: -xsmall -s -u -engine ncbi -gff

INPUT_DIR=/proj/snic2019-35-58/water_strider/Aleix/Anajas_genome_assembly
AN_REF_GENOME=$INPUT_DIR/delivery_assembly/files/HiC_Scaffolding_Results/04-JBAT/review1/Anajas_std_settings.p_ctg.yahs.review1.FINAL.fa
LIBRARIES_DIR=/proj/snic2019-35-58/water_strider/Aleix/Anajas_genome_assembly/8_TE_annotation_and_masking/Aquarius_najas


RepeatMasker -lib $LIBRARIES_DIR/Aquarius_najas-families.fa -xsmall -s -u -engine ncbi -gff -pa 20 $AN_REF_GENOME