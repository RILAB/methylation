### Jinliang Yang
### April 13th, 2016

df1 <- read.table("largedata/Dm/CG_lenlist.txt")
alpha <- read.table("largedata/Dm/CG_res.txt")
names(alpha) <- c("locus_name", "alpha_value", "mean_NB", "variance_NB")

inputdf <- merge(alpha, df1, by.x="locus_name", by.y="V1")

names(inputdf)[5] <- "len"
inputdf$out <- paste0(inputdf$locus_name, ".out")

# Dm_methylation.pl -input gene_CG/AC148152.3_FG001_cg -output out_dm.txt -length 123 -alpha 0.327154136568751
run_dm_test(
    inputdf, outdir="largedata/Dm/gene_CG", cmdno=100,
    arrayshid = "slurm-script/run_dm_array.sh",
    email="yangjl0930@gmail.com", runinfo = c(TRUE, "med", 1)
)


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

