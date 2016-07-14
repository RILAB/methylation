### Jinliang Yang
### Gene-body Methylation

res <- read.csv("cache/stat_exon_mean_var.csv")

hist(res$mm, breaks=50, main="Avg. Levels of Gbm", xlab="Ratio of Gene Body Methylation")

subset(res, mm > 0.6) %>% nrow
subset(res, mm <= 0.6) %>% nrow

####
gbM <- subset(res, mm > 0.6)
ngbM <- subset(res, mm <= 0.6)





res <- MCMCBC(my_sfs, sites, rates, sd, k, burnin,
                   conditional=FALSE, Ne, ngen,
                   verbose=TRUE)
    