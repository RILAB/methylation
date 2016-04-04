cd /home/jolyang/dbcenter/BMfastq
fastq-dump --split-spot --split-3 -A SRR447975.sra
rm SRR447975.sra
gzip SRR447975.sra_1.fastq
gzip SRR447975.sra_2.fastq
