### Jinliang Yang
### Convert the BSMAP to BED12 format

source("~/Documents/Github/zmSNPtools/Rcodes/setUpslurm.R")
run_bs2bed <- function(){
    
    dir="/group/jrigrp4/BS_teo20/BSMAP_output"
    files=list.files(path=dir, pattern="txt$")
    outsh <- c()
    for(i in 1:length(files)){
        outfile <- gsub("txt", "bed6", files[i])
        temsh <- paste("bs2bed -p", dir, "-i", files[i], "-o", outfile)
        outsh <- c(outsh, temsh)
    }
    
    setUpslurm(slurmsh="slurm-script/run_BS2bed.sh",
               codesh= outsh,
               wd=NULL, jobid="run_bd2bed", email="yangjl0930@gmail.com")
}
##### run python scrip `bs2bed12` convert txt to bed12 format
## bs2bed -p /group/jrigrp4/BS_teo20/BSMAP_output -i bsinput_test.txt -o bsinput_test.out -v 1
run_bs2bed()
###>>> In this path: cd /home/jolyang/Documents/Github/methylation
###>>> [ note: --ntasks=INT, number of cup ]
###>>> [ note: --mem=16000, 16G memory ]
###>>> RUN: sbatch -p bigmemh --mem 16000 --ntasks=2 slurm-script/run_BS2bed.sh
