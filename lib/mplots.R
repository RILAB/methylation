
library(dplyr)
library(cowplot)

mplot <- function(res, burnin=0.25, rates=c(1E7,1E8,1E6)){
    
    cbPalette=c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
    s.samples <- res[['samples']]$s
    nu.samples <- res[['samples']]$nu
    mu.samples <- res[['samples']]$mu
    l.samples <- res[['samples']]$l
    mu.acc <- res[['acc']]$mu
    nu.acc <- res[['acc']]$nu
    s.acc <- res[['acc']]$s
    
    s.samples=s.samples[(length(s.samples)*burnin+1):length(s.samples)]
    strace=ggplot(data=data.frame(s.samples),aes(y=s.samples,x=1:(length(s.samples))))+
        geom_line(color=cbPalette[4])+
        ylab("s")+
        xlab(paste("generations\n(",round(effectiveSize(10^9*s.samples))," eff. samples)\n(acc. rate ",s.acc,")",sep="")) +
        theme(axis.text=element_text(size=10),axis.title=element_text(size=10))
    
    nu.samples=nu.samples[(length(nu.samples)*burnin+1):length(nu.samples)]
    ntrace=ggplot(data=data.frame(nu.samples),aes(y=nu.samples,x=1:(length(nu.samples))))+
        geom_line(color=cbPalette[3])+
        ylab(expression(nu))+
        xlab(paste("generations\n(",round(effectiveSize(10^9*nu.samples))," eff. samples)\n(acc. rate ",nu.acc,")",sep="")) +
        theme(axis.text=element_text(size=10),axis.title=element_text(size=10))
    mu.samples=mu.samples[(length(mu.samples)*burnin+1):length(mu.samples)]
    mtrace=ggplot(data=data.frame(mu.samples),aes(y=mu.samples,x=1:(length(mu.samples))))+
        geom_line(color=cbPalette[2])+
        ylab(expression(mu))+
        xlab(paste("generations\n(",round(effectiveSize(10^9*mu.samples))," eff. samples)\n(acc. rate ",mu.acc,")",sep="")) +
        theme(axis.text=element_text(size=10),axis.title=element_text(size=10))
    l.samples=l.samples[(length(l.samples)*burnin+1):length(l.samples)]
    ltrace=ggplot(data=data.frame(l.samples),aes(y=l.samples,x=1:(length(l.samples))))+
        geom_line(color=cbPalette[1])+
        ylab("Likelihood")+
        xlab("generations") +
        theme(axis.text=element_text(size=10),axis.title=element_text(size=10) )
    
    #####
    fake=FALSE
    prior.mu=rexp(length(mu.samples),rates[1])
    post.mu=mu.samples
    mode.mu=density(post.mu)$x[which(density(post.mu)$y==max(density(post.mu)$y))]
    
    prior.nu=rexp(length(nu.samples),rates[2])
    post.nu=nu.samples
    mode.nu=density(post.nu)$x[which(density(post.nu)$y==max(density(post.nu)$y))]
    
    prior.s=rexp(length(s.samples),rates[3])
    post.s=s.samples
    mode.s=density(post.s)$x[which(density(post.s)$y==max(density(post.s)$y))]
    
    #ALPHA
    muplot<-ggplot(data.frame(post.mu,prior.mu)) +
        geom_histogram(aes(post.mu),fill=cbPalette[2],bins=30) + 
        geom_histogram(aes(prior.mu),bins=30,alpha=0.2,fill=cbPalette[1])+
        scale_x_log10()+
        xlab(expression(mu))
    if(fake==TRUE){ muplot=muplot+geom_vline(xintercept = fake.alpha/(4*Ne))} 
    else{ muplot=muplot+geom_vline(xintercept = mode.mu) }
    
    muplotzoom<-ggplot(data.frame(post.mu)) +
        geom_histogram(aes(post.mu),fill=cbPalette[2],bins=30)+
        xlab(expression(mu))+  
        theme(axis.text=element_text(size=6))
    if(fake==TRUE){ muplotzoom=muplotzoom+geom_vline(xintercept = fake.alpha/(4*Ne))} 
    else{ muplotzoom=muplotzoom+geom_vline(xintercept = mode.mu) }
    
    #BETA
    nuplot<-ggplot(data.frame(post.nu,prior.nu)) +
        geom_histogram(aes(post.nu),fill=cbPalette[3],bins=30) + 
        geom_histogram(aes(prior.nu),bins=30,alpha=0.2,fill=cbPalette[1])+
        scale_x_log10()+
        xlab(expression(nu))
    if(fake==TRUE){ nuplot=nuplot+geom_vline(xintercept = fake.beta/(4*Ne))} else{ 
        nuplot=nuplot+geom_vline(xintercept = mode.nu) }
    
    nuplotzoom<-ggplot(data.frame(post.nu)) +
        geom_histogram(aes(post.nu),fill=cbPalette[3],bins=30)+
        xlab(expression(nu))+ 
        theme(axis.text=element_text(size=6))
    if(fake==TRUE){ nuplotzoom=nuplotzoom+geom_vline(xintercept = fake.beta/(4*Ne))} 
    else{ nuplotzoom=nuplotzoom+geom_vline(xintercept = mode.nu) }
    
    #GAMMA
    splot<-ggplot(data.frame(post.s,prior.s)) + 
        geom_histogram(aes(post.s),fill=cbPalette[4],bins=30) + 
        geom_histogram(aes(prior.s),bins=30,alpha=0.2,fill=cbPalette[1])+
        scale_x_log10()+
        xlab("s")
    if(fake==TRUE){ splot=splot+geom_vline(xintercept = fake.gamma/(4*Ne))} 
    else{ splot=splot+geom_vline(xintercept = mode.s) }
    
    splotzoom<-ggplot(data.frame(post.s)) + 
        geom_histogram(aes(post.s),fill=cbPalette[4],bins=30)+
        xlab("s")+
        theme(axis.text=element_text(size=6))
    if(fake==TRUE){ splotzoom=splotzoom+geom_vline(xintercept = fake.gamma/(4*Ne))}  
    else{ splotzoom=splotzoom+geom_vline(xintercept = mode.s) }
    
    #PLOT
    message(sprintf("posterior mu [ %s ], nu [ %s ] and s [ %s ]", mode.mu, mode.nu, mode.s))
    plot_grid(mtrace,ntrace,strace,muplot,nuplot,splot,muplotzoom,nuplotzoom,splotzoom,
              ncol=3,rel_heights=c(1.5,1,1), align="v")
    #return(ltrace)
    #plot(ltrace)
}

sfsplot <- function(res, k=0:40){
    cbPalette=c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
    my_sfs <- res$my_sfs
    post_sfs <- res$post_sfs
    
    par(mfrow=c(1,1))
    plot(my_sfs ~ k, pch=19, cex=2, ylab="counts", xlab="number of chromosomes", cex.lab=1.5)
    points(post_sfs ~ k, cex=1, col=cbPalette[2], pch=19)
    legend("top",legend=c("observed","mean of posterior"), fill=c("black",cbPalette[2]))
}