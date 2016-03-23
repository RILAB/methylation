### Jinliang Yang
### use Li Heng's De novo assembly based variant calling pipeline

f1 <- list.files(path="/group/jrigrp/teosinte-parents/seq-merged", pattern="1.fastq.gz", full.names=TRUE)
f2 <- list.files(path="/group/jrigrp/teosinte-parents/seq-merged", pattern="2.fastq.gz", full.names=TRUE)
fq <- data.frame(fq1=f1, fq2=f2, out="/home/jolyang/Documents/Github/methylation/largedata/denovocall")

a1 <- gsub("_1.fastq.gz", "", fq$fq1)
a2 <- gsub("_2.fastq.gz", "", fq$fq2)
sum(a1 != a2)


fq$out <- paste(fq$out, gsub(".*Sample_|_index.*", "", fq$fq1), sep="/")

library(farmeR)
run_fermikit(fq, kitpath="/home/jolyang/bin/fermikit/fermi.kit",
             s='2.5g', t=16, l=100, arrayjobs="1",
             jobid="fermi", email="yangjl0930@gmail.com")

###>>> In this path: cd /home/jolyang/Documents/Github/methylation
###>>> RUN: sbatch -p bigmemh --mem=128000 --ntasks=16 slurm-script/run_fermikit_array.sh