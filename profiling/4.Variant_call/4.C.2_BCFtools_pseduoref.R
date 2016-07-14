### Jinliang Yang
### July 13th, 2016


library(farmeR)

###
"samtools faidx $HOME/dbcenter/AGP/AGPv2/Zea_mays.AGPv2.14.dna.toplevel.fa 1:1-10000 | bcftools consensus -i JRI20_joint_call.filtered_snps.vcf.gz -o out1.fa"
"samtools faidx $HOME/dbcenter/AGP/AGPv2/Zea_mays.AGPv2.14.dna.toplevel.fa 1:1-10000 | bcftools consensus JRI20_joint_call.filtered_snps.vcf.gz -o out2.fa"
"samtools faidx $HOME/dbcenter/AGP/AGPv2/Zea_mays.AGPv2.14.dna.toplevel.fa 1:1-10000 > out0.fa"

"bcftools consensus -i -s NA001 -f in.fa in.vcf.gz > out.fa"


run_pseudoref(inputdf,
              ref.fa="$HOME/dbcenter/AGP/AGPv2/Zea_mays.AGPv2.14.dna.toplevel.fa",
              gatkpwd="$HOME/bin/GenomeAnalysisTK-3.5/GenomeAnalysisTK.jar",
              email="yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemh", 8))



