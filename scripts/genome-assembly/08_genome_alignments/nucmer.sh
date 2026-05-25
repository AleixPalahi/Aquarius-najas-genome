module load MUMmer/4.0.1-GCCcore-13.3.0

PREFIX=An_Ap

#nucmer -p ${PREFIX} \
# /proj/snic2019-35-58/water_strider/G.lacustris_DToL/Gerris_lacustris-GCA_951217055.1-softmasked.fa \
# /proj/snic2019-35-58/water_strider/Aleix/Anajas_genome_assembly/9_order_chromosomes/Anajas_masked_genome.fa

#delta-filter -1 ${PREFIX}.delta > ${PREFIX}_filtered.delta

show-coords -rTH -I 90 ${PREFIX}_filtered.delta > ${PREFIX}.coords
#show-coords -r -c -l ${PREFIX}_filtered.delta > ${PREFIX}.coords