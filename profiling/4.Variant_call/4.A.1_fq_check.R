### Jinliang Yang
### use Li Heng's De novo assembly based variant calling pipeline
### 3/22/2016

fq <- list.files(path="/group/jrigrp/teosinte-parents/seq-merged", pattern="fastq.gz$", full.names = TRUE)


for(i in 1:length(fq)){
    shid <- paste0("slurm-script/run_fqchk_", i, ".sh")
    command <- paste0("seqtk fqchk -q 20 ", fq[i], " > ", paste0("largedata/fqchk/", gsub(".*/", "", fq[i]), ".qc"))
    cat(command, file=shid, sep="\n", append=FALSE)
}
shcode <- paste("sh slurm-script/run_fqchk_$SLURM_ARRAY_TASK_ID.sh", sep="\n")

set_array_job2(shid="slurm-script/run_fqchk_run.sh", shcode=shcode,
              arrayjobs="1-40", wd=NULL, jobid="myjob", email=NULL,
              run = c(TRUE, "med", "5200", "2"))



