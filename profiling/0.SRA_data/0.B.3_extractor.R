### Jinliang
### June 27th, 2016

library(data.table)
meth <- fread("largedata/bismark/SRR850332_pe.CX_report.txt")




#(III) Running the Bismark bismark_methylation_extractor
bismark_methylation_extractor -p --comprehensive --no_overlap --multicore 8 --buffer_size 50%  /group/jrigrp4/BS_teo20/WGBS/BSM/SRR1610959_pe.bam -o /home/jolyang/Documents/Github/methylation/largedata/maizebs/

bismark_methylation_extractor -s --bedGraph --counts --buffer_size 50% test_1.fastq_bismark_bt2_pe.bam

bismark_methylation_extractor -s --bedGraph --counts --buffer_size 10G --cytosine_report --genome_folder /home/jolyang/dbcenter/AGP/AGPv2 test_1.fastq_bismark_bt2_pe.bam



