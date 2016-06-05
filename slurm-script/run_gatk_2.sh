### GATK pipeline created by farmeR
### Tue Apr 26 11:34:10 AM 2016

### Call variants in your sequence data
java -Xmx128g -jar $HOME/bin/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar \
-T HaplotypeCaller \
-R $HOME/dbcenter/AGP/AGPv2/Zea_mays.AGPv2.14.dna.toplevel.fa \
-I /home/jolyang/Documents/Github/methylation/largedata/gatk_vcf/JRIAL2C.sorted.dedup.RG.bam \
-ERC GVCF \
-o /home/jolyang/Documents/Github/methylation/largedata/gatk_vcf/JRIAL2C.g.vcf
