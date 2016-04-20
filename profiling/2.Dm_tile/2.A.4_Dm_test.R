### Jinliang Yang
### April 13th, 2016

# alpha_estimation.pl -dir region_CG -output region_CG_alpha.txt -length_list CG_lenlist.txt
# locus_name alpha_value mean_NB variance_NB

library(farmeR)
sh1 <- "cd /home/jolyang/Documents/Github/methylation/largedata/Dm/gene_CG"
sh2 <- "alpha_estimation.pl -dir cg_input -output gene_CG_alpha.txt -length_list gene_CG_length.txt"
set_farm_job(slurmsh = "slurm-script/run_alpha4.sh",
             shcode = c(sh1, sh2), wd = NULL, jobid = "alpha4",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemh", "1"))

sh1 <- "cd /home/jolyang/Documents/Github/methylation/largedata/Dm/gene_CHG"
sh2 <- "alpha_estimation.pl -dir chg_input -output gene_CHG_alpha.txt -length_list gene_CHG_length.txt"
set_farm_job(slurmsh = "slurm-script/run_alpha5.sh",
             shcode = c(sh1, sh2), wd = NULL, jobid = "alpha5",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemh", "1"))

sh1 <- "cd /home/jolyang/Documents/Github/methylation/largedata/Dm/gene_CHH"
sh2 <- "alpha_estimation.pl -dir chh_input -output gene_CHH_alpha.txt -length_list gene_CHH_length.txt"
set_farm_job(slurmsh = "slurm-script/run_alpha6.sh",
             shcode = c(sh1, sh2), wd = NULL, jobid = "alpha6",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemh", "1"))

###############################
# Dm_methylation.pl -input gene_CG/AC148152.3_FG001_cg -output out_dm.txt -length 123 -alpha 0.327154136568751
get_inputdf <- function(len_file="largedata/Dm/region_CG/region_CG_length.txt", 
                        alpha_file="largedata/Dm/CG_res.txt"){
    df1 <- read.table(len_file)
    alpha <- read.table(alpha_file)
    names(alpha) <- c("locus_name", "alpha_value", "mean_NB", "variance_NB")
    inputdf <- merge(alpha, df1, by.x="locus_name", by.y="V1")
    
    names(inputdf)[5] <- "len"
    inputdf$out <- paste0(inputdf$locus_name, ".out")
    return(inputdf)
}
source("lib/run_dm_test.R")
########
inputdf <- get_inputdf(len_file="largedata/Dm/gene_CG/gene_CG_length.txt", 
                       alpha_file="largedata/Dm/gene_CG/gene_CG_alpha.txt")
run_dm_test(
    inputdf, outdir="largedata/Dm/gene_CG/cg_input", cmdno=100,
    arrayshid = "slurm-script/run_dm1_array.sh",
    email="yangjl0930@gmail.com", runinfo = c(TRUE, "med", 1)
)

######## CHG
inputdf <- get_inputdf(len_file="largedata/Dm/gene_CHG/gene_CHG_length.txt", 
                       alpha_file="largedata/Dm/gene_CHG/gene_CHG_alpha.txt")
run_dm_test(
    inputdf, outdir="largedata/Dm/gene_CHG/chg_input", cmdno=100,
    arrayshid = "slurm-script/run_dm2_array.sh",
    email="yangjl0930@gmail.com", runinfo = c(TRUE, "med", 1)
)

#### CHH
inputdf <- get_inputdf(len_file="largedata/Dm/gene_CHH/gene_CHH_length.txt", 
                       alpha_file="largedata/Dm/gene_CHH/gene_CHH_alpha.txt")
run_dm_test(
    inputdf, outdir="largedata/Dm/gene_CHH/chh_input", cmdno=100,
    arrayshid = "slurm-script/run_dm3_array.sh",
    email="yangjl0930@gmail.com", runinfo = c(TRUE, "med", 1)
)












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

