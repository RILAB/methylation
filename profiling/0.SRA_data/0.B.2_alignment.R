### Jinliang Yang
### March 1st, 2016

library(maizeR)

fq1 =list.files(path="/group/jrigrp4/BS_teo20/WGBS", pattern="1.fastq$")
fq2 =list.files(path="/group/jrigrp4/BS_teo20/WGBS", pattern="2.fastq$")

input_df <- data.frame(fq1=fq1, fq2=fq2)
input_df$out <- gsub("\\..*", "", input_df$fq1)

runa_bismark(input_df[-6,], genome="/home/jolyang/dbcenter/AGP/AGPv2",
             cpu=6, outdir="/group/jrigrp4/BS_teo20/WGBS/BSM", arrayjobs="1-5",
             jobid="bs1-5", email="yangjl0930@gmail.com")
