### Jinliang Yang
### GATK best practice to call SNP and InDels for teo20
### 4/6/2016

bamfile <- list.files(path="/group/jrigrp4/teosinte-parents/20parents/bams",
                      pattern="sorted.*bam$", full.names=TRUE)
inputdf <- data.frame(
    bam=bamfile, 
    out=gsub(".*20parents/bams","/home/jolyang/Documents/Github/methylation/largedata/gatk_vcf", bamfile), 
    group="teo", 
    sample=gsub(".*sorted.|_index.*", "", bamfile),
    PL="illumina", LB="lib1", PU="unit1")
inputdf$out <- gsub("sorted.|_index.*", "", inputdf$out)
###########
library(farmeR)
run_GATK(inputdf, 
         ref.fa="$HOME/dbcenter/AGP/AGPv2/Zea_mays.AGPv2.14.dna.toplevel.fa",
         gatkpwd="$HOME/bin/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar",
         picardpwd="$HOME/bin/picard-tools-2.1.1/picard.jar",
         minscore = 5,
         markDup=TRUE, realignInDels=FALSE, indels.vcf="indels.vcf",
         recalBases=FALSE, dbsnp.vcf="dbsnp.vcf", 
         email="yangjl0930@gmail.com",
         runinfo = c(TRUE, "bigmemm", 8))

####### joint variant calling
gvcf <- list.files(path="~/dbcenter/BMfastq/bam", pattern="g.vcf$", full.names = TRUE)
outvcf <- "~/dbcenter/BMfastq/bam/joint_call.vcf"
run_GATK_JointGenotype(
    gvcf, outvcf,
    ref.fa="$HOME/dbcenter/AGP/AGPv2/Zea_mays.AGPv2.14.dna.toplevel.fa",
    gatkpwd="$HOME/bin/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar",
    includeNonVariantSites = FALSE,
    hardfilter= TRUE,
    snpflt="\"QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0\"",
    indelflt="\"QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0\"",
    email="yangjl0930@gmail.com",
    runinfo = c(TRUE, "bigmemh", 4)
)

#WARN  23:53:16,436 Interpreter - ![38,47]: 'QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0;' undefined variable MQRankSum 
#WARN  23:55:50,098 Interpreter - ![26,40]: 'QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0;' undefined variable ReadPosRankSum 