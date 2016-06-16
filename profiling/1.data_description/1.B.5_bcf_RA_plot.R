### Jinliang Yang
### plot and explore

res <- read.csv("cache/stat_exon_mean_var.csv")

hist(res$mm, breaks=50, main="Avg. Levels of Gbm", xlab="Ratio of Gene Body Methylation")

subset(res, mm > 0.8) %>% nrow


hist(res$mv, breaks=50, main="Var of Gbm")



##########
geno <- read.csv("~/Documents/Github/Misc/largedata/1.gc/maize_gene_503lines.csv")
res <- apply(geno[ -1:-3], 1, function(x) mean(x, na.rm=T))
rpkm <- data.frame(geneid=names(res), exp=res)
write.table(rpkm, "cache/maize_gene_503lines_RPKM.csv", sep=",", row.names=FALSE, quote=FALSE)


rpkm <- read.csv("cache/maize_gene_503lines_RPKM.csv")
res2 <- merge(res, rpkm, by.x="geneid", by.y="geneid")

res2$meth <- 1
res2[res2$mm< 0.6, ]$meth <- 0

res2 <- subset(res2, exp < 4000)
res2[res2$exp==0, ]$exp <- 0.1
boxplot(exp ~ meth, data=res2)

boxplot(-log2(exp) ~ meth, data=res2)


