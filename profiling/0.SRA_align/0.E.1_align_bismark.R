### Jinliang Yang
### Updates: June 24th, 2016

library("farmeR")

### prepare genome
cmd1 <- "module load bismark/0.14.3"
cmd2 <- "module load bowtie2/2.2.5"
cmd3 <- "bismark_genome_preparation --bowtie2 $HOME/Documents/Github/methylation/largedata/pgenome"

set_farm_job(slurmsh = "slurm-script/pgenome.sh",
             shcode = c(cmd1, cmd2, cmd3), wd = NULL, jobid = "pgenome",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemm", "8"))


### fastq file
### extract and gz fastq files
# for i in *.lz4; do lz4 -d $i; done
# for i in *.fastq; do gzip --fast $i; done
# for i in *.lz4; do rm $i; done

### prepare genome
cmd9 <- "mv /group/jrigrp4/BS_teo20/fastq/JRA2_TGACCA_R2.fastq.lz4 largedata/fastq/"
cmd0 <- "cd largedata/fastq"
cmd1 <- "for i in *.lz4; do"
cmd2 <- " lz4 -d $i > $i.fastq;"
cmd3 <- " rm $i;"
cmd4 <- " gzip $i.fastq"
cmd5 <- "done"
    
set_farm_job(slurmsh = "slurm-script/zip.sh",
             shcode = c(cmd0, cmd1, cmd2, cmd3, cmd4, cmd5), wd = NULL, jobid = "lz4",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemh", "8"))










# for i in *.lz4; do lz4 -d $i | gzip --fast -; done
files <- list.files(path="/group/jrigrp4/BS_teo20/fastq", pattern="lz4$", full.names = TRUE)
df <- data.frame(lz4=files, fq=files)

set_array_job(shid = "largedata/GenSel/CL_test.sh",
              shcode = "sh largedata/myscript.sh", arrayjobs = "1-700", wd = NULL,
              jobid = "myjob", email = NULL, runinfo = c(TRUE, "bigmemh", "1"))



fq1 <- list.files(path="largedata/fastq", pattern="R1.fastq.gz$", full.names = TRUE)
fq2 <- list.files(path="largedata/fastq", pattern="R2.fastq.gz$", full.names = TRUE)

bamfiles <- list.files(path="/group/jrigrp4/BS_teo20/WGBS/BSM", pattern="bam$", full.names = TRUE)


inputdf <- data.frame(fq1 = fq1[c(1,4)], 
                      fq2 = fq2[c(1,4)],
                      outbase = "test", 
                      bam = bamfiles[c(1,4)])

run_bismark(inputdf, genome = "/home/jolyang/dbcenter/AGP/AGPv2",
            outdir = "/home/jolyang/Documents/Github/methylation/largedata/bismark", 
            N = 1, align = TRUE,
            email = "yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemm", 8))

