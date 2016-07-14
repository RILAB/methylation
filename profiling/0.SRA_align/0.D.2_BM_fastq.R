### Jinliang Yang
### march 22th, 2016



#https://blog.liang2.tw/posts/2015/09/seqtk/
qc <- read.delim("~/dbcenter/BMfastq/qc.txt")
names(qc) <- gsub("X.", "", names(qc))

### gzip 
system("for i in *.gz; do gzip -dk $i; done")

system("for fq in SRR44797*.gz; do seqtk fqchk -q 20 $fq > $fq.qc; done")
