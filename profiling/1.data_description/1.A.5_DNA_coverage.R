### Jinliang Yang
### April 11th, 2016

library("data.table")


chr10 <- fread("largedata/vcf_files/teo20_RA_chr10.txt")

cg <- chr10[V2 == "CG"] #12185424       22
chg <- chr10[V2 == "CHG"] #10689235       22
chh <- chr10[V2 == "CHH"] #42327613       22


save(file="largedata/chr10.RData", list=c("chr10", "gerp1", "gerp2"))


cg <- cg[, .(V1, V2)]
cg <- as.data.frame(cg)
cg$chr <- gsub("_.*", "", cg$V1)
cg$start <- gsub(".*_", "", cg$V1)
cg$end <- cg$start
cg$start <- as.numeric(as.character(cg$start)) - 1
write.table(cg[, c("chr", "start", "end")], "largedata/gatk_vcf/cg_chr10.bed", row.names=FALSE, col.names=FALSE,
            sep="\t", quote=FALSE)

# bedtools coverage -a cg_test.bed -b JRIAL2A.sorted.dedup.RG.bam -sorted -counts > test.out

#bgzip JRIAL2A.g.vcf; tabix -p JRIAL2A.g.vcf.gz
#bcftools query -r 1:100-200 -f '%CHROM\t%POS\t%REF[\t%SAMPLE=%DP]\n' JRIAL2A.g.vcf 

       