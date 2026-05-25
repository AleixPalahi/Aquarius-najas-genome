
setwd("C:/Users/joshu381/OneDrive - Uppsala universitet/Documents/PhD/UPPMAX/water strider Aleix/genome resources")

###number of CpG sites###
library(Biostrings)

genome <- readDNAStringSet("Anajas_masked_genome.fa")

# Count CpG sites for each contig
cpg_counts <- vcountPattern("CG", genome)
# Total CpGs in genome
sum(cpg_counts)
#[1] 15724693



