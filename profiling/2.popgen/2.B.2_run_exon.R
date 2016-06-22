### Jinliang Yang
### June 20th, 2016

source("lib/mplots.R")
source("lib/mcmcbc.R")


sfs <- read.csv("cache/sfs_exon_cg.csv")

pdf(file="largedata/sfs_exon.pdf", width=8, height=8)
plot(sfs$Freq~(c(0:40)), pch=19, cex=2, ylab="counts", xlab="number of chromosomes", cex.lab=1.5)
dev.off()

# If acceptance too high, increase these values to explore wider space. If acceptance too low, decrease.
# 1. sd=c(1E-5,1E-5,1E-6)
# 2. sd=c(1E-6,1E-6,1E-5)
# 3  sd=c(1E-5,1E-5,1E-4)
# 4  sd=c(1E-4,1E-4,1E-5)
# 5  sd=c(1E-3,1E-3,1E-4)
res <- MCMCBC(my_sfs=sfs$Freq, sites=649360, ngen=100000, rates=c(1E6,1E6,1E5), sd=c(1E-3,1E-3,1E-4),
              conditional=FALSE, k=0:40, Ne=150000, verbose=TRUE)
tab <- accept_rate(res)

#####
save(list="res", file="largedata/res_k40_exon5.RData")
### plot trace and posteriors

ob <- load("largedata/res_k40_exon5.RData")
mplot(res)

### plot obs and post SFS
sfsplot(res, k=0:40)


### plot trace and posteriors
mplot(res)

### plot obs and post SFS
sfsplot(res, k=0:40)
    
