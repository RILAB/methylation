### Jinliang Yang
### Convert the BSMAP to BED12 format

source("~/Documents/Github/zmSNPtools/Rcodes/setUpslurm.R")

run_bs2bed <- function(){
    
    dir="/group/jrigrp4/BS_teo20/BSMAP_output"
    files=list.files(path=dir, pattern="txt$")
    outsh <- c()
    for(i in 1:length(files)){
        outfile <- gsub("txt", "bed12", files[i])
        temsh <- paste("bs2bed12 -p", dir, "-i", files[i], "-o", outfile)
        outsh <- c(outsh, temsh)
    }
    
    setUpslurm(slurmsh="slurm-script/run_BS2BED12.sh",
               codesh= outsh,
               wd=NULL, jobid="BS2BED12", email="yangjl0930@gmail.com")
}

run_bs2bed()


