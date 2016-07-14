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

### prepare fastq files
cmd9 <- "mv /group/jrigrp4/BS_teo20/fastq/*.lz4 largedata/fastq/"
cmd0 <- "cd largedata/fastq"
cmd1 <- "for i in *.lz4; do"
cmd2 <- " lz4 -d $i > $i.fastq;"
cmd3 <- " rm $i;"
cmd4 <- " gzip $i.fastq"
cmd5 <- "done"
    
set_farm_job(slurmsh = "slurm-script/gzip.sh",
             shcode = c(cmd9, cmd0, cmd1, cmd2, cmd3, cmd4, cmd5), wd = NULL, jobid = "lz4",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemm", "8"))






########### alignment


