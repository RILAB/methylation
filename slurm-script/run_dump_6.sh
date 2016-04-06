cd /home/jolyang/dbcenter/BMfastq
fastq-dump --split-spot --split-3 -A SRR447978.sra
rm SRR447978.sra
gzip SRR447978.sra_1.fastq
gzip SRR447978.sra_2.fastq
