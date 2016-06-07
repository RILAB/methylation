### GATK pipeline created by farmeR
### Fri May 13 02:24:15 PM 2016

### Mark duplicates
java -Xmx128g -jar $HOME/bin/picard-tools-2.1.1/picard.jar MarkDuplicates \
INPUT=/group/jrigrp4/teosinte-parents/20parents/bams/sorted.JRIAL2G_index7.bam \
OUTPUT=/home/jolyang/Documents/Github/methylation/largedata/gatk_vcf/JRIAL2G.sorted.dedup.bam \
METRICS_FILE=/home/jolyang/Documents/Github/methylation/largedata/gatk_vcf/JRIAL2G_metrics.txt

java -Xmx128g -jar $HOME/bin/picard-tools-2.1.1/picard.jar BuildBamIndex \
INPUT=/home/jolyang/Documents/Github/methylation/largedata/gatk_vcf/JRIAL2G.sorted.dedup.bam

samtools flagstat /group/jrigrp4/teosinte-parents/20parents/bams/sorted.JRIAL2G_index7.bam > /home/jolyang/Documents/Github/methylation/largedata/gatk_vcf/JRIAL2G.sorted.bam.log

### add read groups
java -Xmx128g -jar $HOME/bin/picard-tools-2.1.1/picard.jar AddOrReplaceReadGroups \
INPUT=/home/jolyang/Documents/Github/methylation/largedata/gatk_vcf/JRIAL2G.sorted.dedup.bam \
OUTPUT=/home/jolyang/Documents/Github/methylation/largedata/gatk_vcf/JRIAL2G.sorted.dedup.RG.bam \
SORT_ORDER=coordinate \
CREATE_INDEX=true \
RGID=1 \
RGLB=lib1 \
RGPL=illumina \
RGPU=unit1 \
RGSM=JRIAL2G


### Call variants in your sequence data
java -Xmx128g -jar $HOME/bin/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R $HOME/dbcenter/AGP/AGPv2/Zea_mays.AGPv2.14.dna.toplevel.fa \
-I /home/jolyang/Documents/Github/methylation/largedata/gatk_vcf/JRIAL2G.sorted.dedup.RG.bam \
-ERC GVCF \
-o /home/jolyang/Documents/Github/methylation/largedata/gatk_vcf/JRIAL2G.g.vcf
