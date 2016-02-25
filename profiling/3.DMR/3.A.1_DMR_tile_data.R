### Jinliang Yang
### Feb 24th, 2016
### prepare data for DMR

get_methyl_list <- function(dt=teo1, ids, outdir="", type="CG"){
    
    df <- as.data.frame(dt)
    for(i in 1:length(ids)){
        
        d <- df[, c("chr", "start", paste(ids[i], "ratio", sep="_"), 
                    paste(ids[i], "C", sep="_"), paste(ids[i], "CT", sep="_"))]
        d$chrBase <- paste(d$chr, d$start, sep=".")
        d$strand <- "F"
        d$coverage <- d[, 5]
        d$freqC <- round(d[,4]/d$coverage*100, 2)
        d$freqT <- round((d[,5] - d[,4])/d$coverage*100, 2)
        d <- d[, c(6,1,2,7:10)]
        names(d)[3] <- "base"
        write.table(d, paste0(outdir, "/", ids[i], "_", type, ".txt"), sep="\t", row.names=FALSE, quote=FALSE)
        message(sprintf("###>>> output the [ %s ] sample to [ %s ]", i, outdir))
    }
}

##################################
library("data.table")

### CG methylation
teo1 <- fread("/group/jrigrp4/BS_teo20/SP028-029_JR_100bp_CG.tab")
ids <- c("JRB2", "JRC3", "JRD3", "JRF1", "JRH1", "JRH2")
get_methyl_list(dt=teo1, ids, outdir="largedata/tiles", type="CG")

teo2 <- fread("/group/jrigrp4/BS_teo20/SP029_2-3_JR_100bp_CG.tab")
ids <- c("JRA2", "JRC1", "JRC2", "JRD1", "JRE1", "JRG1")
get_methyl_list(dt=teo2, ids, outdir="largedata/tiles", type="CG")


mz <- fread("/group/jrigrp4/BS_teo20/3ZmInbreds_100bp_CG.tab")
ids <- c("B73", "Mo17", "Oh43")
get_methyl_list(dt=mz, ids, outdir="largedata/tiles", type="CG")



