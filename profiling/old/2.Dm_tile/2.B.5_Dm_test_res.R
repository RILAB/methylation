### Jinliang Yang
### April 20th, 2016



#############
get_Dm <- function(pwd="largedata/Dm/gene_CG"){
    files <- list.files(path=pwd, pattern="out$", full.names=TRUE)
    message(sprintf("###>>> Detected [ %s ] files!", length(files)))
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
    return(df)
}

#### Regions
res1 <- get_Dm(pwd="largedata/Dm/region_CG/cg_input")
write.table(res1, "cache/res_region_cg.csv", sep=",", row.names=FALSE, quote=FALSE)

res2 <- get_Dm(pwd="largedata/Dm/region_CHG/chg_input")
write.table(res2, "cache/res_region_chg.csv", sep=",", row.names=FALSE, quote=FALSE)

res3 <- get_Dm(pwd="largedata/Dm/region_CHH/chh_input")
write.table(res3, "cache/res_region_chh.csv", sep=",", row.names=FALSE, quote=FALSE)

####
df <- read.csv("largedata/Dm/CG_Dm_res.csv")
hist(df$Dm, breaks=100, col="darkblue")

