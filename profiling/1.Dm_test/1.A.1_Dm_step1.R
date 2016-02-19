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


bgzip test1.vcf; tabix -p vcf test1.vcf.gz
bgzip test2.vcf; tabix -p vcf test2.vcf.gz
bcftools merge test1.vcf.gz test2.vcf.gz --info-rules CO:join,ST:join -o output.vcf -O v


