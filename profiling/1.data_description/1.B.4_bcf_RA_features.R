### Jinliang Yang
### June 14th, 2016
### Extract RA from genomic features

#bcftools query -f '%ID\t%CO[\t%RA]\n' -r 1:0-10000 teo20_methratio.bcf -o test_RA.txt
library(farmeR)
# bcftools query -f '%ID\t%CO[\t%RA]\n' teo20_methratio.bcf -R AGPv2_bcf_exon.txt -o teo20_RA_exon.txt
shcode <- c("cd ~/Documents/Github/methylation/largedata/vcf_files",
            "bcftools query -f \'%ID\\t%CO[\\t%RA]\\n\' teo20_methratio.bcf -R AGPv2_bcf_exon.txt -o teo20_RA_exon.txt")
set_farm_job(slurmsh="slurm-script/run_bcfra.sh", shcode=shcode,
             wd=NULL, jobid="bcfra", email="yangjl0930@gmail.com",
             runinfo=c(FALSE, "bigmemh", "2"))

#bcftools query -f '%ID\t%CO[\t%RA]\n' -r 1:0-10000 teo20_methratio.bcf -o test_RA.txt
library(farmeR)
