### Jinliang Yang
### April 11th, 2016

library("data.table", lib="~/bin/Rlib")

gerp <- fread("~/Documents/Github/pvpDiallel/largedata/GERPv2/gerp130m.csv", sep=",")
gerp[, range(RS)] #-4.56  2.28
gerp <- gerp[RS > 0,]

#DT[i, j, by]
##   R:      i                 j        by
## SQL:  where   select | update  group by
gerp[, snpid := paste(chr, pos, sep="_")]




