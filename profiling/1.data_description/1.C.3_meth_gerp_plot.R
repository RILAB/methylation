
library(wesanderson)
library(ggplot2)
source("~/Documents/Github/zmSNPtools/Rcodes/multiplot.R")

cols <- c( "#daa520", "#3b5998", "#ff00ff")
theme_set(theme_grey(base_size = 18)) 

#lty1 <- getlty(df=out, eff="effa", cutoff=0.05)$l
p1 <- ggplot(dat2, aes(x=RS, y=mean, 
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

p2 <- ggplot(dat2, aes(x=RS, y=var, 
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


pdf("graphs/gerp_mr_neg.pdf", width=12, height=5)
multiplot(p1, p2, cols=2)
dev.off()


dat$gerp <- "pos"
dat2$gerp <- "neg"
dat9$gerp <- "non"
res <- rbind(dat[, c("mean", "cx", "gerp")], dat2[, c("mean", "cx", "gerp")], dat9)

p1 <- ggplot(res, aes(x=cx, y=mean, fill=gerp)) +
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

pdf("graphs/gerp_three_cat.pdf", width=6, height=5)
p1
dev.off()


