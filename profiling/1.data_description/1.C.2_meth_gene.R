### Jinliang Yang
### Feb 17th, 2016

# each gene was divided into 20 bins (5% per bin).
# 5-kb regsions upstream and downstream of each gene were divided into 100-bp bins.

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

bed4gene$seqname <- as.character(bed4gene$seqname)
bed4gene <- bed4gene[order(bed4gene$seqname, bed4gene$start),]
write.table(bed4gene, "~/dbcenter/AGP/AGPv2/FGSv2.bed4", row.names=FALSE, col.names=FALSE, quote=FALSE, sep="\t")


library(plyr)
cut_bin <- function(inputdf, bins=20){
    
    listOfDataFrames <- lapply(1:nrow(inputdf), function(i){
        s <- inputdf$start[i]
        e <- inputdf$end[i]
        len <- round(( e - s)/bins, 0)
        tem <- data.frame(seqname=inputdf$seqname[i], start= s + len*(1:bins -1), 
                          end = s + len*(1:bins), attribute=paste(inputdf$attribute[i], 1:bins, sep="_"))
        tem$end[bins] <- e
        return(tem)
    })
    df <- ldply(listOfDataFrames, data.frame)
    return(df)
}

#########
gene20bins <- cut_bin(inputdf=bed4gene, bins=20)
write.table(bed4gene, "~/dbcenter/AGP/AGPv2/FGSv2_gene20bins.bed4", row.names=FALSE, 
            col.names=FALSE, quote=FALSE, sep="\t")


get_bins <- function(inputdf, binsize){
    
    listOfDataFrames <- lapply(1:nrow(inputdf), function(i){
        s <- inputdf$start[i]
        e <- inputdf$end[i]
        len <- round(( e - s)/bins, 0)
        tem <- data.frame(seqname=inputdf$seqname[i], start= s + len*(1:bins -1), 
                          end = s + len*(1:bins), attribute=paste(inputdf$attribute[i], 1:bins, sep="_"))
        tem$end[bins] <- e
        return(tem)
    })
    df <- ldply(listOfDataFrames, data.frame)
    
} 
up_down_bin <- function(gene, distance=5000, binsize=100){
    
    sub1up <- sub1down <- subset(gene, strand=="+")
    sub2up <- sub2down <- subset(gene, strand=="-")
    
    sub1up$end <- sub1up$start -1
    sub1up$start <- sub1up$start - distance - 2
    
    
    
    return(df)
}

