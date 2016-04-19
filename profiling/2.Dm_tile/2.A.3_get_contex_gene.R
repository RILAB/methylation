### Jinliang Yang
### April 13th, 2016

library("data.table")
gt <- fread("largedata/Dm/FGSv2_gene_GT_t.txt")


C_format <- function(minsite=10){
    files <- list.files(path="largedata/Dm/input_gene", full.names=TRUE)
    
    df1 <- df2 <- df3 <- data.frame()
    for(i in 1:length(files)){
        onegene <- try(read.table(files[i], header=FALSE), silent = TRUE)
        if (!inherits(onegene, 'try-error')){
            onegene$miss <- apply(onegene, 1, function(x) sum(x=="."))
            onegene <- subset(onegene, miss==0)
            
            #chg <- subset(onegene, V3 == "CHG")
            #chh <- subset(onegene, V3 == "CHH")
            
            cg <- subset(onegene, V3 == "CG")
            if(nrow(cg) > minsite){
                outcg <- paste0(gsub("input_gene", "gene_CG", files[i]), "_cg")
                write.table(cg[, c(1:2, 4:43)], outcg, sep="\t", row.names=FALSE, col.names=FALSE, quote=FALSE)
                tem1 <- data.frame(file=outcg, sites=nrow(cg))
                df1 <- rbind(df1, tem1)
            }
            print(i)
        }
    }
    
}


df1$file <- gsub(".*/", "", df1$file)
write.table(df1, "largedata/Dm/CG_lenlist.txt", sep="\t", row.names=FALSE, quote=FALSE, col.names=FALSE)

# alpha_estimation.pl -dir gene_CG -output CG_res.txt -length_list CG_lenlist.txt
# locus_name alpha_value mean_NB variance_NB









