### Jinliang Yang
### April 28th, 2016
### Happy B-day JJ!


library("data.table")
chr10 <- fread("largedata/vcf_files/teo20_RA_chr10.txt")
chr10 <- as.data.frame(chr10)

idx <- sort(sample(1:nrow(chr10), 100000))
sub <- chr10[idx, ]





library(farmeR)


cmd1 <- "bcftools index teo20_cg_methratio.vcf.gz"
cmd2 <- "bcftools filter teo20_cg_methratio.vcf.gz - r 10 -o teo20_cg_mr_chr10.vcf.gz -O z"

"module load plink/1.90"

"plink -vcf teo20_cg_mr_chr10.vcf.gz --mac 2 "
"plink -vcf teo20_cg_mr_chr10.vcf.gz --r2 --threads 8 --memory 64000 --out teo20_cg_chr10 --ld-window 10 --ld-window-kb 1000 --ld-window-r2 0.15"

set_farm_job(slurmsh = "largedata/GenSel/CL_test.sh",
             shcode = "sh largedata/myscript.sh", wd = NULL, jobid = "myjob",
             email = NULL, runinfo = c(TRUE, "bigmemh", "1"))

