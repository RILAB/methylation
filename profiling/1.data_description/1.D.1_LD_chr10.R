### Jinliang Yang
### April 28th, 2016
### Happy B-day JJ!


library("data.table")
chr10 <- fread("largedata/vcf_files/teo20_RA_chr10.txt") #65202272
chr10 <- as.data.frame(chr10)

idx <- sort(sample(1:nrow(chr10), 100000))
sub <- chr10[idx, ]


cmd1 <- "bcftools index teo20_cg_methratio.vcf.gz"
cmd2 <- "bcftools filter teo20_cg_methratio.vcf.gz - r 10 -o teo20_cg_mr_chr10.vcf.gz -O z"



library(farmeR)

cmd1 <- "#module load plink/1.90"
cmd2 <- "cd largedata/vcf_files"
cmd3 <- paste0("plink -vcf teo20_cg_mr_chr10.vcf.gz --thin-count 1000000 --r2 --threads 8 --memory 64000",
               " --out teo20_cg_chr10 --ld-window 9999999 --ld-window-kb 100 --ld-window-r2 0")

set_farm_job(slurmsh = "slurm-script/plink_cl.sh",
             shcode = c(cmd1, cmd2, cmd3), wd = NULL, jobid = "plink-ld",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemh", "8"))

#### CG ###########################
library(farmeR)
cmd1 <- "cd largedata/vcf_files"
cmd2 <- paste0("plink -vcf teo20_cg_methratio.vcf.gz --thin-count 10000000 --r2 --threads 8 --memory 64000",
               " --out teo20_cg_10m --ld-window 9999999 --ld-window-kb 10 --ld-window-r2 0 --allow-extra-chr")

set_farm_job(slurmsh = "slurm-script/plink_cg_ld.sh",
             shcode = c(cmd1, cmd2), wd = NULL, jobid = "cg-ld",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemh", "8"))


#### CHG ###########################
library(farmeR)
cmd1 <- "cd largedata/vcf_files"
cmd2 <- paste0("plink -vcf teo20_chg_methratio.vcf.gz --thin-count 10000000 --r2 --threads 8 --memory 64000",
               " --out teo20_chg_10m --ld-window 9999999 --ld-window-kb 10 --ld-window-r2 0 --allow-extra-chr")

set_farm_job(slurmsh = "slurm-script/plink_chg_ld.sh",
             shcode = c(cmd1, cmd2), wd = NULL, jobid = "chg-ld",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemh", "8"))

#### CHH ###########################
library(farmeR)
cmd1 <- "cd largedata/vcf_files"
cmd2 <- paste0("plink -vcf teo20_chh_methratio.vcf.gz --thin-count 10000000 --r2 --threads 8 --memory 64000",
               " --out teo20_chh_10m --ld-window 9999999 --ld-window-kb 10 --ld-window-r2 0 --allow-extra-chr")

set_farm_job(slurmsh = "slurm-script/plink_chh_ld.sh",
             shcode = c(cmd1, cmd2), wd = NULL, jobid = "chh-ld",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemh", "8"))

