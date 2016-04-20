### Jinliang Yang
### April 20th, 2016

df <- read.csv("cache/res_region_cg.csv")
df$geneid <- gsub(".*/|_cg.out", "", df$geneid)

df$pos <- as.numeric(as.character(gsub(".*_", "", df$geneid)))

chr6 <- subset(df, chr==6 & Dm < -2.2)
# 10100001
# 15900001


library("data.table")
ra6 <- fread("largedata/vcf_files/teo20_RA_chr6.txt")
ra6 <- as.data.frame(ra6)

d <- ra6[3000000:7000000,]
d$pos <- as.numeric(as.character(gsub(".*_", "", d$V1)))
d[d == "."] <- NA
d <- subset(d, V2 == "CG" & pos > 10100001 & pos < 15900001)


d[, 3:22] <- apply(d[, 3:22], 2, as.numeric)
d$res <- apply(d[, 3:22], 1, function(x) mean(x, na.rm=T))
write.table(d[, c("pos", "res")], "largedata/chr6_10k.csv", sep=",", row.names=FALSE, quote=FALSE)

######
gene <- read.table("largedata/Dm/FGSv2_gene.txt")
subg <- subset(gene, V1 ==6 & V2 > 10100000 & V3 < 15900001)


chr6 <- read.csv("largedata/chr6_10k.csv")


mygene <- c(13386458, 13387027)
FLANK <- 5000
sub1 <- subset(chr6, pos > mygene[1] -FLANK & pos < mygene[2] + FLANK)
plot(sub1$pos, sub1$res, type="h", lwd=0.2, ylim=c(-0.25,1))
rect(xleft=mygene[1], ybottom= -0.2, xright=mygene[2], ytop= -0.1, border = "red")



dcg <- subset(d, )


len <- read.table("largedata/Dm/region_CG/region_CG_length.txt")
len$V1 <- gsub("_cg", "", len$V1)
len$chr <- gsub("_.*", "", len$V1)
len$pos <- as.numeric(as.character(gsub(".*_", "", len$V1)))

sub <- subset(len, chr==6)
plot(sub$pos, sub$V2)
abline(v=10100001)
abline(v=15900001)

sub <- subset(len, chr==6 & pos > 10100000 & pos < 15900010)

alpha <- read.table("largedata/Dm/region_CG/region_CG_alpha.txt")
names(alpha) <- c("locus_name", "alpha_value", "mean_NB", "variance_NB")
alpha$locus_name <- gsub("_cg", "", alpha$locus_name)
alpha$chr <- gsub("_.*", "", alpha$locus_name)
alpha$pos <- as.numeric(as.character(gsub(".*_", "", alpha$locus_name)))

sub <- subset(alpha, chr==6)
plot(sub$pos, sub$alpha_value)
abline(v=10100001)
abline(v=15900001)


###############
exp <- read.csv("~/Documents/Github/Misc/largedata/1.gc/maize_gene_503lines.csv")
exp$mean <- apply(exp[, -1:-3], 1, mean)

subexp <- merge(subg, exp, by.x="V4", by.y="row.names" )


