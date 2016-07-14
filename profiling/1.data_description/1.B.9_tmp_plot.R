
res <- read.csv("cache/stat_exon_mean_var.csv")
hist(res$mm, breaks=100)
nrow(subset(res, mm > 0.8))


rpkm <- read.csv("cache/maize_gene_503lines_RPKM.csv")

res2 <- merge(res, rpkm, by.x="geneid", by.y="geneid")
res2$type <- 1 #high level
res2[res2$mm < 0.6, ]$type <- 0 #low level

t.test(subset(res2, type==0)$exp, subset(res2, type==1)$exp)


res2[res2$exp==0, ]$exp <- 0.1
boxplot(-log10(exp) ~ type, data=res2)

