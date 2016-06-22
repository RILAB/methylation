### Jinliang Yang
### June 21th, 2016


library(epivizr)
library(limma)
library(bumphunter)

ob <- load("largedata/coloncancermeth.rda")

X <- model.matrix(~pd$Status)
fit <- lmFit(meth,X)
eb <- ebayes(fit)

chr=as.factor(seqnames(gr))
pos=start(gr)
cl=clusterMaker(chr,pos,maxGap=500)
res<-bumphunter(meth,X,chr=chr,pos=pos,cluster=cl,cutoff=0.1,B=0)


head(fit$coef)
head(eb$t)
head(res$fitted)
head(res$table)

# the CpG location object
show(gr)

#epivizr uses GRanges objects to visualize data, 
#so we’ll create a new GRanges object containing CpG level estimates we want to visualize

cpgGR <- gr
cpgGR$fitted <- round(res$fitted,digits=3)

dmrGR <- with(res$table,GRanges(chr,IRanges(start,end),area=area,value=value))

# let's add an annotation for "hypo-" or "hyper-" methylation (as long as the difference is large enough)
dmrGR$type <- ifelse(abs(dmrGR$value)<0.2, "neither", ifelse(dmrGR$value<0,"hypo","hyper"))
table(dmrGR$type)


### Now, we are ready to visualize this data on epiviz. First start an epiviz session:
mgr <- startEpiviz(workspace="mi9NojjqT1l", port = 7300L, chr= "chr1")

### Now, let’s add tracks for hypo and hyper methylated regions:
hypoTrack <- mgr$addDevice(subset(dmrGR,dmrGR$type=="hypo"), "Hypo-methylated")

hyperTrack <- mgr$addDevice(subset(dmrGR,dmrGR$type=="hyper"), "Hyper-methylated")


diffTrack <- mgr$addDevice(cpgGR,"Meth difference",type="bp",columns="fitted")



slideshowRegions <- dmrGR[1:10,] + 10000
mgr$slideshow(slideshowRegions, n=5)

mgr$stopServer()



#########
library(Mus.musculus)
library(epivizr)

mgr <- startEpiviz(port = 7313L, openBrowser=FALSE,tryPorts=TRUE)
mgr <- startStandalone(Mus.musculus, geneInfoName="mm10", tryPorts=TRUE,
                       keepSeqlevels=paste0("chr",c(1:19,"X","Y")), start.args=c(tryPorts=TRUE))

mgr <- startEpiviz()
dev <- mgr$addDevice(Mus.musculus, "mm10", keepSeqlevels=paste0("chr",c(1:19,"X","Y")))
mgr$stopServer()


library("devtools")
install_github("epiviz/epivizr")

library(epivizr)
library(Mus.musculus)
mgr <- startStandalone(Mus.musculus,
                                geneInfoName = "mm10",
                                keepSeqlevels=c("chrX","chrY"))
mgr$stopServer()
