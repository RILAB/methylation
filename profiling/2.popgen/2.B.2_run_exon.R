
source("lib/mplots.R")
source("lib/mcmcbc.R")


sfs <- read.csv("cache/sfs_test.csv")
res <- MCMCBC(my_sfs=sfs$Freq, sites=649360, ngen=100000, conditional=FALSE, k=0:40, Ne=150000, verbose=TRUE)

### plot trace and posteriors
mplot(res)

### plot obs and post SFS
sfsplot(res, k=0:40)
    
