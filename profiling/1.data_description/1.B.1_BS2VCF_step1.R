### Jinliang Yang
### Convert the BSMAP to BED12 format

indir= "/group/jrigrp4/BS_teo20/BSMAP_round2"
outdir= "/home/jolyang/Documents/Github/methylation/largedata/vcf_files/"
files=list.files(path=indir, pattern="txt$", full.names = TRUE)
inputdf <- data.frame(bsmap=files, out=paste0(outdir, gsub(".*/|txt", "", files), "vcf") )


library(farmeR)
run_bs2vcf(inputdf, email="yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemm", 1))
## bs2vcf -p /group/jrigrp4/BS_teo20/BSMAP_output -i test_methratio.txt -o test_methratio.vcf







run_bgzip <- function(indir="/group/jrigrp4/BS_teo20/BSMAP_output"){
    
    files=list.files(path=indir, pattern="vcf$")
    for(i in 1:length(files)){
        
        shid <- paste0("slurm-script/run_bgzip_", i, ".sh")
        #out <- gsub(".*/", "", out)
        #outfile <- paste0(outdir, "/", out)
        cmd1 <- paste0("cd ", indir)
        cmd2 <- paste0("bgzip ", files[i],  "; tabix -p vcf ", files[i], ".gz")
        
        cat(c(cmd1, cmd2), file=shid, sep="\n", append=FALSE)
    }
    
    set_arrayjob(shid="slurm-script/run_bgzip.sh",
                 shcode=paste0("sh slurm-script/run_bgzip_$SLURM_ARRAY_TASK_ID.sh"),
                 arrayjobs="1-12",
                 wd=NULL, jobid="bigzip", email="yangjl0930@gmail.com")
    
}

run_bgzip(indir="/group/jrigrp4/BS_teo20/BSMAP_output")
#bgzip test1.vcf; tabix -p vcf test1.vcf.gz
#bgzip test2.vcf; tabix -p vcf test2.vcf.gz
#bcftools merge test1.vcf.gz test2.vcf.gz --info-rules CO:join,ST:join -o output.vcf -O v
###>>> In this path: cd /home/jolyang/Documents/Github/methylation
###>>> [ note: --ntasks=INT, number of cup ]
###>>> [ note: --mem=16000, 16G memory ]

###>>> RUN: sbatch -p bigmemh slurm-script/run_bgzip.sh

#bcftools merge -l vcflist.txt -o teo12_methratio.vcf -O b

source("~/Documents/Github/zmSNPtools/Rcodes/setUpslurm.R")
setUpslurm(slurmsh="slurm-script/run_bcf_merge.sh",
           codesh= "cd /group/jrigrp4/BS_teo20/BSMAP_output; bcftools merge -l vcflist.txt -o teo12_methratio.vcf -O z",
           wd=NULL, jobid="bcfmerge", email="yangjl0930@gmail.com")
###>>> In this path: cd /home/jolyang/Documents/Github/methylation
###>>> [ note: --ntasks=INT, number of cup ]
###>>> [ note: --mem=16000, 16G memory ]
###>>> RUN: sbatch -p bigmemh --ntasks=2 mem 16000 slurm-script/run_bcf_merge.sh

# bcftools index bcftools index teo12_methratio.vcf.gz

#bgzip test_methratio.vcf; tabix -p vcf test_methratio.vcf.gz
#bcftools query -f '%ID\t%CO[\t%RA]\n' -r 1:0-10000 test_methratio.vcf.gz -o test_RA.txt