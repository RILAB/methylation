### Jinliang Yang
### March 1st, 2016

source("~/Documents/Github/zmSNPtools/Rcodes/set_arrayjob.R")
run_bs2vcf <- function(indir="/group/jrigrp4/BS_teo20/BSMAP_output"){
    
    files=list.files(path=indir, pattern="txt$")
    for(i in 1:length(files)){
        outfile <- gsub("txt", "vcf", files[i])
        
        shid <- paste0("slurm-script/run_bs2vcf_", i, ".sh")
        #out <- gsub(".*/", "", out)
        #outfile <- paste0(outdir, "/", out)
        cmd <- paste("bs2vcf -p", indir,  "-i", files[i], "-o", outfile)
        
        cat(cmd, file=shid, sep="\n", append=FALSE)
    }
    
    set_arrayjob(shid="slurm-script/run_array_bs2vcf.sh",
                 shcode=paste0("sh slurm-script/run_bs2vcf_$SLURM_ARRAY_TASK_ID.sh"),
                 arrayjobs="1-12",
                 wd=NULL, jobid="bs2vcf", email="yangjl0930@gmail.com")
    
}