### Jinliang
### June 27th, 2016

library(data.table)
library(tidyr)
library(GenomicRanges)

###########
meth1 <- fread("largedata/bismark/SRR850332_pe.CX_report.txt")

exon1 <- meth1[V6 == "CG"]




###########
get_mean_var <- function(cg= exon1){
    #exon <- fread("largedata/vcf_files/teo20_RA_exon.txt")
    #cg <- exon[ V2 == "CG"] #9270420      22
    gff <- read.table("~/dbcenter/AGP/AGPv2/ZmB73_5b_FGS.gff")
    names(gff) <- c("seqname", "source", "feature", "start", "end", "score",
                    "strand", "frame", "attribute")
    
    gene <- subset(gff, feature=="gene")
    gene$attribute <- gsub("ID=", "", gene$attribute)
    gene$attribute <- gsub(";.*", "", gene$attribute)
    gene <- subset(gene, seqname %in% 1:10)
    
    gene$strand <- as.character(gene$strand)
    gr0 = with(gene, GRanges(seqnames=seqname, IRanges(start=start, end=end), strand=strand, geneid=attribute ))
    
    ###########
    gr1 = with(cg, GRanges(seqnames=V1, IRanges(start=V2, end=V2), strand=V3, C=V4, CT=V5))
    ex1 = findOverlaps(gr0, gr1)
    ranges(gr0)[queryHits(ex1)] = ranges(gr1)[subjectHits(ex1)]
    
    gr1$geneid[subjectHits(ex1)] <- gr0$geneid[queryHits(ex1)]
    
    gr2 <- as.data.frame(gr1)
    gr2 <- as.data.table(gr2)
    
    
    res <- gr2[, .(mm=mean(mean), mv=mean(var)), by=geneid]
    write.table(res, "cache/stat_exon_mean_var.csv", sep=",", row.names=FALSE, quote=FALSE)
    
}




res <- gr2[, .(rg=round(rescale(start, to=c(1, 1000)), 0), mm=mean), by=geneid]
res2 <- res[, .(mm=mean(mm)), by=rg]
res2 <- res2[order(res2$rg),]
write.table(res2, "cache/test_res.csv", sep=",", row.names=FALSE, quote=FALSE)


res <- read.csv("cache/test_res.csv")


gene1 <- subset(gr2, geneid == "GRMZM2G354611")

library(scales)
gene1$new <- round(rescale(gene1$start, to=c(1, 1000)), 0)






