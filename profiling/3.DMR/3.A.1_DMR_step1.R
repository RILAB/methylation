### Jinliang Yang
### test

source("http://methylkit.googlecode.com/files/install.methylKit.R") 
install.methylKit(ver="0.9.2",dependencies=TRUE) 
install.packages( c("mixtools", "devtools")) 
source("http://bioconductor.org/biocLite.R") 
biocLite("IRanges") 
library(devtools) 
install_url("https://github.com/ShengLi/edmr/archive/v0.6.2.tar.gz")

# install the development version from github
library(devtools)
install_github("al2na/methylKit",build_vignettes=FALSE)

###Step 1. Load add-on packages and example data 
library(edmr) 
library(methylKit) 
library(GenomicRanges) 
library(mixtools) 
library(data.table) 
data(example.myDiff.2013Nov6)



###############
library(methylKit)




