cd /home/jolyang/dbcenter/BMfastq
fastq-dump --split-spot --split-3 -A SRR447976.sra
rm SRR447976.sra
gzip SRR447976.sra_1.fastq
gzip SRR447976.sra_2.fastq
