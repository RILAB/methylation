### Jinliang Yang
### April 13th, 2016

library("farmeR")

files <- list.files(path="largedata/Dm/gene_input", full.names=TRUE)
inputdf <- data.frame(file=files, out="n")
run_Rcodes(
    inputdf, outdir="largedata/Dm/shfolder", cmdno=100,
    rcodes = "$HOME/Documents/Github/methylation/profiling/2.Dm_tile/2.A.2_code_cformat_gene.R",
    arrayshid = "slurm-script/run_cformat_gene.sh",
    email="yangjl0930@gmail.com", runinfo = c(TRUE, "med", 1)
)


########### collect length file and rm *.len
library(plyr)
file1 <- list.files(path="largedata/Dm/gene_CG", pattern="len$", full.names=TRUE)

df1 <- rbind.fill(lapply(file1, read.table, header=TRUE))
df1$file <- gsub(".*/", "", df1$file)

#system("cd largedata/Dm/gene_CG/; mkdir cg_input; rm *out")
system("cd largedata/Dm/gene_CG/; mkdir cg_input; rm *len; mv *_cg cg_input")
write.table(df1, "largedata/Dm/gene_CG/gene_CG_length.txt", sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

file2 <- list.files(path="largedata/Dm/gene_CHG", pattern="len$", full.names=TRUE)
df2 <- rbind.fill(lapply(file2, read.table, header=TRUE))
df2$file <- gsub(".*/", "", df2$file)
system("cd largedata/Dm/gene_CHG/; mkdir chg_input; rm *len; mv *_chg chg_input")
write.table(df2, "largedata/Dm/gene_CHG/gene_CHG_length.txt", sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)


file3 <- list.files(path="largedata/Dm/gene_CHH", pattern="len$", full.names=TRUE)
df3 <- rbind.fill(lapply(file3, read.table, header=TRUE))
df3$file <- gsub(".*/", "", df3$file)
system("cd largedata/Dm/gene_CHH/; mkdir chh_input; rm *len; mv *_chh chh_input")
write.table(df3, "largedata/Dm/gene_CHH/gene_CHH_length.txt", sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)









