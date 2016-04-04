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

cd /group/jrigrp4/BS_teo20/RNA-seq
fastq-dump --split-spot --split-3 -A SRR1757965.sra
fastq-dump --split-spot --split-3 -A SRR1757978.sra
fastq-dump --split-spot --split-3 -A SRR1757990.sra
fastq-dump --split-spot --split-3 -A SRR1758014.sra
fastq-dump --split-spot --split-3 -A SRR1758021.sra
fastq-dump --split-spot --split-3 -A SRR1758029.sra
fastq-dump --split-spot --split-3 -A SRR1758044.sra
fastq-dump --split-spot --split-3 -A SRR1758055.sra
fastq-dump --split-spot --split-3 -A SRR1758067.sra
fastq-dump --split-spot --split-3 -A SRR1758079.sra
fastq-dump --split-spot --split-3 -A SRR1758091.sra
fastq-dump --split-spot --split-3 -A SRR1758104.sra
fastq-dump --split-spot --split-3 -A SRR1758128.sra
fastq-dump --split-spot --split-3 -A SRR1758140.sra
fastq-dump --split-spot --split-3 -A SRR1758152.sra
