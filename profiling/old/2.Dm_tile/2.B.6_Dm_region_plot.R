### Jinliang Yang
### April 20th, 2016

df <- read.csv("cache/res_region_cg.csv")
df$geneid <- gsub(".*/|_cg.out", "", df$geneid)

df$pos <- as.numeric(as.character(gsub(".*_", "", df$geneid)))

hist(df$Dm, breaks=100, col="darkblue")
abline(v= quantile(df$Dm, 0.05), col="red", lwd=2)
#abline(v= 0, col="grey", lwd=2)

df$d <- df$Dm*2
quantile(df$d, 0.01)

pdf(file="graphs/region_CG.pdf", width=12, height=5)
df2 <- subset(df, d < quantile(df$d, 0.05))
plot_stack(df, df2, chrlen="data/ZmB73_RefGen_v2.length", cex=0.3,
           cent="data/AGPv2_centromere.csv", plotcol="d", dorescale=FALSE,
           cols=list("#8b0000", rep(c("slateblue", "cyan4"), 5), "#ff7373"))
dev.off()
    

#############
df <- read.csv("cache/res_region_chg.csv")
df$geneid <- gsub(".*/|_chg.out", "", df$geneid)
df$pos <- as.numeric(as.character(gsub(".*_", "", df$geneid)))

hist(df$Dm, breaks=100, col="darkblue")
abline(v= quantile(df$Dm, 0.05), col="red", lwd=2)
#abline(v= 0, col="grey", lwd=2)

df$d <- df$Dm*2
quantile(df$d, 0.01)

pdf(file="graphs/region_CHG.pdf", width=12, height=5)
df2 <- subset(df, d < quantile(df$d, 0.025) | d > quantile(df$d, 0.975))
plot_stack(df, df2, chrlen="data/ZmB73_RefGen_v2.length", cex=0.3,
           cent="data/AGPv2_centromere.csv", plotcol="d", dorescale=FALSE,
           cols=list("#8b0000", rep(c("slateblue", "cyan4"), 5), "#ff7373"))
dev.off()

############
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

