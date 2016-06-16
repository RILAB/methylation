### Jinliang Yang
### June 14th, 2016
### Extract RA from genomic features

#bcftools query -f '%ID\t%CO[\t%RA]\n' -r 1:0-10000 teo20_methratio.bcf -o test_RA.txt
library(farmeR)
# bcftools query -f '%ID\t%CO[\t%RA]\n' teo20_methratio.bcf -R AGPv2_bcf_exon.txt -o teo20_RA_exon.txt
shcode <- c("cd ~/Documents/Github/methylation/largedata/vcf_files",
            "bcftools query -f \'%ID\\t%CO[\\t%RA]\\n\' teo20_methratio.bcf -R AGPv2_bcf_exon.txt -o teo20_RA_exon.txt")
set_farm_job(slurmsh="slurm-script/run_bcfra.sh", shcode=shcode,
             wd=NULL, jobid="bcfra", email="yangjl0930@gmail.com",
             runinfo=c(FALSE, "bigmemh", "2"))

#bcftools query -f '%ID\t%CO[\t%RA]\n' -r 1:0-10000 teo20_methratio.bcf -o test_RA.txt
library(farmeR)

###########
library(data.table)
library(tidyr)
library(GenomicRanges)

gff <- read.table("~/dbcenter/AGP/AGPv2/ZmB73_5b_FGS.gff")
names(gff) <- c("seqname", "source", "feature", "start", "end", "score",
                "strand", "frame", "attribute")

gene <- subset(gff, feature=="gene")
gene$attribute <- gsub("ID=", "", gene$attribute)
gene$attribute <- gsub(";.*", "", gene$attribute)
gene <- subset(gene, seqname %in% 1:10)

gene$strand <- as.character(gene$strand)
gr0 = with(gene, GRanges(seqnames=seqname, IRanges(start=start, end=end), strand=strand, geneid=attribute ))


get_mean_var <- function(){
    exon <- fread("largedata/vcf_files/teo20_RA_exon.txt")
    
    cg <- exon[ V2 == "CG"] #9270420      22
    chg <- exon[ V2 == "CHG"]
    chh <- exon[ V2 == "CHH"]
    
    cg <- as.data.frame(cg)
    cg[cg=="."] <- "NA"
    cg[, 3:22] <- apply(cg[, 3:22], 2, as.numeric)
    cg$mean <- apply(cg[, 3:22], 1, function(x) mean(x, na.rm=T))
    cg$var <- apply(cg[, 3:22], 1, function(x) var(x, na.rm=T))
    sub1 <- cg[, c("V1", "mean", "var")]
    sub1$chr <- gsub("_.*", "", sub1$V1)
    sub1$pos <- gsub(".*_", "", sub1$V1)
    sub1$pos <- as.numeric(as.character(sub1$pos))
    
    gr1 = with(sub1, GRanges(seqnames=chr, IRanges(start=pos, end=pos), mean=mean, var=var))
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


