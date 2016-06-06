### Jinliang Yang
### from Jeff's http://rpubs.com/rossibarra/179515

library(gsl) #Gnu scientific Library is a collection of numerical routines for scientific computing.
library(dplyr)
library(coda) #Output Analysis and Diagnostics for MCMC
library(utils)
library(cowplot)
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")


## Fix some stuff for our model

conditional=FALSE #use only conditional likelihood
Ne=150000 #replace with estimated Ne from SNP data
ngen = 100000 # Set the number of generations.
sample.freq = 100 #Set the sample frequency.
l.samples = rep(NA, ngen/sample.freq) # Initialize a likelihood vector with length equal to the number of samples.
p.samples = vector("list", ngen/sample.freq)  # Initialize a prior list with length equal to the number of samples.
mu.samples=rep(NA, ngen/sample.freq) # Initialize a posterior vector for each param 
nu.samples = rep(NA, ngen/sample.freq)  #
s.samples = rep(NA, ngen/sample.freq)  #

rates=c(1E6,1E6,1E5) # rates for mu, nu, s (in that order)
sd=c(1E-6,1E-6,1E-5) # sd for proposal dist for mu, nu, s (in that order)

### Fake data
#assuming sample size 20 chromosomes (10 diploid dudes) with 10K SNPs
snps=10000 # only variant sites, used for conditional model only
sites=100000 # total number of variant and invariant sites, used for complete model (conditional==FALSE) only
k=0:20
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

### Initial values
params<-rexp(3,rates) # initial values of mu,nu,s (in that order)
priors<-dexp(params,rates) # Get the initial prior values of mu,nu,s (in that order)
l=like(conditional,k,Ne,params[1],params[2],params[3],my_sfs) # initial likilihood

### MCMC BC
textbar = txtProgressBar(style=3,width=50, file = stderr())

for(i in 1:ngen){ # For each generation...
    #choose which param
    params.prime = params
    random.param=sample(c(1:3),1)
    
    # Propose a value based on the previous values.
    params.prime[random.param]=normalProposal(params[random.param],sd[random.param]) 
    
    # Calculate the proposed likelihood.
    l.prime = like(conditional,k,Ne,params.prime[1],params.prime[2],params.prime[3],my_sfs) 
    
    # Calculate the proposed prior probability.
    priors.prime=dexp(params.prime,c(1E6,1E6,5E4))  
    
    # Calculate the acceptance probability.
    R = (l.prime/l)*(priors.prime[random.param]/priors[random.param]) 
    
    # If r < R, accept the proposed parameters.
    r = runif(1)
    if(r < R){ 
        params[random.param] = params.prime[random.param] # Set the current value to the proposed value.
        l = l.prime # Set current likelihood to  proposed likelihood.
        priors = priors.prime # Set current prior probability to  proposed prior probability.
    }
    
    # Sample from posterior
    if(i %% sample.freq == 0){ 
        mu.samples[i/sample.freq] = params[1] # Save the current param values.
        nu.samples[i/sample.freq] = params[2]
        s.samples[i/sample.freq] = params[3]
        l.samples[i/sample.freq] = l # Save the current likelihood value.
        p.samples[[i/sample.freq]] = priors # Save the current prior value.
        setTxtProgressBar(textbar,(i/ngen)) # Progress bar.
    }
    i=i+1;
}


strace=ggplot(data=data.frame(s.samples),aes(y=s.samples,x=1:(length(s.samples))))+geom_line(color=cbPalette[4])+ylab("s")+xlab(paste("samples (",round(effectiveSize(s.samples))," effective)"))
ntrace=ggplot(data=data.frame(nu.samples),aes(y=nu.samples,x=1:(length(nu.samples))))+geom_line(color=cbPalette[3])+ylab(expression(nu))+xlab(paste("samples (",round(effectiveSize(nu.samples))," effective)"))
mtrace=ggplot(data=data.frame(mu.samples),aes(y=mu.samples,x=1:(length(mu.samples))))+geom_line(color=cbPalette[2])+ylab(expression(mu))+xlab(paste("samples (",round(effectiveSize(mu.samples))," effective)"))


prior.mu=rexp(length(mu.samples[-c(1:(0.1*ngen/sample.freq))]),rates[1])
post.mu=mu.samples[-c(1:(0.1*ngen/sample.freq))]
muplot<-ggplot(data.frame(post.mu,prior.mu)) + geom_histogram(aes(post.mu),fill=cbPalette[2],bins=30) + 
    geom_histogram(aes(prior.mu),bins=30,alpha=0.2,fill=cbPalette[1])+scale_x_log10()+
    xlab(expression(mu))+  geom_vline(xintercept = fake.alpha/(4*Ne))

prior.nu=rexp(length(nu.samples[-c(1:(0.1*ngen/sample.freq))]),rates[2])
post.nu=nu.samples[-c(1:(0.1*ngen/sample.freq))]
nuplot<-ggplot(data.frame(post.nu,prior.nu)) + geom_histogram(aes(post.nu),fill=cbPalette[3],bins=30) + 
    geom_histogram(aes(prior.nu),bins=30,alpha=0.2,fill=cbPalette[1])+scale_x_log10()+
    xlab(expression(nu))+ geom_vline(xintercept = fake.beta/(4*Ne))

prior.s=rexp(length(s.samples[-c(1:(0.1*ngen/sample.freq))]),rates[3])
post.s=s.samples[-c(1:(0.1*ngen/sample.freq))]
splot<-ggplot(data.frame(post.s,prior.s)) + geom_histogram(aes(post.s),fill=cbPalette[4],bins=30) + 
    geom_histogram(aes(prior.s),bins=30,alpha=0.2,fill=cbPalette[1])+scale_x_log10()+
    xlab("s")+  geom_vline(xintercept = fake.gamma/(4*Ne))

plot_grid(mtrace,ntrace,strace,muplot,nuplot,splot,ncol=3)

