### Jinliang Yang
### from Jeff's http://rpubs.com/rossibarra/179515


### Fake Data
#assuming sample size 20 chromosomes (10 diploid dudes) with 10K SNPs
snps=10000 # only variant sites, used for conditional model only
sites=100000 # total number of variant and invariant sites, used for complete model (conditional==FALSE) only
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



res <- MCMCBC(my_sfs, ngen=1000, conditional=FALSE, k=0:40, Ne=150000, verbose=TRUE)
    


s.samples


######
