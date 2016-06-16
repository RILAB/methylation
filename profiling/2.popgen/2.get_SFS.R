### Jinliang Yang
### June 16th, 2016
### purpose: get SFS for features

library(GenomicFeatures)
gff_file <- system.file("extdata", "GFF3_files", "a.gff3", package="GenomicFeatures")
txdb <- makeTxDbFromGFF(gff_file, format="gff3")
txdb
exonsBy(txdb, by="gene")




library("data.table", lib="~/bin/Rlib")


getsfs <- function(context="CG", cols=3:22, BINSIZE=100){
    
    exon <- fread("largedata/vcf_files/teo20_RA_exon.txt")
    cg <- exon[ V2 == context] #9270420      22
    
    cg <- as.data.frame(cg)
    cg[cg=="."] <- "NA"
    cg[, cols] <- apply(cg[, cols], 2, as.numeric)
    
    cg$chr <- gsub("_.*", "", cg$V1)
    cg$pos <- as.numeric(as.character(gsub(".*_", "", cg$V1)))
    
    cg$bin <- paste(cg$chr, round(cg$pos/BINSIZE, 0), sep="_")
    
    
    #.SD is a data.table and holds all the values of all columns, except the one specified in by.
    cg <- as.data.table(cg)
    res <- cg[, lapply(.SD, mymean), by=bin, .SDcols = paste0("V",3:22)]
    
    res <- as.data.frame(res)
    f <- apply(res[, -1], 1, getcount)
    sfs <- table(f)
}

mymean <- function(x){
    return(mean(x, na.rm=T))
}

getcount <- function(x, mmin=0.3, mmax=0.7){
    n0 <- sum(x < mmin)
    n2 <- sum(x > mmax)
    n1 <- sum(x >= mmin & x <= mmax)
    return(2*n2+n1)
}


sfs <- getsfs(context="CG", cols=3:22, BINSIZE=100)
write.table(mysfs, "cache/sfs_test.csv", sep=",", row.names=FALSE, quote=FALSE)

    
