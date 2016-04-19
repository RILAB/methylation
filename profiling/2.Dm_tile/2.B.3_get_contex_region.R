### Jinliang Yang
### April 13th, 2016


library("farmeR")

files <- list.files(path="largedata/Dm/region_input", full.names=TRUE)
inputdf <- data.frame(file=files, out="n")
run_Rcodes(
    inputdf, outdir="largedata/Dm/shfolder", cmdno=100,
    rcodes = "$HOME/Documents/Github/methylation/profiling/2.Dm_tile/2.B.2_code_cformat_region.R",
    arrayshid = "slurm-script/run_cformat_region.sh",
    email=NULL, runinfo = c(FALSE, "bigmemh", 1)
)

set_arrayjob(shid="largedata/scripts/run_pp.sh",
             shcode='R --no-save "--args ${SLURM_ARRAY_TASK_ID}" < profiling/5.cj_new_AGPv2/5.C.2_run_phase_parent.R',
             arrayjobs="1-210",
             wd=NULL, jobid="pp210", email="yangjl0930@gmail.com")



df1$file <- gsub(".*/", "", df1$file)
write.table(df1, "largedata/Dm/CG_lenlist.txt", sep="\t", row.names=FALSE, quote=FALSE, col.names=FALSE)

# alpha_estimation.pl -dir gene_CG -output CG_res.txt -length_list CG_lenlist.txt
# locus_name alpha_value mean_NB variance_NB









