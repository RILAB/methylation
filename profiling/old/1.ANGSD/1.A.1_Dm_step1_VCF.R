### Jinliang Yang
### Convert the BSMAP to BED12 format

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
##### run python scrip `bs2bed12` convert txt to bed12 format
## bs2bed -p /group/jrigrp4/BS_teo20/BSMAP_output -i bsinput_test.txt -o bsinput_test.out -v 1
run_bs2vcf(indir="/group/jrigrp4/BS_teo20/BSMAP_output")
###>>> In this path: cd /home/jolyang/Documents/Github/methylation
###>>> [ note: --ntasks=INT, number of cup ]
###>>> [ note: --mem=16000, 16G memory ]
###>>> RUN: sbatch -p bigmemh slurm-script/run_array_bs2vcf.sh



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
#bcftools query -f '%ID\t%CO[\t%CC\t%CT]\n' -r 1:0-10000 teo12_methratio.bcf.gz -o test.txt