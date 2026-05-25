####import data#####

library(BiocManager)
library("methylKit")
# Annotation package
library("genomation")
library("GenomicRanges")
library('data.table')
library(ggplot2)
library(reshape2)
library(dplyr)
library(GenomicRanges)
#BiocManager::install("regioneR")
library(regioneR)
library("gridExtra")
library(stringr)
library(ggrepel)

###Pacbio#####
# Define the path (change if your filename is different)
bed_path <- "C:/Users/joshu381/OneDrive - Uppsala universitet/Documents/PhD/UPPMAX/water strider Aleix/pacbio/m84045_230713_144057_s4.hifi.pbmm2.combined.bed.gz"

# Read the gzipped BED file, skipping comment lines
dt <- fread(
  bed_path,
  skip = "#",  # skips lines starting with #
  col.names = c("chrom", "start", "end", "mod_score", "type", "coverage", "est_mod_count", "est_unmod_count", "discretized_mod_score")
)

# Convert to GRanges (note BED is 0-based, GRanges is 1-based)
pb.gr <- GRanges(
  seqnames = dt$chrom,
  ranges = IRanges(start = dt$start + 1, end = dt$end),
  strand = "*",
  mod_score = dt$mod_score,
  type = dt$type,
  coverage = dt$coverage,
  est_mod_count = dt$est_mod_count,
  est_unmod_count = dt$est_unmod_count,
  discretized_mod_score = dt$discretized_mod_score
)

# Preview
pb.gr
# Rename metadata column
colnames(mcols(pb.gr))[colnames(mcols(pb.gr)) == "discretized_mod_score"] <- "score"
colnames(mcols(pb.gr))[colnames(mcols(pb.gr)) == "est_mod_count"] <- "methylated_cpg"
colnames(mcols(pb.gr))[colnames(mcols(pb.gr)) == "est_unmod_count"] <- "unmethylated_cpg"

pb.gr<-pb.gr[pb.gr$coverage >= 5]

setwd("C:/Users/joshu381/OneDrive - Uppsala universitet/Documents/PhD/UPPMAX/water strider Aleix/local scripts/RDS")
saveRDS(pb.gr, file = "pb.gr.rds")


###TEs####
library(rtracklayer)
library(stringr)
library(tidyr)

##read in repeatmasker
setwd("C:/Users/joshu381/OneDrive - Uppsala universitet/Documents/PhD/UPPMAX/water strider Aleix/genome resources")
TE_gff<-read.delim("TE_Anajas_masked_genome.gff", fill=TRUE, comment.char="#", header=F)
TE_gff
TE_gff2 <- TE_gff %>%
  mutate(
    ID = str_extract(V9, "ID=\\d+") %>% str_remove("ID="),
    motif = str_extract(V9, "Target Motif:[^ ]+") %>% str_remove("Target Motif:")
  ) %>%
  extract(V9, into = c("cons_start","cons_end"),
          regex = ".* (\\d+) (\\d+)$", remove = FALSE)

TE_gff2

TE_gff.gr <- GRanges(
  seqnames = TE_gff2$V1,
  ranges = IRanges(start = TE_gff2$V4, end = TE_gff2$V5),
  strand = TE_gff2$V7,
  source = TE_gff2$V2,
  type = TE_gff2$V3,
  score = TE_gff2$V6,
  phase = TE_gff2$V8,
  ID = TE_gff2$ID,
  motif = TE_gff2$motif,
  cons_start = as.numeric(TE_gff2$cons_start),
  cons_end = as.numeric(TE_gff2$cons_end)
)

TE_gff.gr

repeats.gr <- TE_gff.gr[
  str_detect(TE_gff.gr$motif, "^\\(") |     # (ATATA)n style repeats
    str_detect(TE_gff.gr$motif, "rich")       # low complexity like A-rich
]

repeats.gr

TE_gff.gr <- TE_gff.gr[
  !(str_detect(TE_gff.gr$motif, "^\\(") |   # simple repeats like (AT)n
      str_detect(TE_gff.gr$motif, "rich"))    # low complexity like A-rich
]

TE_gff.gr


