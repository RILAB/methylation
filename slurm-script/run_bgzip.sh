#!/bin/bash -l
#SBATCH -D /home/jolyang/Documents/Github/methylation
#SBATCH -o /home/jolyang/Documents/Github/methylation/slurm-log/testout-%j.txt
#SBATCH -e /home/jolyang/Documents/Github/methylation/slurm-log/err-%j.txt
#SBATCH -J bigzip
#SBATCH --array=1-12
#SBATCH --mail-user=yangjl0930@gmail.com
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL #email if fails
set -e
set -u

sh slurm-script/run_bgzip_$SLURM_ARRAY_TASK_ID.sh
