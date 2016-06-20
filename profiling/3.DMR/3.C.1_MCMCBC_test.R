### Jinliang Yang
### from Jeff's http://rpubs.com/rossibarra/179515

############################
source("lib/mplots.R")
source("lib/mcmcbc.R")

conditional=FALSE
rates=c(1E6,1E6,1E5) # rates for mu, nu, s (in that order)
#sd=c(1E-6,1E-6,1E-5) # sd for proposal dist for mu, nu, s (in that order)
Ne=150000

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


##########
res <- MCMCBC(my_sfs, sites, ngen=1000000, rates=c(1E6,1E6,1E5), sd=c(1E-5,1E-5,1E-6),
              conditional=FALSE, k, Ne, verbose=TRUE)
tab <- accept_rate(res)
    
save(list="res", file="cache/res_k40.RData")
### plot trace and posteriors

ob <- load("cache/res_k40.RData")
mplot(res)

### plot obs and post SFS
sfsplot(res, k=0:20)



######
