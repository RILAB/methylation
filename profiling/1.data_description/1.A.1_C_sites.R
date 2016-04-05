### Jinliang Yang
### 4/3/2016
### understand how many CG, CHG and CHH sites in AGPv2 genome

#Find all CpG sites
library(Biostrings)
library(GenomicRanges)
fa <- readDNAStringSet("~/dbcenter/AGP/AGPv2/Zea_mays.AGPv2.14.dna.toplevel.fa")
### Note also need to count reverse complement sites
rcfa <-  reverseComplement(fa)

#### CG
c11 <- vcountPattern("CG", fa)
c12 <- vcountPattern("CG", rcfa)

c1 <- sum(c11) + sum(c12) #180125000

#### CHG: H=ACT
chg <- DNAStringSet(c("CAG", "CTG", "CCG"))

c21 <- vcountPDict(chg, fa)
c22 <- vcountPDict(chg, rcfa)

c2 <- sum(apply(c21, 1, sum)) + sum(apply(c22, 1, sum))
#[1] 158277169

#### H=ACT
chh <- DNAStringSet(c("CAA", "CAC", "CAT",
                          "CCA", "CCC", "CCT",
                          "CTA", "CTC", "CTT"))

c31 <- vcountPDict(chh, fa)
c32 <- vcountPDict(chh, rcfa)

c3 <- sum(apply(c31, 1, sum)) + sum(apply(c32, 1, sum))

c1 + c2 + c3
#[1] 962803185

#############################
library(farmeR)
set_jupyter(port=9998)


