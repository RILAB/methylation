### Jinliang Yang
### April 13th, 2016

library("data.table")
gt <- fread("largedata/Dm/FGSv2_gene_GT_t.txt")


tem$V3 <- apply(tem, 1, function(x) sum(x=="."))


gene <- read.table("largedata/Dm/FGSv2_gene.bed3", header=F)
gene10 <- subset(gene, V1==10)

res <- lapply(1:10, function(x){
    tem <- gt[V1==gene$V1[x] & V2 >= gene$V2[x] & V2 <= gene$V3[x]]
    tem$V3 <- apply(tem, 1, function(x) sum(x=="."))
    test <- subset(tem, V3==0)
    outfile <- paste0("largedata/Dm/", gene$V2[x], "-", gen$V3[x], ".txt")
    write.table(test[, -3], "largedata/Dm/test_input.txt", sep="\t", 
                row.names=FALSE, col.names=FALSE, quote=FALSE)
    print(x)
})





