### Jinliang Yang
### Updates: June 24th, 2016

library("farmeR")

fq1 <- list.files(path="/group/jrigrp4/BS_teo20/WGBS/", pattern="sra_1.fastq$", full.names = TRUE)
fq2 <- list.files(path="/group/jrigrp4/BS_teo20/WGBS/", pattern="sra_2.fastq$", full.names = TRUE)

bamfiles <- list.files(path="/group/jrigrp4/BS_teo20/WGBS/BSM", pattern="bam$", full.names = TRUE)

inputdf <- data.frame(fq1 = fq1, 
                      fa2 = fq2,
                      outbase = "test", 
                      bam = bamfiles)

run_bismark(inputdf, genome = "/home/jolyang/dbcenter/AGP/AGPv2",
            outdir = "/home/jolyang/Documents/Github/methylation/largedata/bismark", 
            N = 1, align = FALSE,
            email = "yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemm", 8))

