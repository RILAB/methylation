
#confluent hypergeometric
f1<-function(a,b,z){ return(log(hyperg_1F1(a,b,z))) }

#prochhammer symbol
proch<-function(x,n){return(lgamma(x+n)-lgamma(x))}

#Proposal Distribution
normalProposal <- function(theta,std){
    theta.prime = rnorm(n=1,mean=theta,sd=std)
    return(abs(theta.prime))
}

#likelihood function
like<-function(conditional,k,Ne,mu,nu,s,my_sfs){
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
    return((dmultinom(my_sfs,prob=prob_SFS))+1E-300)
}
