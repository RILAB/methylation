### Jinliang Yang
### May 2nd, 2016

library("farmeR")
####### joint variant calling
gvcf <- list.files(path="largedata/gatk_vcf", pattern="g.vcf$", full.names = TRUE)
#gvcf <- gvcf[1]
length(gvcf) #18
outvcf <- "largedata/gatk_vcf/JRI18_joint_call.vcf"

run_GATK_JointGenotype(
    gvcf, outvcf,
    ref.fa="$HOME/dbcenter/AGP/AGPv2/Zea_mays.AGPv2.14.dna.toplevel.fa",
    gatkpwd="$HOME/bin/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar",
    includeNonVariantSites = FALSE,
    hardfilter= TRUE,
    snpflt="\"QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0\"",
    indelflt="\"QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0\"",
    email="yangjl0930@gmail.com",
    runinfo = c(TRUE, "bigmemm", 16)
)

#WARN  23:53:16,436 Interpreter - ![38,47]: 'QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0;' undefined variable MQRankSum 
#WARN  23:55:50,098 Interpreter - ![26,40]: 'QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0;' undefined variable ReadPosRankSum 

