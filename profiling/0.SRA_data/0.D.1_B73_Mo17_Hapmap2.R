### Jinliang Yang
### march 22th, 2016

library(farmeR)
### downloading data
hmp2 <- read.delim("data/SraRunTable_hmp2.txt")

library("plyr")
res <- ddply(hmp2, .(Sample_Name_s), summarise,
              mbase = sum(MBases_l))
res <- res[order(res$mbase),]
res$mbase <- res$mbase/1000*2/2.5
hist(res$mbase/1000*2/2.5)


##### only download B73 and mo17
idx1 <- grep( ".*MO17", hmp2$Sample_Name_s)
idx2 <- grep( ".*B73", hmp2$Sample_Name_s)

sra <- hmp2[c(idx1, idx2),]
sra <- sra[, c("Run_s", "Experiment_s", "MBases_l", "Sample_Name_s")]
names(sra) <- c("SRR", "SRX", "mbase", "pid")
write.table(sra, "/home/jolyang/dbcenter/BMfastq/sampleid.txt", sep="\t", row.names=FALSE, quote=FALSE )
res <- ddply(sra, .(pid), summarise,
             mbase = sum(mbase),
             cov = sum(mbase)/2000)

run_aspera(sra, maxspeed="200m", outdir="/home/jolyang/dbcenter/BMfastq",
           arrayjobs="1-16", jobid="aspera", email="yangjl0930@gmail.com")

system("sbatch -p med slurm-script/run_aspera_array.sh")

##### dump the pe data into fastq
run_fq_dump(filepath = "/home/jolyang/dbcenter/BMfastq",
            slurmsh = "slurm-script/dump_BM.sh", rmsra = TRUE, email = "yangjl0930@gmail.com")
system("sbatch -p bigmemh slurm-script/dump_BM.sh")

run_fq_dump2(filepath = "/home/jolyang/dbcenter/BMfastq",
             rmsra=TRUE, gzip=TRUE, email = "yangjl0930@gmail.com",
             run=c(TRUE, "med", "2600", "1"))