TE_gff.gr<- GRanges(
  seqnames = TE_gff$V1,
  ranges = IRanges(start = TE_gff$V4, end = TE_gff$V5),
  strand = TE_gff$V7,
  source = TE_gff$V2,
  type = TE_gff$V3,
  score = TE_gff$V6,
  phase = TE_gff$V8,
  attributes = TE_gff$V9
)
TE_gff.gr

attr <- strsplit(TE_gff$V9, ";")
attr_list <- lapply(attr, function(x) {
  sapply(strsplit(x, "="), `[`, 2)
})

mcols(TE_gff.gr)$ID <- sapply(attr_list, `[`, 1)
mcols(TE_gff.gr)$Target <- sapply(attr_list, `[`, 2)
TE_gff.gr

setwd("C:/Users/joshu381/OneDrive - Uppsala universitet/Documents/PhD/UPPMAX/water strider Aleix/local scripts/RDS")
saveRDS(TE_gff.gr, file = "TE_gff.gr.rds")
saveRDS(repeats.gr, file = "repeats.gr.rds")



####CpG islands from EMBOSS cpgplot function####
library(stringr)

setwd("C:/Users/joshu381/OneDrive - Uppsala universitet/Documents/PhD/UPPMAX/water strider Aleix/genome resources")
#generated with EMBOSS software By default, cpgplot defines a CpG island as a region where, over an average of 10 windows and not less than 200 bases, the calculated (%G + %C) content is over 50% and the calculated Observed/Expected ratio is over 0.6. These conditions can be modified by setting the values of the appropriate parameters.

# Read the file
lines <- readLines("CpG islands Anajas.txt")
lines
# Find chromosome lines
chrom_lines <- grep("^chr_\\d+ from", lines)

seqnames <- c()
starts <- c()
ends <- c()

for (i in seq_along(chrom_lines)) {
  
  chr_line <- lines[chrom_lines[i]]
  chr_name <- str_extract(chr_line, "^chr_\\d+")
  
  start_line <- chrom_lines[i] + 1
  end_line <- ifelse(i < length(chrom_lines),
                     chrom_lines[i+1] - 1,
                     length(lines))
  
  block <- lines[start_line:end_line]
  
  matches <- str_match(block, "Length\\s+\\d+\\s+\\((\\d+)\\.\\.(\\d+)\\)")
  valid <- complete.cases(matches)
  
  if (any(valid)) {
    starts <- c(starts, as.numeric(matches[valid,2]))
    ends <- c(ends, as.numeric(matches[valid,3]))
    seqnames <- c(seqnames, rep(chr_name, sum(valid)))
  }
}

cpg_islands.gr <- GRanges(
  seqnames = seqnames,
  ranges = IRanges(start = starts, end = ends),
  strand = "*"
)

###CpG island shores and shelves####
cpg_islands.gr
summary(cpg_islands.gr@ranges@width)
# Total length of all CpG islands
total_cpg_width <- sum(width(cpg_islands.gr))

# Print result
total_cpg_width

#fix the width to 8200#
# Combine and clean up
cpg_islands_up_down.gr <- resize(
  cpg_islands.gr,
  width = 8200,  
  fix = "center",
  ignore.strand = TRUE
)
summary(cpg_islands_up_down.gr@ranges@width)

#Genome####
setwd("C:/Users/joshu381/OneDrive - Uppsala universitet/Documents/PhD/UPPMAX/water strider Aleix/genome resources")
# annotations
gff <- rtracklayer::import("A_najas_filt_final.gff")
gff

gff.genes.gr <- gff[gff$type == "gene"]
gff.genes.gr
# Columns to keep: all up to merged_ID + 'names' if it exists
cols_to_keep <- c(seq_len(match("merged_ID", colnames(mcols(gff.genes.gr)))), 
                  which(colnames(mcols(gff.genes.gr)) %in% c("Name", "product"))
)


# Subset the metadata columns
mcols(gff.genes.gr) <- mcols(gff.genes.gr)[ , cols_to_keep]

# Check
gff.genes.gr
colnames(mcols(gff.genes.gr))
gff.genes.gr
gff.genes.gr$gene_id <- unlist(gff.genes.gr$ID)

