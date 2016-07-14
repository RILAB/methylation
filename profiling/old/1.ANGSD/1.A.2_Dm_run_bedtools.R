### Jinliang Yang
### June 6th, 2015
### find overlapped feature in genes

source("~/Documents/Github/zmSNPtools/Rcodes/setUpslurm.R")
run_bedtools <- function(){
    
    dir="/group/jrigrp4/BS_teo20/BSMAP_output"
    files=list.files(path=dir, pattern="bed6$")
    outsh <- c(paste("cd", dir))
    for(i in 1:length(files)){
        outfile <- gsub("bed6", "out", files[i])
        temsh <- paste("bedtools intersect -a ~/dbcenter/AGP/AGPv2/FGSv2.bed4", 
                       "-b", files[i], "-sorted -loj >", outfile)
        outsh <- c(outsh, temsh)
    }
    
    setUpslurm(slurmsh="slurm-script/run_bedtools.sh",
               codesh= outsh,
               wd=NULL, jobid="BS2BED12", email="yangjl0930@gmail.com")
}
#bedtools intersect -a ~/dbcenter/AGP/AGPv3/AGPv3_gene.bed6 -b bsinput_test.out -sorted -loj > test.txt
#run bedtools to find intersect M sites in genes

run_bedtools()
###>>> In this path: cd /home/jolyang/Documents/Github/methylation
###>>> [ note: --ntasks=INT, number of cup ]
###>>> [ note: --mem=16000, 16G memory ]
###>>> RUN: sbatch -p bigmemh --mem 128000 --ntasks=16 slurm-script/run_bedtools.sh
