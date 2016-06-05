### Jinliang Yang
### April 28th, 2016
### Happy B-day JJ!


library("data.table")
get_ld <- function(ldfile="largedata/vcf_files/teo20_chg_10m.ld", binsize=10,
                   outfile="largedata/ld_chr10_1m_10bp_meanr2.csv"){
    ld <- fread(ldfile)
    # 232787512
    ld[, dis := round((BP_B - BP_A)/binsize, 0)]
    res <- ld[,.(mr2 = mean(R2)), by=.(dis)] 
    write.table(res, outfile, sep=",", row.names=FALSE, quote=FALSE)
    return(ld)
}


###############

res1 <- get_ld(ldfile="largedata/vcf_files/teo20_cg_10m.ld", binsize=10,
               outfile="largedata/cg_ld_10m_10bp_meanr2.csv")

res2 <- get_ld(ldfile="largedata/vcf_files/teo20_chg_10m.ld", binsize=10,
               outfile="largedata/chg_ld_10m_10bp_meanr2.csv")

res3 <- get_ld(ldfile="largedata/vcf_files/teo20_chh_10m.ld", binsize=10,
               outfile="largedata/chh_ld_10m_10bp_meanr2.csv")






d1 <- read.csv("largedata/cg_ld_10m_10bp_meanr2.csv")
d1 <- d1[order(d1$dis),]
d1 <- d1[1:50,]

d2 <- read.csv("largedata/chg_ld_10m_10bp_meanr2.csv")
d2 <- d2[order(d2$dis),]
d2 <- d2[1:300,]

d3 <- read.csv("largedata/chh_ld_10m_10bp_meanr2.csv")
d3 <- d3[order(d3$dis),]
d3 <- d3[1:300,]

plot(d1[-1,]$dis*10, d1[-1,]$mr2, type="l", main="DNA methylation LD decay in teosinte",
     xlab="Physical Distance (bp)", ylab="LD (r^2)", ylim=c(0.1, 0.22), lwd=3)
lines(d2[-1,]$dis*10, d2[-1,]$mr2, col="blue", lwd=3)
lines(d3[-1,]$dis*10, d3[-1,]$mr2, col="red", lwd=3)
legend("topright", legend=c("CG-SMP", "CHG-SMP", "CHH-SMP"), col=c("black", "blue", "red"), lwd=3)

plot(d2[-1,]$dis*10, d2[-1,]$mr2, col="blue", lwd=3, type="l", main="CHG",
     xlab="Physical Distance (bp)", ylab="LD (r^2)")

plot(d1[-1,]$dis*10, d1[-1,]$mr2, col="blue", lwd=3, type="l", main="CG",
     xlab="Physical Distance (bp)", ylab="LD (r^2)")

