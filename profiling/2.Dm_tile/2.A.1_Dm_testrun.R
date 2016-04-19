### Jinliang Yang
### Feb 17th, 2016


library(farmeR)
shcode <- c("cd ~/Documents/Github/methylation/largedata/vcf_files",
            "bcftools query -f '%CHROM\t%POS\t%CO[\t%GT]\n' -r 1:0-10000 teo20_methratio.bcf -o test_GT.txt")
set_farm_job(slurmsh="slurm-script/run_bcf_RA.sh", shcode=shcode,
             wd=NULL, jobid="bcfra", email="yangjl0930@gmail.com",
             runinfo=c(TRUE, "bigmemh", "2"))


test <- read.table("largedata/Dm/test_GT.txt", header=FALSE)
test$V3 <- apply(test, 1, function(x) sum(x=="."))
test <- subset(test, V3==0)
write.table(test[, -3], "largedata/Dm/test_input.txt", sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

lenlist <- data.frame(locus_name="test_input", the_sequence_length_of_methylation_state=3485)
write.table(lenlist, "largedata/Dm/lenlist.txt", sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

# alpha_estimation.pl
#alpha_estimation.pl -dir /home/jolyang/Documents/Github/methylation/largedata/Dm -output /home/jolyang/Documents/Github/methylation/largedata/smp_a.txt -length_list /home/jolyang/Documents/Github/methylation/largedata/Dm/lenlist.txt

#Dm_methylation.pl -input gene_CG/GRMZM2G137108_cg -output out_dm.txt -length 20 -alpha 1000000


library("data.table", lib="~/bin/Rlib")

cg1 <- fread("/group/jrigrp4/BS_teo20/SP028-029_JR_100bp_CG.tab", header=TRUE)
cg2 <- fread("/group/jrigrp4/BS_teo20/SP029_2-3_JR_100bp_CG.tab", header=TRUE)

cg1 <- as.data.frame(cg1)
cg2 <- as.data.frame(cg2)






