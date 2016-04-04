cd /home/jolyang/dbcenter/BMfastq
fastq-dump --split-spot --split-3 -A SRR447977.sra
rm SRR447977.sra
gzip SRR447977.sra_1.fastq
gzip SRR447977.sra_2.fastq
