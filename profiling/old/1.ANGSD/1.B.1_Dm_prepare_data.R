### Jinliang Yang
### Feb 17th, 2016

bs <- fread()


files <- "/group/jrigrp4/BS_teo20/BSMAP_output/JRH2_methratio.out"

bed <- read.table(files[1], header=FALSE, nrows=10000)
names(bed) <- c("chr", "start", "end", "geneid", "chr2", "c1", "c2", "info", "ratio", "strand")

gid <- as.character(unique(bed$geneid))

gene <- subset(bed, geneid %in% gid[1])

gene$context <- gsub(":.*", "", gene$info)
