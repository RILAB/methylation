### Jinliang Yang
### Feb 24th, 2016
### detection of DMR

library(methylKit)
files <- list.files(path="largedata/tiles", pattern="txt")
file.list = list("JRA2_CG_chr10.txt", "JRB2_CG_chr10.txt", "JRC1_CG_chr10.txt", "JRC2_CG_chr10.txt", "JRC3_CG_chr10.txt",
                 "JRD1_CG_chr10.txt", "JRD3_CG_chr10.txt", "JRE1_CG_chr10.txt", "JRF1_CG_chr10.txt", "JRG1_CG_chr10.txt",
                 "JRH1_CG_chr10.txt", "JRH2_CG_chr10.txt", 
                 "B73_CG_chr10.txt", "Mo17_CG_chr10.txt", "Oh43_CG_chr10.txt")

setwd("largedata/tiles")
myobj = read(file.list, sample.id = list("JRA2_CG.txt", "JRB2_CG.txt", "JRC1_CG.txt", "JRC2_CG.txt", "JRC3_CG.txt",
                                         "JRD1_CG.txt", "JRD3_CG.txt", "JRE1_CG.txt", "JRF1_CG.txt", "JRG1_CG.txt",
                                         "JRH1_CG.txt", "JRH2_CG.txt", 
                                         "B73_CG.txt", "Mo17_CG.txt", "Oh43_CG.txt"), 
             assembly = "AGPv2", treatment = c(rep(1, times=12), rep(0, times=3)), context = "CpG")

## quality check and basic features of the data
getMethylationStats(myobj[[2]], plot = F, both.strands = F)

## Experiments that are highly suffering from PCR duplication bias will have a secondary 
## peak towards the right hand side of the histogram.
getCoverageStats(myobj[[2]], plot = T, both.strands = F)


## It might be useful to filter samples based on coverage.
## The code below filters a methylRawList and discards bases that have coverage below 10X and 
## also discards the bases that have more than 99.9th percentile of coverage in each sample.
flt <- filterByCoverage(myobj, lo.count = 10, lo.perc = NULL, hi.count = NULL, hi.perc = 99.9)

## In order to do further analysis, we will need to get the bases covered in all samples. 
## The following function will merge all samples to one object for base-pair locations that are covered in all samples.
meth = unite(myobj, destrand = FALSE, min.per.group=1L)

save(file="meth.RData", list=c("myobj", "meth"))

## This function will either plot scatter plot and correlation coefficients or just print a correlation matrix.
getCorrelation(meth, plot = T)

## Clustering your samples based on the methylation profiles
clusterSamples(meth, dist = "correlation", method = "ward", plot = TRUE)

PCASamples(meth)


##########
load(file="largedata/tiles/meth.RData")
## Depending on the sample size per each set it will either use Fisher’s exact or logistic regression to calculate P-values.
## P-values will be adjusted to Q-values.
myDiff = calculateDiffMeth(meth, num.cores = 4)

res <- data.frame(chr=myDiff$chr, start=myDiff$start, pval=myDiff$pvalue, qval=myDiff$qval, diff=myDiff$meth.diff)

write.table(res, file="res_chr10_CG.csv", sep=",", row.names=FALSE, quote=FALSE)


## get hyper methylated bases
myDiff25p.hyper = get.methylDiff(myDiff, difference = 25, qvalue = 0.01, type = "hyper")
## get hypo methylated bases
myDiff25p.hypo = get.methylDiff(myDiff, difference = 25, qvalue = 0.01, type = "hypo")
## get all differentially methylated bases
myDiff25p = get.methylDiff(myDiff, difference = 25, qvalue = 0.01)

#1174955

########## 2.6% hyper 10325, hypo 20779
res <- read.csv("largedata/tiles/res_chr10_CG.csv")
res1 <- subset(res, qval < 0.01 & abs(diff) > 25)
plot(res1$start, -log2(res1$pval), type="p", cex=0.2, pch=16, col="darkblue")





