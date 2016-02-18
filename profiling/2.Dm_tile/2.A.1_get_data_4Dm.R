### Jinliang Yang
### Feb 17th, 2016


library("data.table", lib="~/bin/Rlib")

cg1 <- fread("/group/jrigrp4/BS_teo20/SP028-029_JR_100bp_CG.tab", header=TRUE)
cg2 <- fread("/group/jrigrp4/BS_teo20/SP029_2-3_JR_100bp_CG.tab", header=TRUE)

cg1 <- as.data.frame(cg1)
cg2 <- as.data.frame(cg2)






