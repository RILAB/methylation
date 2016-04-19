### Jinliang Yang
### April 13th, 2016


######################## Filtering the duplicated annotation #################
fgsv2 <- read.table("~/dbcenter/AGP/AGPv2/ZmB73_5b_FGS.gff", header=FALSE)
names(fgsv2) <- c("seqname", "source", "feature", "start", "end", "score",
                  "strand", "frame", "attribute")

gene <- subset(fgsv2, feature=="gene")

gene$attribute <- gsub("ID=", "", gene$attribute)
gene$attribute <- gsub(";.*", "", gene$attribute)
gene <- subset(gene, seqname %in% 1:10)
#39423

bed3 <- gene[, c("seqname", "start", "end")]
bed3$seqname <- as.character(bed3$seqname)
bed3 <- bed3[order(bed3$seqname, bed3$start),] #39423     3
write.table(bed3, "largedata/Dm/FGSv2_gene.txt", row.names=FALSE, col.names=FALSE, quote=FALSE, sep="\t")


##############
library(farmeR)
sh1 <- paste0("bcftools query -f \'%CHROM\\t%POS\\t%CO[\\t%GT]\\n\'", 
                 " -R ~/Documents/Github/methylation/largedata/Dm/FGSv2_gene.txt",
                 " ~/Documents/Github/methylation/largedata/vcf_files/teo20_methratio.bcf",
                 " -o ~/Documents/Github/methylation/largedata/Dm/FGSv2_gene_GT.txt")
sh2 <- 'sed \"s/\\//\\t/g\" FGSv2_gene_GT.txt > FGSv2_gene_GT_t.txt'
#sed "s/\//\t/g" FGSv2_gene_GT.txt > FGSv2_gene_GT_t.txt
set_farm_job(slurmsh="slurm-script/run_bcf_GT.sh", shcode=c(sh1, sh2),
             wd=NULL, jobid="bcf_gt", email="yangjl0930@gmail.com",
             runinfo=c(FALSE, "bigmemh", "2"))

############### directly query into gene regions.
library(farmeR)
source("lib/run_bcf_query.R")
inputdf <- gene
run_bcf_query(
    inputdf=gene, outdir="largedata/Dm/input_gene", cmdno=100,
    arrayshid = "slurm-script/run_bcf_query_array.sh",
    email= "yangjl0930@gmail.com", runinfo = c(FALSE, "med", 1)
)

###>>> In this path: cd /home/jolyang/Documents/Github/methylation
###>>> RUN: sbatch -p med --mem 2600 --ntasks=1 slurm-script/run_bcf_query_array.sh

