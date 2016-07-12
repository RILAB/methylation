
##########################################################################################################################
#
# COMETgazer suite for methylation analysis
# 
# By: Emanuele Libertini
#
# OORTcloud : bash script for counting COMET distributions according to methylation level
#
# Input : text files representing COMET segmentations with the following format:
#          block | chr | start | stop | meth | oscillator | rounded OM value | size | max | min | average | range
#
# Output : three files, one for each of the count distributions (one for each COMET type) to be read in for DMC analysis
#
##########################################################################################################################


for chrom in `seq 1 22` 
do
R --no-save --verbose <<EOF

library(IRanges)
library(GenomicFeatures)
library(Rsamtools)
library(rtracklayer)
#library(BSgenome.Hsapiens.UCSC.hg19)
library(Repitools)

chr9.methylation.blocks <- read.table("chr9.blocks.verified.txt", header=T)
chr9.methylation.blocks[,2] <- paste("chr", chr9.methylation.blocks[,2], sep="")

chr9.meth.GR <- with(chr9.methylation.blocks, GRanges(chr, IRanges(start,stop), strand="+", score=round(average*1000)))

chr9.meth.low.GR <- subset(chr9.meth.GR, elementMetadata(chr9.meth.GR)[,1] <= 330)
chr9.meth.medium.GR <- subset(chr9.meth.GR, elementMetadata(chr9.meth.GR)[,1] > 330 & elementMetadata(chr9.meth.GR)[,1] < 660)
chr9.meth.high.GR <- subset(chr9.meth.GR, elementMetadata(chr9.meth.GR)[,1] >= 660)

chr.lengths <- c(800, 200, 200)
names(chr.lengths) <- c("chr1", "chr2", "chr3")
genome.windows.1HK <- genomeBlocks(chr.lengths, width=100000) 

# Subset methylation blocks by level

chr9.meth.high.counts.1HK <- annotationBlocksCounts(chr9.meth.high.GR, anno=genome.windows.1HK)
chr9.meth.high.counts.1HK.df <- data.frame(as.data.frame(genome.windows.1HK), chr9.meth.high.counts.1HK)

chr9.meth.high.counts.1HK.GR <- with(chr9.meth.high.counts.1HK.df, 
                                     GRanges(seqnames, IRanges(start,end), strand="+", score= chr9.meth.high.counts.1HK.df[,6]))

export.bedGraph(chr9.meth.high.counts.1HK.GR  , "chr9.methylation.blocks.domains.high.1HK.bedGraph")

chr9.meth.medium.counts.1HK <- annotationBlocksCounts(chr9.meth.medium.GR, anno=genome.windows.1HK)
chr9.meth.medium.counts.1HK.df <- data.frame(as.data.frame(genome.windows.1HK), chr9.meth.medium.counts.1HK)

chr9.meth.medium.counts.1HK.GR <- with(chr9.meth.medium.counts.1HK.df, GRanges(seqnames, IRanges(start,end), strand="+", score= chr9.meth.medium.counts.1HK.df[,6]))

export.bedGraph(chr9.meth.medium.counts.1HK.GR  , "chr9.methylation.blocks.domains.medium.1HK.bedGraph")

chr9.meth.low.counts.1HK <- annotationBlocksCounts(chr9.meth.low.GR, anno=genome.windows.1HK)
chr9.meth.low.counts.1HK.df <- data.frame(as.data.frame(genome.windows.1HK), chr9.meth.low.counts.1HK)

chr9.meth.low.counts.1HK.GR <- with(chr9.meth.low.counts.1HK.df, GRanges(seqnames, IRanges(start,end), strand="+", score= chr9.meth.low.counts.1HK.df[,6]))

export.bedGraph(chr9.meth.low.counts.1HK.GR  , "chr9.methylation.blocks.domains.low.1HK.bedGraph")



# Assemble individual chromosomes counts in one count distribution

for t in `seq 1 22`


chr$t.high <- read.table("chr$t.methylation.blocks.domains.high.1HK.bedGraph", header=F)
chr$t.high <- subset(chr$t.high, chr$t.high[,1] == "chr$t")
write.table(chr$t.high[,4], "chr$t.high.txt", sep="\t", quote=F, row.names=F, col.names=F)

chr$t.medium <- read.table("chr$t.methylation.blocks.domains.medium.1HK.bedGraph", header=F)
chr$t.medium <- subset(chr$t.medium, chr$t.medium[,1] == "chr$t") 
write.table(chr$t.medium[,4], "chr$t.medium.txt", sep="\t", quote=F, row.names=F, col.names=F)

chr$t.low <- read.table("chr$t.methylation.blocks.domains.low.1HK.bedGraph", header=F)         
chr$t.low <- subset(chr$t.low, chr$t.low[,1] == "chr$t")                 
write.table(chr$t.low[,4], "chr$t.low.txt", sep="\t", quote=F, row.names=F, col.names=F)
EOF

cat chr$t.high.txt >> high.txt
cat chr$t.low.txt >> low.txt
cat chr$t.medium.txt >> medium.txt

done