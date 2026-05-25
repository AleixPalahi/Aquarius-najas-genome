# Load modules
module load bioinfo-tools
module load RepeatModeler/2.0.4
module load RepeatMasker/4.1.5

# Philipp thesis pdf page 154 repeatmasker settings: -xsmall -s -u -engine ncbi -gff

INPUT_DIR=/proj/snic2019-35-58/water_strider/Aleix/Anajas_genome_assembly
AN_REF_GENOME=$INPUT_DIR/delivery_assembly/files/HiC_Scaffolding_Results/04-JBAT/review1/Anajas_std_settings.p_ctg.yahs.review1.FINAL.fa
LIBRARIES_DIR=/proj/snic2019-35-58/water_strider/Aleix/Anajas_genome_assembly/8_TE_annotation_and_masking/Aquarius_najas


#### Build custom repeat library, based on the species final, curated assembly.

# We can do this using RepeatModeler
# RepeatModeler uses a NCBI BLASTDB as input for the repeat modeling pipeline, BuildDatabase is a wrapper to make this database for all future steps

if [ -d $LIBRARIES_DIR ]; then
  echo "Directory '$LIBRARIES_DIR' already exists."
else
  mkdir -p "$LIBRARIES_DIR"
fi

cd $LIBRARIES_DIR

# this takes like 1 min for Aquarius najas.
#BuildDatabase -name Aquarius_najas $AN_REF_GENOME

# Run RpeatModeler
RepeatModeler -database Aquarius_najas -threads 20 -LTRStruct \
 -recoverDir ./RM_15207.ThuDec120905022024/

cd ..