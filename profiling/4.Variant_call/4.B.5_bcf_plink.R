### Jinliang Yang
### July 13th, 2016

### transform BCF to PLINK




library("farmeR")
cmd1 <- "cd largedata/gatk_vcf "
cmd2 <- "bgzip JRI20_joint_call.filtered_snps.vcf -@ 4"
cmd3 <- "tabix -p vcf JRI20_joint_call.filtered_snps.vcf.gz"
cmd4 <- "bcftools convert JRI20_joint_call.filtered_snps.vcf.gz -Ou -o JRI20_joint_call.filtered_snps.bcf"

set_farm_job(slurmsh = "largedata/GenSel/CL_test.sh",
             shcode = "sh largedata/myscript.sh", wd = NULL, jobid = "myjob",
             email = NULL, runinfo = c(TRUE, "bigmemh", "1"))

