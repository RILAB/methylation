### Jinliang Yang
### May 2nd, 2016

library("farmeR")
####### joint variant calling
gvcf <- list.files(path="largedata/gatk_vcf", pattern="g.vcf$", full.names = TRUE)
#gvcf <- gvcf[1]
length(gvcf) #20
outvcf <- "largedata/gatk_vcf/JRI20_joint_call.vcf"


### http://gatkforums.broadinstitute.org/gatk/discussion/2806/howto-apply-hard-filters-to-a-call-set
run_GATK_JointGenotype(
    gvcf, outvcf,
    ref.fa="$HOME/dbcenter/AGP/AGPv2/Zea_mays.AGPv2.14.dna.toplevel.fa",
    gatkpwd="$HOME/bin/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar",
    includeNonVariantSites = FALSE,
    hardfilter= TRUE,
    snpflt="\"QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0\"",
    indelflt="\"QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0\"",
    email="yangjl0930@gmail.com",
    runinfo = c(TRUE, "bigmemm", 32)
)


### transform to BCF 
library("farmeR")
cmd1 <- "cd largedata/gatk_vcf "
cmd2 <- "bgzip JRI20_joint_call.filtered_snps.vcf -@ 4"
cmd3 <- "tabix -p vcf JRI20_joint_call.filtered_snps.vcf.gz"
cmd <- "bcftools convert JRI20_joint_call.filtered_snps.vcf -r 1:1-1000 -Ou -o JRI20_joint_call.filtered_snps"


set_farm_job(slurmsh = "largedata/GenSel/CL_test.sh",
             shcode = "sh largedata/myscript.sh", wd = NULL, jobid = "myjob",
             email = NULL, runinfo = c(TRUE, "bigmemh", "1"))



###
files <- list.files(path = "largedata/gatk_vcf", pattern="\\.-.*png", full.names = TRUE, all.files=TRUE)
file.rename(from=files, to=gsub("\\.-", "", files))
            
            