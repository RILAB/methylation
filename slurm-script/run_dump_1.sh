cd /home/jolyang/dbcenter/Ecoli/fastq
fastq-dump --split-spot --split-3 -A SRR2921970.sra
rm SRR2921970.sra
gzip SRR2921970.sra_1.fastq
gzip SRR2921970.sra_2.fastq
