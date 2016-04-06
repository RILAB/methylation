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

cd /group/jrigrp4/BS_teo20/WGBS
fastq-dump --split-spot --split-3 -A SRR1610959.sra
fastq-dump --split-spot --split-3 -A SRR1610960.sra
fastq-dump --split-spot --split-3 -A SRR1610961.sra
fastq-dump --split-spot --split-3 -A SRR850328.sra
fastq-dump --split-spot --split-3 -A SRR850332.sra
