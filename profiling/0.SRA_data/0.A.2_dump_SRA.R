### Jinliang Yang
### Feb 25th, 2016



##########################
run_fdump <- function(pwd="/group/jrigrp4/BS_teo20/WGBS", slurmsh="slurm-script/dump_WGBS.sh"){
    source("~/Documents/Github/zmSNPtools/Rcodes/setUpslurm.R")
    files <- list.files(path=pwd, pattern="sra$")
    mysh <- paste("cd", pwd)
    for(i in 1:length(files)){
        out <- paste("fastq-dump --split-spot --split-3 -A", files[i])
        mysh <- c(mysh, out)
    }
    setUpslurm(slurmsh=slurmsh,
               codesh=mysh,
               wd=NULL, jobid="dump", email="yangjl0930@gmail.com")
}

########
run_fdump(pwd="/group/jrigrp4/BS_teo20/WGBS", slurmsh="slurm-script/dump_WGBS.sh")

run_fdump(pwd="/group/jrigrp4/BS_teo20/RNA-seq", slurmsh="slurm-script/dump_RNA-seq.sh")





