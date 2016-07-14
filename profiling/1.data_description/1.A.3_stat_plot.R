### Jinliang Yang
### plot the stat of the teo20 methylation data

### CG, CHG and CHH
###180125000, 158277169, 624401016
res <- read.table("data/res.txt", header=FALSE)
names(res) <- c("sample", "cov_CG", "cov_CHG", "cov_CHH", "ratio_CG", "ratio_CHG", "ratio_CHH",
                "tot_CG", "tot_CHG", "tot_CHH")
res$sample <- gsub(".*/|_methratio.*", "", res$sample)
res$tot_CG <- res$tot_CG/180125000
res$tot_CHG <- res$tot_CHG/158277169
res$tot_CHH <- res$tot_CHH/624401016

#library(tidyr)
library(reshape2)
resl <- melt(res, id.vars="sample")
resl$variable <- as.character(resl$variable)
resl$type <- gsub("_.*", "", resl$variable)
resl$context <- gsub(".*_", "", resl$variable)



p1 <- ggplot(subset(resl, type=="cov"), aes(x=context, y=value, fill=context)) +
    geom_boxplot() +
    theme_bw() +
    theme(plot.title = element_text(color="red", size=20, face="bold.italic"),
          axis.text.x = element_text(size=18),
          axis.text.y = element_text(size=13),
          axis.title = element_text(size=18, face="bold")) +
    #scale_fill_manual(values=c("#008080", "#003366", "#40e0d0")) +
    ggtitle("Sequencing Depth") + xlab("") + ylab("Depth per cytosine site") + 
    guides(fill=FALSE)
    #guides(colour=FALSE, linetype=FALSE)

p2 <- ggplot(subset(resl, type=="ratio"), aes(x=context, y=value, fill=context)) +
    geom_boxplot() +
    theme_bw() +
    theme(plot.title = element_text(color="red", size=20, face="bold.italic"),
          axis.text.x = element_text(size=18),
          axis.text.y = element_text(size=13),
          axis.title = element_text(size=18, face="bold")) +
    #scale_fill_manual(values=c("#008080", "#003366", "#40e0d0")) +
    ggtitle("Methylation Ratio") + xlab("") + ylab("Mean C/CT Ratio") + 
    guides(fill=FALSE)

p3 <- ggplot(subset(resl, type=="tot"), aes(x=context, y=value, fill=context)) +
    geom_boxplot() +
    theme_bw() +
    theme(plot.title = element_text(color="red", size=20, face="bold.italic"),
          axis.text.x = element_text(size=18),
          axis.text.y = element_text(size=13),
          axis.title = element_text(size=18, face="bold")) +
    #scale_fill_manual(values=c("#008080", "#003366", "#40e0d0")) +
    ggtitle("Coverage of cytosine sites") + xlab("") + ylab("covered / possible C sites") + 
    guides(fill=FALSE)
#guides(colour=FALSE, linetype=FALSE)

source("~/Documents/Github/zmSNPtools/Rcodes/multiplot.R")
#multiplot(p1, p4, p2, p5, p3, p6, cols=3)
pdf("graphs/stat.pdf", width=16, height=5)
multiplot(p3, p1, p2, cols=3)
dev.off()


