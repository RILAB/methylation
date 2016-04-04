### GATK pipeline created by farmeR
### Thu Mar 31 12:08:17 PM 2016

### Generate a SAM file containing aligned reads
bwa mem -M -R '@RG\tID:g1\tSM:Mo17\tPL:illumina\tLB:lib1\tPU:unit1'  -t 4 -p $HOME/dbcenter/AGP/AGPv2/Zea_mays.AGPv2.14.dna.toplevel.fa /home/jolyang/dbcenter/BMfastq/SRR447948.sra_1.fastq.gz /home/jolyang/dbcenter/BMfastq/SRR447948.sra_2.fastq.gz > /home/jolyang/dbcenter/BMfastq/bam/SRR447948.aln.sam

java -Xmx32g -jar $HOME/bin/picard-tools-2.1.1/picard.jar SortSam \
    INPUT=/home/jolyang/dbcenter/BMfastq/bam/SRR447948.aln.sam \
    OUTPUT=/home/jolyang/dbcenter/BMfastq/bam/SRR447948.sorted.bam \
    SORT_ORDER=coordinate
rm /home/jolyang/dbcenter/BMfastq/bam/SRR447948.aln.sam

java -Xmx32g -jar $HOME/bin/picard-tools-2.1.1/picard.jar MarkDuplicates \
INPUT=/home/jolyang/dbcenter/BMfastq/bam/SRR447948.sorted.bam \
OUTPUT=/home/jolyang/dbcenter/BMfastq/bam/SRR447948.sorted.dedup.bam \
METRICS_FILE=/home/jolyang/dbcenter/BMfastq/bam/SRR447948_metrics.txt
rm /home/jolyang/dbcenter/BMfastq/bam/SRR447948.sorted.bam

java -Xmx32g -jar $HOME/bin/picard-tools-2.1.1/picard.jar BuildBamIndex \
INPUT=/home/jolyang/dbcenter/BMfastq/bam/SRR447948.sorted.dedup.bam

### Call variants in your sequence data
java -Xmx32g -jar $HOME/bin/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R $HOME/dbcenter/AGP/AGPv2/Zea_mays.AGPv2.14.dna.toplevel.fa \
-I /home/jolyang/dbcenter/BMfastq/bam/SRR447948.sorted.dedup.bam \
--genotyping_mode DISCOVERY \
-stand_emit_conf 10 \
-stand_call_conf 30 \
-o /home/jolyang/dbcenter/BMfastq/bam/SRR447948.raw_variants.vcf
