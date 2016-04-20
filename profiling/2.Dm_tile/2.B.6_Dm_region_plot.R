### Jinliang Yang
### April 20th, 2016

df <- read.csv("cache/res_region_cg.csv")
df$geneid <- gsub(".*/|_cg.out", "", df$geneid)

df$pos <- as.numeric(as.character(gsub(".*_", "", df$geneid)))


pdf(file="graphs/tem.pdf", height=4, width =10)
for(i in 1:10){
    chr <- subset(df, chr==i)
    chr <- chr[order(chr$pos),]
    plot(chr$pos, chr$Dm, type="l", main=paste("Chr", i))
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


fgs <- read.table("largedata/Dm/FGSv2_gene.txt")
names(fgs) <- c("chr", "start", "end", "geneid")

res <- merge(fgs, df[, -1:-3], by="geneid")


chr <- subset(res, chr==10)
chr <- chr[order(chr$chr, chr$start),]
plot(chr$start, chr$Dm, type="l")
abline(h = 0, lty=2, lwd=3, col="grey")

