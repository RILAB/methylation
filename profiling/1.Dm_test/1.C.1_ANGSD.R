

#angsd -doSaf 4 -vcf-gp teo12_methratio.vcf.gz -fai teo12_methratio.vcf.gz.csi -nind 12 -out test.txt

#NB The 4.2 version of the vcf specifiation clarifies that GP should be phred scaled post probs of the genotypes. But it seems that most software is using non-phred scale. So ANGSD uses the raw GP value. The GL tag is interpreted as log10.
