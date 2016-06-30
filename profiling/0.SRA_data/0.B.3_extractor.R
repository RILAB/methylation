### Jinliang
### June 27th, 2016

library(data.table)
library(tidyr)
library(GenomicRanges)

###########
meth1 <- fread("largedata/bismark/SRR850332_pe.CX_report.txt")

exon1 <- meth1[V6 == "CG"]



###########
get_mean_var <- function(context= exon1){
    #exon <- fread("largedata/vcf_files/teo20_RA_exon.txt")
    #cg <- exon[ V2 == "CG"] #9270420      22
    gene <- get_feature(gff="~/dbcenter/AGP/AGPv2/ZmB73_5b_FGS.gff", features="gene")
    gr0 = with(gene, GRanges(seqnames=seqname, IRanges(start=start, end=end), strand=strand, geneid=attribute ))
    
    ###########
    gr1 = with(context, GRanges(seqnames=V1, IRanges(start=V2, end=V2), strand=V3, C=V4, CT=V5))
    ex1 = findOverlaps(gr0, gr1)
    #ranges(gr0)[queryHits(ex1)] = ranges(gr1)[subjectHits(ex1)]
    
    context$geneid <- "N"
    context$geneid[subjectHits(ex1)] <- gr0$geneid[queryHits(ex1)]
    
    subcon <- context[geneid != "N"]
    subcon$RA <- subcon$V4/(subcon$V4 + subcon$V5)
    
    res <- subcon[, .(mm=mymean(RA)), by=geneid]
    return(res)
}


write.table(res, "cache/maize_gene_mean_sample1.csv", sep=",", row.names=FALSE, quote=FALSE)


res <- read.csv("cache/stat_exon_mean_var.csv")
gbm <- subset(res, mm > 0.8)

mz <- read.csv("cache/maize_gene_mean_sample1.csv")
g2 <- subset(mz, mm > 0.8)

sum(gbm$geneid %in% g2$geneid)


