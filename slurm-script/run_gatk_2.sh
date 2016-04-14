### GATK pipeline created by farmeR
### Mon Apr 11 11:55:52 AM 2016

### add read groups
java -Xmx128g -jar $HOME/bin/picard-tools-2.1.1/picard.jar AddOrReplaceReadGroups \
INPUT=/home/jolyang/dbcenter/BMfastq/bam/SRR447948.sorted.dedup.RG.bam \
OUTPUT=/home/jolyang/dbcenter/BMfastq/bam/SRR447948.sorted.dedup.RG.RG.bam \
SORT_ORDER=coordinate \
CREATE_INDEX=true \
RGID=g2 \
RGLB=lib2 \
RGPL=illumina \
RGPU=unit2 \
RGSM=B73


### Call variants in your sequence data
java -Xmx128g -jar $HOME/bin/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R $HOME/dbcenter/AGP/AGPv2/Zea_mays.AGPv2.14.dna.toplevel.fa \
-I /home/jolyang/dbcenter/BMfastq/bam/SRR447948.sorted.dedup.RG.RG.bam \
-ERC GVCF \
-o /home/jolyang/dbcenter/BMfastq/bam/SRR447986.g.vcf
