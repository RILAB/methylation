### Jinliang Yang
### Feb 25th, 2016
### Using ANGSD to compute Tajima's D

# %s/G/A/g | %s/C/A/g | %s/T/A/g
# samtools faidx ZmB73_faked_v2.fasta 

# bcftools filter teo20_methratio.bcf -i 'INFO/CO ~ "CG"' -r 1:1-1000 -o test_chr1_cg.vcf.gz -O z


# bcftools convert teo20_methratio.bcf -r 10:1-10000 -o test_chr10.vcf.gz -O z
# angsd -doSaf 1 -vcf-gl test_chr10.vcf.gz -anc ZmB73_faked_v2.fasta -fai ZmB73_faked_v2.fasta.fai -nind 20 -out out -fold 1

# realSFS out.saf.idx -P 1 > out.sfs


# angsd -vcf-gl test_chr10.vcf.gz -anc ZmB73_RefGen_v2.fasta -fai ZmB73_RefGen_v2.fasta.fai -nind 20 -out out -doSaf 1 -fold 1 -pest out.sfs -doThetas 1 

# thetaStat make_bed out.thetas.gz

# thetaStat do_stat out.thetas.gz -nChr 2 -win 500 -step 100  -outnames theta.thetasWindow.gz

### TEST
# bcftools convert teo12_methratio.vcf.gz -r 1:1-1000 -o test.bcf.gz -O b
# angsd -doSaf 1 -vcf-gl test.vcf -anc ZmB73_faked_v2.fasta -fai ZmB73_faked_v2.fasta.fai -nind 12 -out outFold -fold 1

# NB The 4.2 version of the vcf specifiation clarifies that GP should be phred scaled post probs of the genotypes. 
# But it seems that most software is using non-phred scale. So ANGSD uses the raw GP value. 
# The GL tag is interpreted as log10.
