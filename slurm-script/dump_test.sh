#!/bin/bash
#SBATCH -D /home/jolyang/Documents/Github/methylation
#SBATCH -o /home/jolyang/Documents/Github/methylation/slurm-log/testout-%j.txt
#SBATCH -e /home/jolyang/Documents/Github/methylation/slurm-log/err-%j.txt
#SBATCH -J dump
#SBATCH --mail-user=yangjl0930@gmail.com
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL #email if fails
set -e
set -u

cd /home/jolyang/dbcenter/Ecoli/fastq
fastq-dump --split-spot --split-3 -A ERR877647.sra
fastq-dump --split-spot --split-3 -A ERR877648.sra
rm *sra
