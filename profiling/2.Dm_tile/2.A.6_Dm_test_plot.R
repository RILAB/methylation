### Jinliang Yang
### April 19th, 2016
##
df <- read.csv("largedata/Dm/CG_Dm_res.csv")
df$geneid <- gsub(".*/|_cg.out", "", df$geneid)
hist(df$Dm, breaks=100, col="darkblue")


fgs <- read.table("largedata/Dm/FGSv2_gene.txt")
names(fgs) <- c("chr", "start", "end", "geneid")

res <- merge(fgs, df[, -1:-3], by="geneid")


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


