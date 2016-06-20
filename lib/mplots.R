
library(dplyr)
library(cowplot)

mplot <- function(res){
    
    cbPalette=c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
    s.samples <- res$s.samples
    nu.samples <- res$nu.samples
    mu.samples <- res$mu.samples
    
    strace <- ggplot(data=data.frame(s.samples),aes(y=s.samples,x=1:(length(s.samples)))) +
        geom_line(color=cbPalette[4])+ylab("s") +
        xlab(paste("samples (",round(effectiveSize(s.samples))," effective)"))
    ntrace <- ggplot(data=data.frame(nu.samples),aes(y=nu.samples,x=1:(length(nu.samples)))) +
        geom_line(color=cbPalette[3])+ylab(expression(nu)) +
        xlab(paste("samples (",round(effectiveSize(nu.samples))," effective)"))
    mtrace <- ggplot(data=data.frame(mu.samples),aes(y=mu.samples,x=1:(length(mu.samples)))) +
        geom_line(color=cbPalette[2])+ylab(expression(mu)) +
        xlab(paste("samples (",round(effectiveSize(mu.samples))," effective)"))
    
    prior.mu <- res$prior.mu
    post.mu <- res$post.mu
    
    muplot <- ggplot(data.frame(post.mu, prior.mu)) + geom_histogram(aes(post.mu),fill=cbPalette[2],bins=30) + 
        geom_histogram(aes(prior.mu), bins=30, alpha=0.2, fill=cbPalette[1]) + scale_x_log10()+
        xlab(expression(mu))
    #geom_vline(xintercept = fake.alpha/(4*Ne))
    
    prior.nu <- res$prior.nu
    post.nu <- res$post.nu
    nuplot <- ggplot(data.frame(post.nu,prior.nu)) + geom_histogram(aes(post.nu),fill=cbPalette[3],bins=30) + 
        geom_histogram(aes(prior.nu),bins=30,alpha=0.2,fill=cbPalette[1])+scale_x_log10()+
        xlab(expression(nu)) #+ geom_vline(xintercept = fake.beta/(4*Ne))
    
    prior.s <- res$prior.s
    post.s <- res$post.s
    splot <- ggplot(data.frame(post.s,prior.s)) + geom_histogram(aes(post.s),fill=cbPalette[4],bins=30) + 
        geom_histogram(aes(prior.s),bins=30,alpha=0.2,fill=cbPalette[1])+scale_x_log10()+
        xlab("s") #+  geom_vline(xintercept = fake.gamma/(4*Ne))
    
    plot_grid(mtrace,ntrace,strace,muplot,nuplot,splot,ncol=3)
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