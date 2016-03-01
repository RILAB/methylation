#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	
#JRA2	JRB2	JRC1	JRC2	JRC3	JRD1	JRD3	JRE1	JRF1	JRG1	JRH1	JRH2
#bcftools query -f '%ID\t%CO[\t%CC]\n' -r 1 teo12_methratio.vcf.gz -o count_CC_chr1.txt
#bcftools query -f '%ID\t%CO[\t%CC]\n' -r 2 teo12_methratio.vcf.gz -o count_CC_chr2.txt
#bcftools query -f '%ID\t%CO[\t%CC]\n' -r 3 teo12_methratio.vcf.gz -o count_CC_chr3.txt
#bcftools query -f '%ID\t%CO[\t%CC]\n' -r 4 teo12_methratio.vcf.gz -o count_CC_chr4.txt
#bcftools query -f '%ID\t%CO[\t%CC]\n' -r 5 teo12_methratio.vcf.gz -o count_CC_chr5.txt
#bcftools query -f '%ID\t%CO[\t%CC]\n' -r 6 teo12_methratio.vcf.gz -o count_CC_chr6.txt
#bcftools query -f '%ID\t%CO[\t%CC]\n' -r 7 teo12_methratio.vcf.gz -o count_CC_chr7.txt
#bcftools query -f '%ID\t%CO[\t%CC]\n' -r 8 teo12_methratio.vcf.gz -o count_CC_chr8.txt
#bcftools query -f '%ID\t%CO[\t%CC]\n' -r 9 teo12_methratio.vcf.gz -o count_CC_chr9.txt
#bcftools query -f '%ID\t%CO[\t%CC]\n' -r 10 teo12_methratio.vcf.gz -o count_CC_chr10.txt

#bcftools query -f '%ID\t%CO[\t%CT]\n' teo12_methratio.vcf.gz -o count_CT.txt
#bcftools query -f '%ID\t%CO[\t%CT]\n' -r 1 teo12_methratio.vcf.gz -o count_CT_chr1.txt
#bcftools query -f '%ID\t%CO[\t%CT]\n' -r 2 teo12_methratio.vcf.gz -o count_CT_chr2.txt
#bcftools query -f '%ID\t%CO[\t%CT]\n' -r 3 teo12_methratio.vcf.gz -o count_CT_chr3.txt
#bcftools query -f '%ID\t%CO[\t%CT]\n' -r 4 teo12_methratio.vcf.gz -o count_CT_chr4.txt
#bcftools query -f '%ID\t%CO[\t%CT]\n' -r 5 teo12_methratio.vcf.gz -o count_CT_chr5.txt
#bcftools query -f '%ID\t%CO[\t%CT]\n' -r 6 teo12_methratio.vcf.gz -o count_CT_chr6.txt
#bcftools query -f '%ID\t%CO[\t%CT]\n' -r 7 teo12_methratio.vcf.gz -o count_CT_chr7.txt
#bcftools query -f '%ID\t%CO[\t%CT]\n' -r 8 teo12_methratio.vcf.gz -o count_CT_chr8.txt
#bcftools query -f '%ID\t%CO[\t%CT]\n' -r 9 teo12_methratio.vcf.gz -o count_CT_chr9.txt
#bcftools query -f '%ID\t%CO[\t%CT]\n' -r 10 teo12_methratio.vcf.gz -o count_CT_chr10.txt

#sbatch -p bigmemh slurm-script/run_bcf_merge.sh 

library("data.table", lib="~/bin/Rlib")

getration <- function(){
    for(i in 1:10){
        chr2 <- fread("largedata/vcf_files/count_CC_chr2.txt")
        
        cg <- subset(chr2, V2 %in% "CG")
        cg[cg=="."] <- 0
        #cg[is.na(cg)] <- 0
        
        #cg <- as.data.frame(cg)
        cg[,3:14] <- apply(cg[, 3:14], 2, as.numeric)
        
        cg$c <- apply(cg[, 3:14], 1, sum)
        
        
        ####
        ct <- fread("largedata/vcf_files/count_CT_chr2.txt")
        
        cg2 <- subset(ct, V2 %in% "CG")
        cg[cg=="."] <- 0
        cg[,3:14] <- apply(cg[, 3:14], 2, as.numeric)
        
        cg <- as.data.frame(cg)
        
        cg$c <- apply(cg[, 3:14], 1, sum)
        
    }
}


chg
chmatch()

