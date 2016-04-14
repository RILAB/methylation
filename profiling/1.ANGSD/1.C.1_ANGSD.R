### Jinliang Yang
### Feb 25th, 2016
### Using ANGSD to compute Tajima's D

# %s/G/A/g | %s/C/A/g | %s/T/A/g
# samtools faidx ZmB73_faked_v2.fasta 
# bcftools convert teo12_methratio.bcf.gz -r 10 -o test_chr10.vcf.gz -O z
# angsd -doSaf 1 -vcf-gl teo12_methratio.vcf.gz -anc ZmB73_faked_v2.fasta -fai ZmB73_faked_v2.fasta.fai -nind 12 -out outFold -fold 1

# angsd -vcf-gl file.vcf -fai hg19.fa.gz.fai -nind 10 -domaf 4

### TEST
# bcftools convert teo12_methratio.vcf.gz -r 1:1-1000 -o test.bcf.gz -O b
# angsd -doSaf 1 -vcf-gl test.vcf -anc ZmB73_faked_v2.fasta -fai ZmB73_faked_v2.fasta.fai -nind 12 -out outFold -fold 1

# NB The 4.2 version of the vcf specifiation clarifies that GP should be phred scaled post probs of the genotypes. 
# But it seems that most software is using non-phred scale. So ANGSD uses the raw GP value. The GL tag is interpreted as log10.