gff.genes.gr$gene_name <- gff.genes.gr$gene_id

# Strand-specific resizing: remove 50bp from TSS
gff.gene.bodies.gr <- gff.genes.gr

# + strand: TSS at start → fix = "end", shrink from start
gff.gene.bodies.gr[strand(gff.gene.bodies.gr) == "+"] <- resize(
  gff.gene.bodies.gr[strand(gff.gene.bodies.gr) == "+"],
  width = pmax(width(gff.gene.bodies.gr[strand(gff.gene.bodies.gr) == "+"]) - 50, 0),
  fix = "end"
)

# - strand: TSS at end → fix = "start", shrink from end
gff.gene.bodies.gr[strand(gff.gene.bodies.gr) == "-"] <- resize(
  gff.gene.bodies.gr[strand(gff.gene.bodies.gr) == "-"],
  width = pmax(width(gff.gene.bodies.gr[strand(gff.gene.bodies.gr) == "-"]) - 50, 0),
  fix = "start"
)

gff.gene.bodies.gr
gff.genes.gr

gff.genes.TSS.gr <- promoters(
  gff.genes.gr,
  upstream = 50,
  downstream = 50
)
gff.genes.TSS.gr

gff.genes.promoters.gr <- promoters(gff.genes.TSS.gr, upstream = 2950, downstream = 0)
gff.genes.promoters.gr

gff.genes.5000.TSS.5000.gr <- promoters(gff.genes.gr, upstream = 5000, downstream = 5000)
gff.genes.5000.TSS.5000.gr
#



#introns exons#
library(GenomicFeatures)
setwd("C:/Users/joshu381/OneDrive - Uppsala universitet/Documents/PhD/UPPMAX/water strider Aleix/genome resources")
# Subset exons
gff.exons.gr <- gff[gff$type == "exon"]

gff.genes.gr
# Split gene bodies and exons by gene_id
gene_by_tx <- split(gff.genes.gr, gff.genes.gr$gene_id)
exons_by_tx <- split(gff.exons.gr, gff.exons.gr$gene_id)

# Compute introns
gff.introns.gr <- GRanges()  # start empty

for (gid in names(gene_by_tx)) {
  gene_body <- gene_by_tx[[gid]]
  
  # check if this gene has exons
  if (!gid %in% names(exons_by_tx)) next
  exons <- exons_by_tx[[gid]]
  
  # compute introns
  introns <- setdiff(gene_body, exons)
  if (length(introns) == 0) next
  
  # Flatten GRangesList to GRanges
  if (is(introns, "GRangesList")) introns <- unlist(introns, use.names = FALSE)
  
  # Add gene_id and transcript_id
  mcols(introns)$gene_id <- gid
  mcols(introns)$transcript_id <- gid
  
  # Keep metadata columns from gene body up to "Parent"
  cols_to_keep <- seq_len(match("Parent", colnames(mcols(gene_body))))
  mcols(introns) <- cbind(mcols(introns), mcols(gene_body)[rep(1, length(introns)), cols_to_keep])
  
  # Combine with main GRanges
  gff.introns.gr <- c(gff.introns.gr, introns)
}


# Sort introns
gff.introns.gr <- sort(gff.introns.gr)
gff.introns.gr
# Optional: simplify metadata
mcols(gff.exons.gr) <- mcols(gff.exons.gr)[, c("ID","Parent")]


# Check results
gff.exons.gr
gff.introns.gr

setwd("C:/Users/joshu381/OneDrive - Uppsala universitet/Documents/PhD/UPPMAX/water strider Aleix/local scripts/RDS")
saveRDS(gff.exons.gr, file = "gff.exons.gr.rds")
gff.exons.gr <- readRDS("gff.exons.gr.rds")

setwd("C:/Users/joshu381/OneDrive - Uppsala universitet/Documents/PhD/UPPMAX/water strider Aleix/local scripts/RDS")
saveRDS(gff.introns.gr, file = "gff.introns.gr.rds")
gff.introns.gr <- readRDS("gff.introns.gr.rds")



