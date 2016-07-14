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
# But it seems that most software is using non-phred scale. So ANGSD uses the raw GP value. 
# The GL tag is interpreted as log10.

### Calculate thetas for each site in pop1.  TREAT AS UNFOLDED!
command11="-bam "$pop1List" -out "$outputdir"/"$pop1"_genic_windows -pest "$outputdir"/"$pop1"_genic.sfs -indF "$pop1F" -doSaf 2 -uniqueOnly 0 -anc "$anc" -minMapQ $minMapQ -minQ 20 -nInd $nIndPop1 -minInd $minIndPop1 -baq 1 -ref "$ref" -GL $glikehood -P $cpu -rf $regionfile -doThetas 1 -doMajorMinor 1 -doMaf 1"
echo $command11
echo
$angsdir/angsd $command11