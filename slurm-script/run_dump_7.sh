cd /home/jolyang/dbcenter/BMfastq
fastq-dump --split-spot --split-3 -A SRR447979.sra
rm SRR447979.sra
gzip SRR447979.sra_1.fastq
gzip SRR447979.sra_2.fastq
