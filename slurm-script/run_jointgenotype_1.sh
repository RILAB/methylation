### GATK pipeline created by farmeR
### Thu Mar 31 12:03:59 PM 2016

### Performs joint genotyping on all samples together
java -Xmx32g -jar $HOME/bin/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R $HOME/dbcenter/AGP/AGPv2/Zea_mays.AGPv2.14.dna.toplevel.fa \
--variant /home/jolyang/dbcenter/BMfastq/bam/SRR447948.raw_variants.vcf \
--variant /home/jolyang/dbcenter/BMfastq/bam/SRR447986.raw_variants.vcf \
--includeNonVariantSites \
-o ~/dbcenter/BMfastq/bam/joint_call.vcf

