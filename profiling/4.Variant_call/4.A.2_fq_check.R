### Jinliang Yang
### use Li Heng's De novo assembly based variant calling pipeline
### 3/22/2016

fq <- list.files(path="/group/jrigrp/teosinte-parents/seq-merged", pattern="fastq.gz$", full.names = TRUE)
df <- data.frame(fq=fq, out=paste0("largedata/fqchk/", gsub(".*/", "", fq), ".qc"))

### run quality checking
run_fastq_qc(df, q=20, email=NULL, runinfo = c(FALSE, "bigmemh", 1))
    
    
##########################
files <- list.files(path="largedata/fqchk", pattern="qc", full.names=TRUE)

qc <- read.delim(files[1], skip = 2, header=FALSE)
names(qc) <- c("pos", "bases", "A", "C", "G", "T", "N", "avgQ", "errQ", "low", "high")
#POS     #bases  %A      %C      %G      %T      %N      avgQ    errQ    %low    %high

df <- data.frame()
for(i in 1:length(files)){
    qc <- read.delim(files[i], skip = 2, header=FALSE)
    names(qc) <- c("pos", "bases", "A", "C", "G", "T", "N", "avgQ", "errQ", "plow", "phigh")
    #bases <- nrow(qc) -1
    tem <- data.frame(qc[1, ], bp=nrow(qc) -1, file=files[i])
    df <- rbind(df, tem)
}
df$depth <- df$bases/2500000000

