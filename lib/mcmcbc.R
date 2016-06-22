### http://rpubs.com/rossibarra/mcmcbc
### By JRI
### http://rpubs.com/rossibarra/179515

library(gsl) #Gnu scientific Library is a collection of numerical routines for scientific computing.
library(coda) #Output Analysis and Diagnostics for MCMC
library(utils)

#confluent hypergeometric function 2
f1 <- function(a,b,z){ return(log(hyperg_1F1(a,b,z))) }

#prochhammer symbol
proch <- function(x,n){return(lgamma(x+n)-lgamma(x))}

#Proposal Distribution
normalProposal <- function(theta,std){
    theta.prime = rnorm(n=1,mean=theta,sd=std)
    return(abs(theta.prime))
}

#likelihood function
like<-function(conditional, k, Ne, mu, nu, s, my_sfs){
    #Generate SFS for these values
    alpha=4*mu*Ne
    beta=4*nu*Ne
    gamma=4*s*Ne
    n=max(k)
    #unfolded SFS with fixed/absent, equation 16b from Charlesworh & Jain 2014 
    prob_SFS <- sapply(k,function(K){
        log(choose(n,K))+(f1(beta+K,alpha+beta+n,gamma)+proch(beta,K)+proch(alpha,n-K))-(f1(beta,alpha+beta,gamma)+proch(alpha+beta,n))
    })
    
    #normalize
    prob_SFS=prob_SFS-max(prob_SFS)
    prob_SFS=exp(prob_SFS)/sum(exp(prob_SFS))
    
    #Make conditional
    if(conditional==TRUE){
        cond_SFS <- sapply(1:length(prob_SFS), function(x) prob_SFS[x]/sum(prob_SFS[2:(length(prob_SFS)-1)]))  #divide by total p(seg)
        prob_SFS <- cond_SFS[-c(1,length(cond_SFS))]
    }
    return((dmultinom(my_sfs, prob=prob_SFS))+1E-300)
}


MCMCBC <- function(my_sfs, sites, ngen, rates,sd,
                   conditional=FALSE, k, Ne, verbose=TRUE){
    ## Fix some stuff for our model
    
    #conditional=FALSE #use only conditional likelihood
    #Ne=150000 #replace with estimated Ne from SNP data
    #ngen = 100000 # Set the number of generations.
    sample.freq = 100 #Set the sample frequency.
    l.samples = rep(NA, ngen/sample.freq) # Initialize a likelihood vector with length equal to the number of samples.
    p.samples = vector("list", ngen/sample.freq)  # Initialize a prior list with length equal to the number of samples.
    mu.samples=rep(NA, ngen/sample.freq) # Initialize a posterior vector for each param 
    nu.samples = rep(NA, ngen/sample.freq)  #
    s.samples = rep(NA, ngen/sample.freq)  #
    acceptances = vector("list", ngen) #
    
    #rates=c(1E6,1E6,1E5) # rates for mu, nu, s (in that order)
    #sd=c(1E-6,1E-6,1E-5) # sd for proposal dist for mu, nu, s (in that order)
    
    ### Initial values
    params <- rexp(3,rates) # initial values of mu,nu,s (in that order)
    priors <- dexp(params,rates) # Get the initial prior values of mu,nu,s (in that order)
    l=like(conditional, k, Ne, params[1], params[2], params[3], my_sfs) # initial likilihood
    
    ### MCMC BC
    textbar = txtProgressBar(style=3, width=50, file = stderr())
    
    for(i in 1:ngen){ # For each generation...
        #choose which param
        params.prime <- params
        random.param <- sample(c(1:3),1)
        
        # Propose a value based on the previous values.
        params.prime[random.param]=normalProposal(params[random.param],sd[random.param]) 
        
        # Calculate the proposed likelihood.
        l.prime = like(conditional,k,Ne,params.prime[1],params.prime[2],params.prime[3],my_sfs) 
        
        # Calculate the proposed prior probability.
        priors.prime=dexp(params.prime,rates)  
        
        # Calculate the acceptance probability.
        R = (l.prime/l)*(priors.prime[random.param]/priors[random.param]) 
        
        # If r < R, accept the proposed parameters.
        r = runif(1)
        acceptances[[i]] <- c(NA, NA, NA)
        acceptances[[i]][random.param]=0
        if(r < R){ 
            acceptances[[i]][random.param]=1
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
            if(verbose) setTxtProgressBar(textbar,(i/ngen)) # Progress bar.
        }
        i=i+1;
    }
    
    ### posteriors
    prior.mu=rexp(length(mu.samples[-c(1:(0.1*ngen/sample.freq))]),rates[1])
    post.mu=mu.samples[-c(1:(0.1*ngen/sample.freq))]
    prior.nu=rexp(length(nu.samples[-c(1:(0.1*ngen/sample.freq))]),rates[2])
    post.nu=nu.samples[-c(1:(0.1*ngen/sample.freq))]
    prior.s=rexp(length(s.samples[-c(1:(0.1*ngen/sample.freq))]),rates[3])
    post.s=s.samples[-c(1:(0.1*ngen/sample.freq))]
    
    ### posterior SFS
    n <- max(k)
    post_sfs <- sapply(k,function(K){
        log(choose(n,K)) +
        (f1(mean(post.nu)*4*Ne+K, mean(post.mu)*4*Ne+mean(post.nu)*4*Ne+n,mean(post.s)*4*Ne) + 
        proch(mean(post.nu)*4*Ne,K) + proch(mean(post.mu)*4*Ne,n-K)) -
        (f1(mean(post.nu)*4*Ne,mean(post.mu)*4*Ne+mean(post.nu)*4*Ne,mean(post.s)*4*Ne) +
        proch(mean(post.mu)*4*Ne+mean(post.nu)*4*Ne,n))})
    post_sfs <- post_sfs-max(post_sfs)
    post_sfs <- exp(post_sfs)/sum(exp(post_sfs))*sites

    return(list(acceptances=acceptances,
                prior.mu=prior.mu, post.mu=post.mu, prior.nu=prior.nu, post.nu=post.nu, 
                prior.s=prior.s, post.s=post.s,
                s.samples=s.samples, nu.samples=nu.samples, mu.samples=mu.samples,
                my_sfs=my_sfs, post_sfs=post_sfs))
    
}


accept_rate <- function(res){

    tem <- do.call(rbind.data.frame, res[[1]])
    names(tem) <- c("mu", "nu", "s")
    rs <- apply(tem, 2, function(x) {
        y <- x[!is.na(x)]
        return(round(sum(y)/length(y),5))
    })
    message(sprintf("acceptance rate for mu [ %s ], nu [ %s ] and s [ %s ]", rs[1],rs[2], rs[3] ))
    return(tem)
}



