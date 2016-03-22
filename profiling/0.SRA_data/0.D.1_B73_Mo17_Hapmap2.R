### Jinliang Yang
### march 22th, 2016

library(farmeR)
### downloading data
sra <- data.frame(SRR=c("SRR447967", "SRR447968", "SRR447969", "SRR447984", "SRR447985", "SRR447986"),
                  SRX=c("SRX131304", "SRX131305", "SRX131306", "SRX131321", "SRX131322", "SRX131323"),
                  pid=c( "CAUMO17", "CAUMO17", "CAUMO17", "B73", "B73", "B73"))
run_aspera(sra, maxspeed="200m", outdir="/home/jolyang/dbcenter/BMfastq",
           arrayjobs="1-6", jobid="aspera", email="yangjl0930@gmail.com")

system("sbatch -p med slurm-script/run_aspera_array.sh")

### dump the pe data into fastq
run_fq_dump(filepath = "/home/jolyang/dbcenter/BMfastq",
            slurmsh = "slurm-script/dump_BM.sh", rmsra = TRUE, email = "yangjl0930@gmail.com")
system("sbatch -p bigmemh slurm-script/dump_BM.sh")

