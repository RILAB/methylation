


s <- scan('largedata/vcf_files/teo20_cg_fold.sfs')
s <- s[-c(1,length(s))]
s <- s/sum(s)
barplot(s,names=1:length(s),main='SFS (CG)')


theta <- read.table("largedata/vcf_files/teo20_cg_fold.thetasWindow.gz.pestPG")
names(theta) <- c("range", "chr", "pos", "tW", "tP", "tF",
                  "tH", "tL", "Tajima", "fuf", "fud", "fayh", "zeng","nSites")
theta <- subset(theta, chr %in% 1:10)



plot_stack(df=theta, df2=NULL, chrlen="data/ZmB73_RefGen_v2.length", cex=0.3,
           cent="data/AGPv2_centromere.csv", plotcol="Tajima", dorescale=TRUE,
           cols=list("#8b0000", rep(c("slateblue", "cyan4"), 5), "#ff7373"))





