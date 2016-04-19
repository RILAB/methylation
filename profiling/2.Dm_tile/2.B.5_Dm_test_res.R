### Jinliang Yang
### April 13th, 2016



#############
files <- list.files(path="largedata/Dm/gene_CG", pattern="out$", full.names=TRUE)
df <- data.frame()
for(i in 1:length(files)){
    onel<- try(read.table(files[i], header=FALSE), silent = TRUE)
    if (!inherits(onel, 'try-error')){
        #chr    start   end     Dm      segregation_site        theta_pi        theta_s
        names(onel) <- c("chr","start","end","Dm","segregation_site","theta_pi","theta_s")
        onel$geneid <- files[i]
        df <- rbind(df, onel)
    }
}
write.table(df, "largedata/Dm/CG_Dm_res.csv", sep=",", row.names=FALSE, quote=FALSE)

##
df <- read.csv("largedata/Dm/CG_Dm_res.csv")
hist(df$Dm, breaks=100, col="darkblue")

