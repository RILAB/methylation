### Jinliang Yang
### April 11th, 2016

library("data.table")

gerp <- fread("~/Documents/Github/pvpDiallel/largedata/GERPv2/gerp130m.csv", sep=",")
gerp[, range(RS)] #-4.56  2.28
gerp[, snpid := paste(chr, pos, sep="_")]

gerp1 <- gerp[RS > 0,]
gerp2 <- gerp[RS <= 0,]

#DT[i, j, by]
##   R:      i                 j        by
## SQL:  where   select | update  group by


chr10 <- fread("largedata/vcf_files/teo20_RA_chr10.txt")

cg <- chr10[V2 == "CG"] #12185424       22
chg <- chr10[V2 == "CHG"] #10689235       22
chh <- chr10[V2 == "CHH"] #42327613       22


save(file="largedata/chr10.RData", list=c("chr10", "gerp1", "gerp2"))


##################
get_cx_stat <- function(gerp, cx){
    
    gerp <- setkey(gerp, snpid)
    cx <- setkey(cx, V1)
    setnames(cx, "V1", "snpid")
    cx1 <- merge(gerp, cx, by="snpid")
    
    cx1 <- as.data.frame(cx1)
    cx1[cx1 == "."] <- NA
    cx1[, 7:26] <- apply(cx1[, 7:26], 2, as.numeric)
    
    cx1$mean <- apply(cx1[, 7:26], 1, function(x) mean(x, na.rm=T) )
    cx1$var <- apply(cx1[, 7:26], 1, function(x) var(x, na.rm=T) )
    return(cx1)
}

###########
library("data.table")
ob <- load("largedata/chr10.RData")

cg <- get_cx_stat(gerp=gerp1, cx= chr10[V2 == "CG"])
chg <- get_cx_stat(gerp=gerp1, cx= chr10[V2 == "CHG"])
chh <- get_cx_stat(gerp=gerp1, cx= chr10[V2 == "CHH"])


cg$cx <- "CG"
chg$cx <- "CHG"
chh$cx <- "CHH"
dat <- rbind(cg[, c("RS", "mean", "var", "cx")], 
             chg[, c("RS", "mean", "var", "cx")], 
             chh[, c("RS", "mean", "var", "cx")])

cor.test(cg$RS, cg$mean) #-0.02251327
cor.test(cg$RS, cg$var) #-0.0137094 
cor.test(chg$RS, chg$mean) #-0.09696059
cor.test(chg$RS, chg$var) #-0.06490606
cor.test(chh$RS, chh$mean) #-0.03762805
cor.test(chh$RS, chh$var) #-0.0392184 



#####################

library(wesanderson)
library(ggplot2)
source("~/Documents/Github/zmSNPtools/Rcodes/multiplot.R")

cols <- c( "#daa520", "#3b5998", "#ff00ff")
theme_set(theme_grey(base_size = 18)) 

#lty1 <- getlty(df=out, eff="effa", cutoff=0.05)$l
p1 <- ggplot(dat, aes(x=RS, y=mean, 
                      colour=factor(cx, levels=c("CG", "CHG", "CHH")))) +
    labs(colour="Context") +
    theme_bw() +
    xlab("GERP Score") +
    ylab("Mean Methylation Ratio") +
    #  (by default includes 95% confidence region)
    #scale_fill_manual(values=c("#008080", "#003366", "#40e0d0", "#ffa500", "#f6546a", "#ff00ff", "#800000")) +
    #http://www.sthda.com/english/wiki/ggplot2-colors-how-to-change-colors-automatically-and-manually
    scale_color_manual(values=cols) +
    #scale_linetype_manual(values=lty1) +
    #guides(colour=TRUE) +
    geom_smooth(method="gam", size=1.3) +
    theme(axis.text.y = element_text(angle = 90, hjust = 1))

p2 <- ggplot(dat, aes(x=RS, y=var, 
                      colour=factor(cx, levels=c("CG", "CHG", "CHH")))) +
    labs(colour="Context") +
    theme_bw() +
    xlab("GERP Score") +
    ylab("Variance of Methylation Ratio") +
    #  (by default includes 95% confidence region)
    #scale_fill_manual(values=c("#008080", "#003366", "#40e0d0", "#ffa500", "#f6546a", "#ff00ff", "#800000")) +
    #http://www.sthda.com/english/wiki/ggplot2-colors-how-to-change-colors-automatically-and-manually
    scale_color_manual(values=cols) +
    #scale_linetype_manual(values=lty1) +
    #guides(colour=TRUE) +
    geom_smooth(method="gam", size=1.3) +
    theme(axis.text.y = element_text(angle = 90, hjust = 1))


pdf("graphs/gerp_mr.pdf", width=12, height=5)
multiplot(p1, p2, cols=2)
dev.off()

########################################################
cg2 <- get_cx_stat(gerp=gerp2, cx= chr10[V2 == "CG"])
chg2 <- get_cx_stat(gerp=gerp2, cx= chr10[V2 == "CHG"])
chh2 <- get_cx_stat(gerp=gerp2, cx= chr10[V2 == "CHH"])

cg2$cx <- "CG"
chg2$cx <- "CHG"
chh2$cx <- "CHH"
dat2 <- rbind(cg2[, c("RS", "mean", "var", "cx")], 
                chg2[, c("RS", "mean", "var", "cx")], 
                chh2[, c("RS", "mean", "var", "cx")])

cor.test(cg2$RS, cg2$mean) #0.018
cor.test(cg2$RS, cg2$var) # 
cor.test(chg2$RS, chg2$mean) #-0.09696059
cor.test(chg2$RS, chg2$var) #-0.06490606
cor.test(chh2$RS, chh2$mean) #-0.03762805
cor.test(chh2$RS, chh2$var) #-0.0392184 


#############################
get_cx_stat9 <- function(cx=chr10[V2 == "CG"], cx1=cg, cx2=cg2){
    
    cx <- as.data.frame(cx)
    cx <- subset(cx, !(V1 %in% c(cx1$snpid, cx2$snpid)))
    
    cx[cx == "."] <- NA
    cx[, 3:22] <- apply(cx[, 3:22], 2, as.numeric)
    
    cx$mean <- apply(cx[, 3:22], 1, function(x) mean(x, na.rm=T) )
    #cx$var <- apply(cx[, 3:22], 1, function(x) var(x, na.rm=T) )
    return(cx)
}
#########
cg9 <- get_cx_stat9(cx=chr10[V2 == "CG"], cx1=cg, cx2=cg2)
chg9 <- get_cx_stat9(cx=chr10[V2 == "CHG"], cx1=chg, cx2=chg2)
chh9 <- get_cx_stat9(cx=chr10[V2 == "CHH"], cx1=chh, cx2=chh2)

cg9$cx <- "CG"
chg9$cx <- "CHG"
chh9$cx <- "CHH"


myd1 <- condense(bin(cg9$mean, .01), summary="mean")
myd2 <- condense(bin(chg9$mean, .01), summary="mean")
myd3 <- condense(bin(chh9$mean, .01), summary="mean")

dat9 <- rbind(cg9[, c( "mean", "cx")], 
              chg9[, c("mean", "cx")], 
              chh9[, c("mean", "cx")])


myd1 <- condense(bin(chh9$carat, .1), z=mydiamonds$price, summary="mean")

#######
library(bigvis)
autoplot(dat9)

