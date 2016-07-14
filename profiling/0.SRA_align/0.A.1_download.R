### Jinliang Yang
### Feb 25th, 2016

# ascp root: vog.hin.mln.ibcn.ptf@ptfnona:
#Remainder of path:
#    /sra/sra-instant/reads/ByRun/sra/{SRR|ERR|DRR}/<first 6 characters of accession>/<accession>/<accession>.sra
#Where
#{SRR|ERR|DRR} should be either ‘SRR’, ‘ERR’, or ‘DRR’ and should match the prefix of the target .sra file
#ascp -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l 100m
# anonftpftp@ftp.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR161/SRR1610960/SRR1610960.sra

run_ascp <- function(sraid = "SRR1610960", maxspeed="200m", outdir="."){
    
    id1 <- substr(sraid, start=1, stop=3)
    id2 <- substr(sraid, start=1, stop=6)
    #http://www.ncbi.nlm.nih.gov/books/NBK158899/#SRA_download.downloading_sra_data_using
    cmd <- paste0("ascp -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l ", maxspeed,
                  " anonftp@ftp.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/",
                  id1, "/", id2, "/", sraid,"/", sraid, ".sra ", outdir)
    return(cmd)
}


wgbs <- data.frame(SRR=c("SRR850328", "SRR850332",  "SRR1610959", "SRR1610960", "SRR1610961"), 
           SRX=c( "SRR850328", "SRR850332","SRX731432","SRX731433","SRX731434"),  
           pid=c( "B73", "Mo17",  "CML322", "Oh43", "Tx303"))

rnaseq <- data.frame(SRX=c("SRX842443", "SRX842431", "SRX842410", "SRX842406", "SRX842394", "SRX842382",
                           "SRX842370", "SRX842358", "SRX842346", "SRX842334", "SRX842322", "SRX842309",
                           "SRX842297", "SRX842284", "SRX842249"),
                     SRR=c("SRR1758152", "SRR1758140", "SRR1758128", "SRR1758104", "SRR1758091", "SRR1758079",
                           "SRR1758067", "SRR1758055", "SRR1758044", "SRR1758029", "SRR1758021", "SRR1758014",
                           "SRR1757990", "SRR1757978", "SRR1757965"),
                     
                     pid=c("Tx303", "Tx303", "Tx303", "Oh43", "Oh43", "Oh43",
                           "CML322", "CML322", "CML322", "Mo17", "Mo17", "Mo17",
                           "B73", "B73", "B73"),
                     rep=c("rep3", "rep2", "rep1", "rep3", "rep2", "rep1",
                           "rep3", "rep2", "rep1", "rep3", "rep2", "rep1",
                           "rep3", "rep2", "rep1"))

##########################
source("~/Documents/Github/zmSNPtools/Rcodes/setUpslurm.R")
mysh <- c()
for(i in 1:nrow(wgbs)){
    out <- run_ascp(sraid = wgbs$SRR[i], maxspeed="200m", outdir="/group/jrigrp4/BS_teo20/WGBS")
    mysh <- c(mysh, out)
}
setUpslurm(slurmsh="slurm-script/download_WGBS.sh",
           codesh=mysh,
           wd=NULL, jobid="dgbs", email=NULL)

##########################
mysh2 <- c()
for(i in 1:nrow(rnaseq)){
    out2 <- run_ascp(sraid = rnaseq$SRR[i], maxspeed="200m", outdir="/group/jrigrp4/BS_teo20/RNA-seq")
    mysh2 <- c(mysh2, out2)
}
setUpslurm(slurmsh="slurm-script/download_RNAseq.sh",
           codesh=mysh2,
           wd=NULL, jobid="drna-seq", email="yangjl0930@gmail.com")


