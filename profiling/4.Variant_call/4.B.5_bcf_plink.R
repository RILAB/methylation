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

### annotate VCF file and remove unknown regions
cmd1 <- "cd largedata/gatk_vcf "
#"-e 'CHROM ~ \"UNKNOWN\" | CHROM ~ \"mitochondrion\" | CHROM ~ \"chloroplast\" '",
cmd2 <- paste("bcftools annotate --set-id +'%CHROM\\_%POS'", 
              "JRI20_joint_call.filtered_snps.bcf",
              "-Ob -o JRI20_filtered_snps_annot.bcf")

set_farm_job(slurmsh = "slurm-script/bcf_annot.sh",
             shcode = c(cmd1, cmd2), wd = NULL, jobid = "bcf",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemm", "8"))




### MAF and Missingness

cmd1 <- "cd largedata/gatk_vcf"
cmd2 <- "plink --bfile JRI20 --allow-extra-chr --out JRI20_stat --freq counts --missing --het --ibc"

set_farm_job(slurmsh = "slurm-script/plink_stat.sh",
             shcode = c(cmd1, cmd2), wd = NULL, jobid = "pstat",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemm", "16"))

### plot
library(data.table)

frq <- fread("largedata/gatk_vcf/JRI20_stat.frq.counts")
#G0	Missing genotype count (so C1 + C2 + 2 * G0 is constant on autosomal variants)

frq$missing <- round(frq$G0/20, 3)
frq$maf <- round(frq$C1/frq$C2, 3)

pdf("graphs/teo20_miss_maf.pdf", height=6, width=10)
par(mfrow=c(1, 2))
hist(frq$missing, breaks=100, main="Missing rate (N=20)", xlab="missing", col="#cdaa7d")
hist(frq$maf, breaks=100, main="Minor allele frq (N=20)", xlab="frq", col="#cdaa7d")
dev.off()



