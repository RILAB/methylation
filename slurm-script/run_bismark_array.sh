#!/bin/bash -l
#SBATCH -D /home/jolyang/Documents/Github/methylation
#SBATCH -o /home/jolyang/Documents/Github/methylation/slurm-log/testout-%j.txt
#SBATCH -e /home/jolyang/Documents/Github/methylation/slurm-log/err-%j.txt
#SBATCH -J bs1-5
#SBATCH --array=1-5
#SBATCH --mail-user=yangjl0930@gmail.com
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL #email if fails
set -e
set -u

module load bismark/0.14.3
module load bowtie2/2.2.5
sh slurm-script/run_bismark_$SLURM_ARRAY_TASK_ID.sh
