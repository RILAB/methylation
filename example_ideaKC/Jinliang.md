Jinliang's ideas
=============

## Idea 1: Identification of differentially methylated regions (DMR) in Zea

- Using the Bisulfite Sequencing (BS) mapper to map the reads
- Call DMR across the genotypes (20 teosinte and 5 maize)
- Clustering the DMR and identify the variations among teosinte, among maize and between teosinte and maize   

#### BS Mapper:
1. rmapbs
2. BSSeeker: uses a three nucleotide alphabet strategy
3. BSMAP: allows for gaps during mapping

#### Clustering:
- A-clustering software in [R-package](https://github.com/PeteHaitch/Aclust) and
[Python-implements](https://github.com/brentp/aclust/)

This software could cluster methylation data which we know to be locally correlated. We can use this to reduce the number of tests (of association) from 1 test per CpG, to 1 test per correlated unit. 

## Idea 2: Study DMR with genomic or evolutionary features

After the DMRs were called, we could do a series of correlation studies to test whether DMR enriched in certain genomic features or have some relationship with selection or fitness.

- DMR vs. genic features (5', 3', exon, intron or 5kb flanking genes)
- DMR vs. selection sweeps
- DMR vs. GERP score or GERP elements?
- DMR vs. fitness?

## 2.1 use ANGSD to call genotype probility and recall the BS data

- Tajima's D on genes to identify genes under selection using SMP
- Compare with SNP estimated Tajima's D
- Pathway? phylogenetic age of those genes?

## Idea 3: Map the genetic control for DMR?

This part will only be possible when we get the progeny info of DMR.
- The idea would be using DMR as phenotypic traits, and try to map the genetic control to explain DMR.
- Further, we can also use DMR as explanatory variables to check whether they could explain phenotypic variation in a population
