# Load modules
module load bioinfo-tools
module load augustus/3.5.0
module load BUSCO/5.3.1

source $AUGUSTUS_CONFIG_COPY
run_BUSCO.py -i /proj/snic2019-35-58/water_strider/Aleix/Anajas_genome_assembly/delivery_assembly/files/HiC_Scaffolding_Results/04-JBAT/review1/Anajas_std_settings.p_ctg.yahs.review1.FINAL.fa \
 -o hemiptera_final_assembly \
 -l $BUSCO_LINEAGE_SETS/hemiptera_odb10/ -m genome -c 10 -f