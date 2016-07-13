### Jinliang Yang
### April 13th, 2016

# alpha_estimation.pl -dir region_CG -output region_CG_alpha.txt -length_list CG_lenlist.txt
# locus_name alpha_value mean_NB variance_NB

library(farmeR)
sh1 <- "cd /home/jolyang/Documents/Github/methylation/largedata/Dm/region_CG"
sh2 <- "alpha_estimation.pl -dir cg_input -output region_CG_alpha.txt -length_list region_CG_length.txt"
set_farm_job(slurmsh = "slurm-script/run_alpha.sh",
             shcode = c(sh1, sh2), wd = NULL, jobid = "alpha1",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemh", "1"))

sh1 <- "cd /home/jolyang/Documents/Github/methylation/largedata/Dm/region_CHG"
sh2 <- "alpha_estimation.pl -dir chg_input -output region_CHG_alpha.txt -length_list region_CHG_length.txt"
set_farm_job(slurmsh = "slurm-script/run_alpha_chg.sh",
             shcode = c(sh1, sh2), wd = NULL, jobid = "alpha2",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemh", "1"))

sh1 <- "cd /home/jolyang/Documents/Github/methylation/largedata/Dm/region_CHH"
sh2 <- "alpha_estimation.pl -dir chh_input -output region_CHH_alpha.txt -length_list region_CHH_length.txt"
set_farm_job(slurmsh = "slurm-script/run_alpha_chh.sh",
             shcode = c(sh1, sh2), wd = NULL, jobid = "alpha3",
             email = "yangjl0930@gmail.com", runinfo = c(TRUE, "bigmemh", "1"))


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
inputdf <- get_inputdf(len_file="largedata/Dm/region_CG/region_CG_length.txt", 
                       alpha_file="largedata/Dm/region_CG/region_CG_alpha.txt")
run_dm_test(
    inputdf, outdir="largedata/Dm/region_CG/cg_input", cmdno=100,
    arrayshid = "slurm-script/run_dm1_array.sh",
    email="yangjl0930@gmail.com", runinfo = c(TRUE, "med", 1)
)

######## CHG
inputdf <- get_inputdf(len_file="largedata/Dm/region_CHG/region_CHG_length.txt", 
                       alpha_file="largedata/Dm/region_CHG/region_CHG_alpha.txt")
run_dm_test(
    inputdf, outdir="largedata/Dm/region_CHG/chg_input", cmdno=100,
    arrayshid = "slurm-script/run_dm2_array.sh",
    email="yangjl0930@gmail.com", runinfo = c(TRUE, "med", 1)
)

#### CHH
inputdf <- get_inputdf(len_file="largedata/Dm/region_CHH/region_CHH_length.txt", 
                       alpha_file="largedata/Dm/region_CHH/region_CHH_alpha.txt")
run_dm_test(
    inputdf, outdir="largedata/Dm/region_CHH/chh_input", cmdno=100,
    arrayshid = "slurm-script/run_dm3_array.sh",
    email="yangjl0930@gmail.com", runinfo = c(TRUE, "med", 1)
)
