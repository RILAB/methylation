### Jinliang Yang
### COMET paper: https://github.com/rifathamoudi/COMETgazer/blob/master/1.COMETgazer.sh

############################################################################ 
#
# COMETgazer suite for methylation analysis
# 
# By: Emanuele Libertini
#
# COMETgazer : methylome segmentation into COMETs based on OM values
#
# Input : whole genome bisulfite sequencing methylation data that have been smoothed 
#         The input file should have the following format:
#
#         Chr No | Begin | End | Smoothed methylation value
#
# Output : block | chr | start | stop | meth | oscillator | rounded OM value | size | max | min | average | range
#
############################################################################

library(quantmod) #Quantitative Financial Modelling & Trading Framework for R
#library(TTR) 	# This calls the Technical Trading Rules library in R which enhances quantmod library


chrom <- 10

chr.meth.df <- read.table("largedata/chr10.txt", header=T)
del1 <- Delt(chr.meth.df[,4])
chr.df <- data.frame(chr.meth.df, del1)
chr.df[1,5] <- 0
chr.df$g <- factor(round(chr.df[,5], 1))

write.table(chr.df, "largedata/chr.df.txt", sep="\t", row.names=F, col.names=F, quote=F)


sourceCpp("lib/block.cpp")




