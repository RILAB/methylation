### Jinliang Yang
### April 13th, 2016


library("farmeR")

files <- list.files(path="largedata/Dm/region_input", full.names=TRUE)
inputdf <- data.frame(file=files, out="n")
run_Rcodes(
    inputdf, outdir="largedata/Dm/shfolder", cmdno=100,
    rcodes = "$HOME/Documents/Github/methylation/profiling/2.Dm_tile/2.B.2_code_cformat_region.R",
    arrayshid = "slurm-script/run_cformat_region.sh",
    email="yangjl0930@gmail.com", runinfo = c(TRUE, "med", 1)
)


########### collect length file and rm *.len
library(plyr)
files <- list.files(path="largedata/Dm/region_CG", pattern="len$", full.names=TRUE)

df1 <- rbind.fill(lapply(files, read.table, header=TRUE))
df1$file <- gsub(".*/", "", df1$file)
write.table(df1, "largedata/Dm/region_CG_length.txt", sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)

file2 <- list.files(path="largedata/Dm/region_CHG", pattern="len$", full.names=TRUE)
df2 <- rbind.fill(lapply(file2, read.table, header=TRUE))
df2$file <- gsub(".*/", "", df2$file)
write.table(df2, "largedata/Dm/region_CHG_length.txt", sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)


file3 <- list.files(path="largedata/Dm/region_CHH", pattern="len$", full.names=TRUE)
df3 <- rbind.fill(lapply(file3, read.table, header=TRUE))
df3$file <- gsub(".*/", "", df3$file)
write.table(df3, "largedata/Dm/region_CHH_length.txt", sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)


