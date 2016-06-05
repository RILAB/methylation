### Jinliang Yang
### April 28th, 2016
### Happy B-day JJ!


library("data.table")


"module load plink/1.90"

"plink -vcf teo20_cg_methratio.vcf.gz --r2 --threads 8 --memory 64000 --out teo20_cg --allow-extra-chr"


library("farmeR")
sh1 <- "sh data/iget.sh"
set_farm_job(slurmsh = "slurm-script/run_fq.sh",
             shcode = sh1, wd = NULL, jobid = "fastq",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemh", "1"))


