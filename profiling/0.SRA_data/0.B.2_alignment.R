### Jinliang Yang
### March 1st, 2016

library(devtools)
install_github("yangjl/maizeR")
library(maizeR)


fq1 <- list.files(path="/group/jrigrp4/BS_teo20/WGBS/", pattern="sra_1.fastq$", full.names = TRUE)
fq2 <- list.files(path="/group/jrigrp4/BS_teo20/WGBS/", pattern="sra_2.fastq$", full.names = TRUE)
input_df <- data.frame(fq1=fq1, fq2=fq2)
input_df$out <- gsub(".*\\/|\\..*", "", input_df$fq1)

runa_bismark(input_df, genome = "/home/jolyang/dbcenter/AGP/AGPv2", cpu = 4,
             outdir = "/group/jrigrp4/BS_teo20/WGBS/BSM", arrayjobs = "1-5",
             jobid = "bs1-5", email = "yangjl0930@gmail.com")

###>>> In this path: cd /home/jolyang/Documents/Github/methylation
###>>> RUN: sbatch -p med --mem 10000 --ntasks=4 slurm-script/run_bismark_array.sh
