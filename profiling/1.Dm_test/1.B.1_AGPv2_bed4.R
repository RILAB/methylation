### Jinliang Yang
### Feb 17th, 2016


######################## Filtering the duplicated annotation #################
fgsv2 <- read.table("~/dbcenter/AGP/AGPv2/ZmB73_5b_FGS.gff", header=FALSE)
names(fgsv2) <- c("seqname", "source", "feature", "start", "end", "score",
                  "strand", "frame", "attribute")

gene <- subset(fgsv2, feature=="gene")

gene$attribute <- gsub("ID=", "", gene$attribute)
gene$attribute <- gsub(";.*", "", gene$attribute)
gene <- subset(gene, seqname %in% 1:10)
#39423

bed4gene <- gene[, c("seqname", "start", "end", "attribute")]
bed4gene$start <- bed4gene$start - 1

bed4gene$seqname <- as.numeric(as.character(bed4gene$seqname))
bed4gene <- bed4gene[order(bed4gene$seqname, bed4gene$start),]
write.table(bed4gene, "~/dbcenter/AGP/AGPv2/FGSv2.bed4", row.names=FALSE, col.names=FALSE, quote=FALSE, sep="\t")

