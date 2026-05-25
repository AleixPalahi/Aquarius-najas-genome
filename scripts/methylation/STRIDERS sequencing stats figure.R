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
library(tidyr)
#BiocManager::install("plyranges")
library(plyranges)


#pac Bio#
setwd("C:/Users/joshu381/OneDrive - Uppsala universitet/Documents/PhD/UPPMAX/water strider Aleix/local scripts/RDS")
pb.gr<-readRDS("pb.gr.rds")
pb.gr

summary(pb.gr@elementMetadata@listData$coverage)

#Repeats####
setwd("C:/Users/joshu381/OneDrive - Uppsala universitet/Documents/PhD/UPPMAX/water strider Aleix/local scripts/RDS")
TE.gr<-readRDS("TE_gff.gr.rds")
TE.gr

repeats.gr<-readRDS("repeats.gr.rds")
repeats.gr

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


#####
pb_cov <- pmin(mcols(pb.gr)$coverage, 150)


# Combine into one dataframe for ggplot
df <- data.frame(
  coverage = c(pb_cov),
  dataset = factor(c(
    rep("PacBio", length(pb_cov))
  ))
)


# Plot filled density curves with raw coverage
p1<-ggplot(df, aes(x = coverage)) +
  geom_density(alpha=0.9,size = 0.7, adjust = 1.5,color = "black") +
  coord_cartesian(xlim = c(5, 150))+
  scale_fill_brewer(palette = "Set3")+
  theme_minimal(base_size = 20) +
  labs(x = "Coverage", 
       y = "Density", 
       title = "Smoothed Coverage Distribution")
p1

#pie charts#


pb.gr

gff.genes.TSS.gr
gff.genes.promoters.gr
gff.gene.bodies.gr
cpg_islands.gr
TE.gr
repeats.gr

pb.gr$category <- "Other"  # default

# 1. TSS
hits <- findOverlaps(pb.gr, gff.genes.TSS.gr)
pb.gr$category[queryHits(hits)] <- "TSS"

# 2. Promoters (only those not already assigned)
hits <- findOverlaps(pb.gr[pb.gr$category == "Other"], gff.genes.promoters.gr)
pb.gr$category[pb.gr$category == "Other"][queryHits(hits)] <- "Promoter"

# 3. Gene bodies
hits <- findOverlaps(pb.gr[pb.gr$category == "Other"], gff.gene.bodies.gr)
pb.gr$category[pb.gr$category == "Other"][queryHits(hits)] <- "Gene Body"

# 4. CpG islands
hits <- findOverlaps(pb.gr[pb.gr$category == "Other"], cpg_islands.gr)
pb.gr$category[pb.gr$category == "Other"][queryHits(hits)] <- "CpG Island"

# 5. Transposable elements
hits <- findOverlaps(pb.gr[pb.gr$category == "Other"], TE.gr)
pb.gr$category[pb.gr$category == "Other"][queryHits(hits)] <- "TE"

# 6. Repeats
hits <- findOverlaps(pb.gr[pb.gr$category == "Other"], repeats.gr)
pb.gr$category[pb.gr$category == "Other"][queryHits(hits)] <- "Repeat"

category_counts_pacbio <- as.data.frame(table(pb.gr$category))
colnames(category_counts_pacbio) <- c("Category", "Count")
category_counts_pacbio

category_counts_pacbio$percent <- round(100 * category_counts_pacbio$Count / sum(category_counts_pacbio$Count), 1)

category_counts_pacbio$Category <- factor(category_counts_pacbio$Category,
                                   levels = c("TSS", "Promoter", "Gene Body", "CpG Island", "TE", "Repeat", "Other")
)


p2<-ggplot(category_counts_pacbio, aes(x = "", y = Count, fill = Category)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  scale_fill_brewer(palette = "Set3")+
  theme_void() +
  ggtitle("CpG composition")
p2
#pacbio#
pb.gr$category <- "Other"

hits <- findOverlaps(pb.gr, gff.genes.TSS.gr)
pb.gr$category[queryHits(hits)] <- "TSS"

hits <- findOverlaps(pb.gr[pb.gr$category == "Other"], gff.genes.promoters.gr)
pb.gr$category[pb.gr$category == "Other"][queryHits(hits)] <- "Promoter"

hits <- findOverlaps(pb.gr[pb.gr$category == "Other"], gff.gene.bodies.gr)
pb.gr$category[pb.gr$category == "Other"][queryHits(hits)] <- "Gene Body"

hits <- findOverlaps(pb.gr[pb.gr$category == "Other"], cpg_islands.gr)
pb.gr$category[pb.gr$category == "Other"][queryHits(hits)] <- "CpG Island"

hits <- findOverlaps(pb.gr[pb.gr$category == "Other"], TE.gr)
pb.gr$category[pb.gr$category == "Other"][queryHits(hits)] <- "TE"

hits <- findOverlaps(pb.gr[pb.gr$category == "Other"], repeats.gr)
pb.gr$category[pb.gr$category == "Other"][queryHits(hits)] <- "Repeat"


mcols(pb.gr)
#combine data
pb_df <- data.frame(score = pb.gr$score, category = pb.gr$category, dataset = "PacBio")


# duplicate for genome-wide
all_df <- pb_df
all_df$category <- "All CpGs"

meth_all <- bind_rows(pb_df, all_df)

meth_binned <- meth_all %>%
  mutate(
    bin = cut(
      score,
      breaks = seq(0, 100, by = 20),
      include.lowest = TRUE,
      right = FALSE,
      labels = paste0(seq(0, 80, by = 20), "-", seq(20, 100, by = 20))
    )
  ) %>%
  group_by(dataset, category, bin) %>%
  summarise(n = dplyr::n(), .groups = "drop_last") %>%  # ✅ fix here
  mutate(percent = n / sum(n) * 100) %>%
  ungroup()
meth_binned

meth_mean <- meth_all %>%
  group_by(dataset, category) %>%
  summarise(
    mean_meth = mean(score, na.rm = TRUE),
    n_cpg = dplyr::n(),
    .groups = "drop"
  )
meth_mean$label <- paste0(
  "Mean = ", round(meth_mean$mean_meth, 1), "%\n",
  "n = ", format(meth_mean$n_cpg, big.mark = ",")
)

meth_binned$category <- factor(
  meth_binned$category,
  levels = c("All CpGs","TSS","Promoter","Gene Body","CpG Island","TE","Repeat","Other")
)

meth_mean$category <- factor(
  meth_mean$category,
  levels = levels(meth_binned$category)
)
p3 <- ggplot(meth_binned, aes(x = bin, y = percent, fill = dataset)) +
  geom_col(position = "dodge", color = "black") +
  facet_wrap(~ category, scales = "free_y", nrow = 1) +
  scale_fill_brewer(palette = "Set3") +
  geom_text(
    data = meth_mean,
    aes(x = 3, y = 90, label = label),
    inherit.aes = FALSE,
    size = 4,
    lineheight = 1.1
  ) +
  labs(
    x = "CpG Methylation (%)",
    y = "Percentage of CpGs"
  ) +
  theme_minimal(base_size = 20) +
  coord_cartesian(ylim = c(0, 100)) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    strip.text = element_text(face = "bold"),
    legend.position = "none"
  )

p3

grid.arrange(
  p3,
  p2,
  nrow = 1,
  widths = c(5, 1)   
)
