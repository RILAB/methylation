### Jinliang Yang
### April 19th, 2016
##

fgs <- read.table("largedata/Dm/FGSv2_gene.txt")
names(fgs) <- c("chr", "start", "end", "geneid")


##########
df <- read.csv("cache/res_gene_cg.csv")
df$geneid <- gsub(".*/|_cg.out", "", df$geneid)

res <- merge(fgs, df[, -1:-3], by="geneid")


pdf(file="graphs/tem2.pdf", height=4, width =10)
for(i in 1:10){
    chr <- subset(res, chr==i)
    chr <- chr[order(chr$start),]
    plot(chr$start, chr$Dm, type="l", main=paste("Chr", i))
    abline(h = 0, lty=2, lwd=3, col="grey")
}
dev.off()

df2 <- read.csv("cache/res_region_chg.csv")
df2$geneid <- gsub(".*/|_chg.out", "", df2$geneid)

df2$pos <- as.numeric(as.character(gsub(".*_", "", df2$geneid)))

chr <- subset(df2, chr==10)
chr <- chr[order(chr$pos),]
plot(chr$pos, chr$Dm, type="l")
abline(h = 0, lty=2, lwd=3, col="grey")


df3 <- read.csv("cache/res_region_chh.csv")
df3$geneid <- gsub(".*/|_chh.out", "", df3$geneid)

df3$pos <- as.numeric(as.character(gsub(".*_", "", df3$geneid)))

chr <- subset(df3, chr==10)
chr <- chr[order(chr$pos),]
plot(chr$pos, chr$Dm, type="l")
abline(h = 0, lty=2, lwd=3, col="grey")



hist(df$Dm, breaks=100, col="darkblue")



chr <- subset(res, chr==10)
chr <- chr[order(chr$chr, chr$start),]
plot(chr$start, chr$Dm, type="l")
abline(h = 0, lty=2, lwd=3, col="grey")


library(ggplot2)
# Plot Tajima's D
data$TajimasD <- as.numeric(as.character(data$TajimasD))
head(data$TajimasD)
tiff(filename = paste(fileBase, "_TajimasD.tiff", sep = "")) 
ggplot(chr, aes(x=Dm)) + 
    geom_histogram() + 
    ggtitle("Tajima's D Distribution")
dev.off()


