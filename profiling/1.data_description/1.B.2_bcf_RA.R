### Jinliang Yang
### BCF to RA by chr
### 4/11/2016

#bcftools query -f '%ID\t%CO[\t%RA]\n' -r 1:0-10000 teo20_methratio.bcf -o test_RA.txt
library(farmeR)
shcode <- c("cd ~/Documents/Github/methylation/largedata/vcf_files",
            "bcftools query -f \'%ID\\t%CO[\\t%RA]\\n\' teo20_methratio.bcf -o teo20_RA.txt")
set_farm_job(slurmsh="slurm-script/run_bcfra.sh", shcode=shcode,
             wd=NULL, jobid="bcfra", email="yangjl0930@gmail.com",
             runinfo=c(FALSE, "bigmemh", "2"))

#bcftools query -f '%ID\t%CO[\t%RA]\n' -r 1:0-10000 teo20_methratio.bcf -o test_RA.txt
library(farmeR)

for(i in 1:10){
    shid <- paste0("slurm-script/run_bcfra_", i, ".sh")
    cat("### bcftools view created by farmeR",
        paste("###", format(Sys.time(), "%a %b %d %X %Y")),
        paste(""),
        "cd ~/Documents/Github/methylation/largedata/vcf_files",
        paste0("bcftools query -f \'%ID\\t%CO[\\t%RA]\\n\' teo20_methratio.bcf -r ", 
               i," -o teo20_RA_chr", i, ".txt"),
        file=shid, sep="\n", append=FALSE)
}

shcode <- paste("sh slurm-script/run_bcfra_$SLURM_ARRAY_TASK_ID.sh", sep="\n")
set_array_job(shid="slurm-script/run_bcfra_array.sh",
              shcode=shcode, arrayjobs="1-10",
              wd=NULL, jobid="bcfra", 
              email="yangjl0930@gmail.com", runinfo=c(FALSE, "med", 2))

