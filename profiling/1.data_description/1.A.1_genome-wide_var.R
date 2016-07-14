### Jinliang Yang
### 

library(data.table, lib="~/bin/Rlib/")

m1 <- fread("/group/jrigrp4/BS_teo20/BSMAP_round2/JRA1_methratio.txt")
m1 <- data.frame(m1)

m1$chr <- gsub("chr", "", m1$chr)
m1 <- subset(m1, chr %in% 1:10)
m1$chr <- as.numeric(as.character(m1$chr))
names(m1)[2] <- "pos"



mevar <- function(){
    maize <- fread("/group/jrigrp4/BS_teo20/3ZmInbreds_100bp_CG.tab", header=TRUE)
    maize <- as.data.frame(maize)
    
    
    
    
}

