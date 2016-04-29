### Jinliang Yang
### April 28th, 2016
### Happy B-day JJ!


library("data.table")
ld <- fread("largedata/vcf_files/teo20_cg.ld")


chr2 <- ld[CHR_A ==2 ]

ld[, dis := round((BP_B - BP_A)/1000, 0)]



chr2[, dis := round((BP_B - BP_A)/10, 0)]

chr2[, dis := round((BP_B - BP_A)/10, 0)]

sum10bp <- chr2[,.(mr2 = mean(R2)), by=.(dis)] 
write.table(sum10bp, "cache/ld_chr2_sum10bp.csv", sep=",", row.names=FALSE, quote=FALSE)


