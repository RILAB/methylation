### Jinliang Yang
### Gene-body Methylation

res <- read.csv("cache/stat_exon_mean_var.csv")

hist(res$mm, breaks=50, main="Avg. Levels of Gbm", xlab="Ratio of Gene Body Methylation")



fake=TRUE
rates=c(1E7,1E8,1E6)
Ne=150000 #replace with estimated Ne from SNP data

if(fake==TRUE){
    snps=10000 # only variant sites, used for conditional model only
    sites=500000 # total number of variant and invariant sites, used for complete model (conditional==FALSE) only
    k=0:40
    n=max(k)
    fake.alpha=rexp(1,rates[1])*4*Ne
    fake.beta=rexp(1,rates[2])*4*Ne
    fake.gamma=rexp(1,rates[3])*4*Ne
    
    #neutral
    #my_sfs=(rmultinom(1,theta,(theta/1:(length(k)-2)))) 
    
    my_sfs <- sapply(k,function(K){
        log(choose(n,K))+(f1(fake.beta+K,fake.alpha+fake.beta+n,fake.gamma)+proch(fake.beta,K)+proch(fake.alpha,n-K))-(f1(fake.beta,fake.alpha+fake.beta,fake.gamma)+proch(fake.alpha+fake.beta,n))
    })
    my_sfs=my_sfs-max(my_sfs)
    my_sfs=exp(my_sfs)/sum(exp(my_sfs))
    
    if(conditional==TRUE){
        c_csfs <- sapply(1:length(my_sfs), function(x) my_sfs[x]/sum(my_sfs[2:(length(my_sfs)-1)]))  #divide by 
        my_sfs <- round(c_csfs[-c(1,length(c_csfs))]*snps)
    } else{
        my_sfs <- round(my_sfs*sites)
    }
} else{
    download.file("https://gist.githubusercontent.com/rossibarra/71d0d22bcb6a7c4a786fd99fdf42fcab/raw/47ecd73ec50a92258044618c322d2e83ea5370cb/sfsPC","PCsfs.csv")
    sfs_data<-read.table("PCsfs.csv",header=T)
    my_sfs=sfs_data$Freq
}
k=0:(length(my_sfs)-1)
plot(my_sfs~k,pch=19,cex=2,ylab="counts",xlab="number of chromosomes",cex.lab=1.5)



res <- MCMCBC(my_sfs, sites, rates, sd, k, burnin,
                   conditional=FALSE, Ne, ngen,
                   verbose=TRUE)
    