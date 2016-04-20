### Jinliang Yang
### April 20th, 2016

# extract ratio of CG, CHG, and CHH
# bcftools filter teo20_methratio.bcf -i 'INFO/CO ~ "CG"' -r 1:1-1000 -o test_chr1_cg.vcf.gz -O z
library(farmeR)
sh1 <- "cd /home/jolyang/Documents/Github/methylation/largedata/vcf_files"
sh2 <- "bcftools filter teo20_methratio.bcf -i 'INFO/CO ~ \"CG\"' -o teo20_cg_methratio.vcf.gz -O z"
set_farm_job(slurmsh = "slurm-script/run_bcf1.sh",
             shcode = c(sh1, sh2), wd = NULL, jobid = "bcf1",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "med", "1"))

sh3 <- "bcftools filter teo20_methratio.bcf -i 'INFO/CO ~ \"CHG\"' -o teo20_chg_methratio.vcf.gz -O z"
set_farm_job(slurmsh = "slurm-script/run_bcf2.sh",
             shcode = c(sh1, sh3), wd = NULL, jobid = "bcf2",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "med", "1"))

sh4 <- "bcftools filter teo20_methratio.bcf -i 'INFO/CO ~ \"CHH\"' -o teo20_chh_methratio.vcf.gz -O z"
set_farm_job(slurmsh = "slurm-script/run_bcf3.sh",
             shcode = c(sh1, sh4), wd = NULL, jobid = "bcf3",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "med", "1"))


# angsd -doSaf 1 -vcf-gl test_chr10.vcf.gz -anc ZmB73_faked_v2.fasta -fai ZmB73_faked_v2.fasta.fai -nind 20 -out out -fold 1
# realSFS out.saf.idx -P 1 > out.sfs
# angsd -vcf-gl test_chr10.vcf.gz -anc ZmB73_faked_v2.fasta -fai ZmB73_faked_v2.fasta.fai -nind 20 -out out -doSaf 1 -fold 1 -pest out.sfs -doThetas 1 
# thetaStat make_bed out.thetas.gz
# thetaStat do_stat out.thetas.gz -nChr 2 -win 500 -step 100  -outnames theta.thetasWindow.gz

set_dothetas <- function(vcf="test.vcf.gz", out="teo20_cg_fold", cpu=12, win=50000, step=10000){
    
    sh0 <- "cd /home/jolyang/Documents/Github/methylation/largedata/vcf_files"
    sh1 <- paste("angsd -doSaf 1 -vcf-gl", vcf, "-P", cpu, 
                 "-anc ZmB73_RefGen_v2.fasta -fai ZmB73_RefGen_v2.fasta.fai -nind 20 -out",
                 out, "-fold 1")
    # realSFS out.saf.idx -P 1 > out.sfs
    sh2 <- paste0("realSFS ", out, ".saf.idx -P ", cpu, " > ", out, ".sfs")
    # angsd -vcf-gl test_chr10.vcf.gz -anc ZmB73_faked_v2.fasta -fai ZmB73_faked_v2.fasta.fai 
    # -nind 20 -out out -doSaf 1 -fold 1 -pest out.sfs -doThetas 1
    sh3 <- paste0("angsd -vcf-gl ", vcf, " -anc ZmB73_RefGen_v2.fasta -fai ZmB73_RefGen_v2.fasta.fai ",
                  "-nind 20 -out ", out, " -doSaf 1 -fold 1 -pest ", out, ".sfs", " -doThetas 1")
    
    # thetaStat make_bed out.thetas.gz
    sh4 <- paste0("thetaStat make_bed ", out, ".thetas.gz")
    # thetaStat do_stat out.thetas.gz -nChr 2 -win 50000 -step 10000  -outnames theta.thetasWindow.gz
    sh5 <- paste0("thetaStat do_stat ", out, ".thetas.gz -nChr 10 -win ", win, 
                  " -step ", step, " -outnames ", out, ".thetasWindow.gz")
    return(c(sh0, sh1, sh2, sh3, sh4, sh5))
}

#############
cmd1 <- set_dothetas(vcf="teo20_cg_methratio.vcf.gz", out="teo20_cg_fold", cpu=8, win=50000, step=10000)
set_farm_job(slurmsh = "slurm-script/run_angsd1.sh",
             shcode = cmd1, wd = NULL, jobid = "angsd1",
             email = "yangjl0930@gmail.com", runinfo = c(FALSE, "bigmemm", "8"))
###>>> In this path: cd /home/jolyang/Documents/Github/methylation
###>>> RUN: sbatch -p bigmemm --mem 65568 --ntasks=8 slurm-script/run_angsd1.sh

cmd2 <- set_dothetas(vcf="teo20_chg_methratio.vcf.gz", out="teo20_chg_fold", cpu=12, win=50000, step=10000)
set_farm_job(slurmsh = "slurm-script/run_angsd2.sh",
             shcode = cmd2, wd = NULL, jobid = "angsd2",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "med", "16"))

cmd3 <- set_dothetas(vcf="teo20_chh_methratio.vcf.gz", out="teo20_chh_fold", cpu=12, win=50000, step=10000)
set_farm_job(slurmsh = "slurm-script/run_angsd3.sh",
             shcode = cmd3, wd = NULL, jobid = "angsd3",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "med", "16"))
