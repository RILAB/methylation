### Jinliang Yang
### June 16th, 2016
### purpose: get SFS for features

library(GenomicFeatures)
gff_file <- system.file("extdata", "GFF3_files", "a.gff3", package="GenomicFeatures")
txdb <- makeTxDbFromGFF(gff_file, format="gff3")
txdb
exonsBy(txdb, by="gene")


### Set some values 


library("data.table", lib="~/bin/Rlib")


getsfs <- function(context="CG", cols=3:22, BINSIZE=100, gbM){
    
    ### features
    gene <- get_gene()
    subgen <- subset(gene, attribute %in% gbM$geneid)
    gr0 = with(subgen, GRanges(seqnames=seqname, IRanges(start=start, end=end), strand=strand, geneid=attribute ))
    
    ### methylation
    exon <- fread("largedata/vcf_files/teo20_RA_exon.txt")
    cg <- exon[ V2 == context] #9270420      22
    cg$chr <- gsub("_.*", "", cg$V1)
    cg$pos <- as.numeric(as.character(gsub(".*_", "", cg$V1)))
    
    ###########
    gr1 = with(cg, GRanges(seqnames=chr, IRanges(start=pos, end=pos), snpid=V1, context=V2))
    ex1 = findOverlaps(gr0, gr1)
    #ranges(gr0)[queryHits(ex1)] = ranges(gr1)[subjectHits(ex1)]
    
    ids <- gr1$snpid[subjectHits(ex1)]
    
    subcg <- cg[V1 %in% ids]
    #gr2 <- as.data.frame(gr1)
    #gr2 <- as.data.table(gr2)
    
    subcg <- as.data.frame(subcg)
    subcg[subcg=="."] <- "NA"
    subcg[, cols] <- apply(subcg[, cols], 2, as.numeric)
    
    
    subcg$bin <- paste(subcg$chr, round(subcg$pos/BINSIZE, 0), sep="_")
    #.SD is a data.table and holds all the values of all columns, except the one specified in by.
    subcg <- as.data.table(subcg)
    res <- subcg[, lapply(.SD, mymean), by=bin, .SDcols = paste0("V", cols)]
    
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

get_gene <- function(){
    library(GenomicFeatures)    
    gff <- read.table("~/dbcenter/AGP/AGPv2/ZmB73_5b_FGS.gff")
    names(gff) <- c("seqname", "source", "feature", "start", "end", "score",
                    "strand", "frame", "attribute")
    
    gene <- subset(gff, feature=="gene")
    gene$attribute <- gsub("ID=", "", gene$attribute)
    gene$attribute <- gsub(";.*", "", gene$attribute)
    gene <- subset(gene, seqname %in% 1:10)
    
    gene$strand <- as.character(gene$strand)
    return(gene)
}

sfs <- getsfs(context="CHG", cols=3:22, BINSIZE=100)
write.table(sfs, "cache/sfs_test.csv", sep=",", row.names=FALSE, quote=FALSE)

write.table(sfs, "cache/sfs_gbM_98k.csv", sep=",", row.names=FALSE, quote=FALSE)


