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

cd /home/jolyang/dbcenter/BMfastq
fastq-dump --split-spot --split-3 -A SRR447948.sra
fastq-dump --split-spot --split-3 -A SRR447949.sra
fastq-dump --split-spot --split-3 -A SRR447950.sra
fastq-dump --split-spot --split-3 -A SRR447967.sra
fastq-dump --split-spot --split-3 -A SRR447968.sra
fastq-dump --split-spot --split-3 -A SRR447969.sra
fastq-dump --split-spot --split-3 -A SRR447970.sra
fastq-dump --split-spot --split-3 -A SRR447971.sra
fastq-dump --split-spot --split-3 -A SRR447972.sra
fastq-dump --split-spot --split-3 -A SRR447973.sra
fastq-dump --split-spot --split-3 -A SRR447974.sra
fastq-dump --split-spot --split-3 -A SRR447975.sra
fastq-dump --split-spot --split-3 -A SRR447976.sra
fastq-dump --split-spot --split-3 -A SRR447977.sra
fastq-dump --split-spot --split-3 -A SRR447978.sra
fastq-dump --split-spot --split-3 -A SRR447979.sra
rm *sra
