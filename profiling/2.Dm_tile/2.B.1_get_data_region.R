### Jinliang Yang
### April 13th, 2016


get_region <- function(binsize=100000){
    chrlen <- read.table("~/dbcenter/AGP/AGPv2/ZmB73_RefGen_v2.fasta.fai")
    chrlen <- chrlen[1:10, 1:2]
    names(chrlen) <- c("chr", "length")
    
    df <- data.frame()
    for(i in 1:10){
        ###
        tot <- ceiling(chrlen$length[i]/binsize)
        tem <- data.frame(seqname=i, start= binsize*(1:tot - 1) + 1, end=binsize*(1:tot))
        tem$attribute <- paste(tem$seqname, tem$start, sep="_")
        df <- rbind(df, tem)
    }
    return(df)
}

####### get 10589 100-kb regions
regs <- get_region(binsize=100000)



############### directly query into gene regions.
source("lib/run_bcf_query.R")

library(farmeR)

run_bcf_query(
    inputdf=regs, outdir="largedata/Dm/input_region", cmdno=100,
    arrayshid = "slurm-script/run_bcf_query_array.sh",
    email= "yangjl0930@gmail.com", runinfo = c(TRUE, "med", 1)
)

###>>> In this path: cd /home/jolyang/Documents/Github/methylation
###>>> RUN: sbatch -p med --mem 2600 --ntasks=1 slurm-script/run_bcf_query_array.sh

