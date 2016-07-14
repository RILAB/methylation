### Jinliang Yang
### June 14th, 2016
### prepare genomic features for BCFtools


#-R, --regions-file FILE
#Regions can be specified either on command line or in a VCF, BED, or tab-delimited file (the default).
#The columns of the tab-delimited file are: CHROM, POS, and, optionally, POS_TO, where positions are 1-based and inclusive.

info <- read.table("~/dbcenter/AGP/AGPv2/ZmB73_5b_FGS_info.txt", header=T)
info <- subset(info, is_canonical == "yes")
# 39656    12


gff <- read.table("~/dbcenter/AGP/AGPv2/ZmB73_5b_FGS.gff")
names(gff) <- c("seqname", "source", "feature", "start", "end", "score",
                  "strand", "frame", "attribute")

exon <- subset(gff, feature=="exon")
exon$attribute <- gsub("Parent=", "", exon$attribute)
exon$attribute <- gsub(";.*", "", exon$attribute)
exon <- subset(exon, seqname %in% 1:10)

write.table(exon[, c("seqname", "start", "end")], "~/Documents/Github/methylation/largedata/vcf_files/AGPv2_bcf_exon.txt", 
            row.names=FALSE, col.names=FALSE, quote=FALSE, sep="\t")




