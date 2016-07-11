### Jinliang Yang
### using smooth/segmentation approach for DMR
### http://bioconductor.org/packages/devel/bioc/html/bsseq.html
### manual: http://bioconductor.org/packages/devel/bioc/vignettes/bsseq/inst/doc/bsseq.pdf

download.file(url = "ftp://ftpuser3:s3qu3nc3@neomorph.salk.edu/mc/mc_imr90_r1.tar.gz",
              destfile = "largedata/mc_imr90_r1.tar.gz")
untar("largedata/mc_imr90_r1.tar.gz",  "mc_imr90_r1/mc_imr90_r1_22", compressed = TRUE)
system("mv mc_imr90_r1/mc_imr90_r1_22 largedata/")
download.file(url = "ftp://ftpuser3:s3qu3nc3@neomorph.salk.edu/mc/mc_imr90_r2.tar.gz",
              destfile = "largedata/mc_imr90_r2.tar.gz")
untar("largedata/mc_imr90_r2.tar.gz",  "mc_imr90_r2/mc_imr90_r2_22", compressed = TRUE)
system("mv mc_imr90_r2/mc_imr90_r2_22 largedata/")

############################
## Now the workhorse function

file <- "largedata/mc_imr90_r1_22"
read.lister <- function(file) {
    dat <- read.table(file, skip = 1, row.names = NULL,
                      col.names = c("chr", "pos", "strand", "context", "M", "Cov"),
                      colClasses = c("character", "integer", "character",
                                     "character", "integer", "integer"))
    ## we remove all non-CpG calls.  This includes SNPs
    dat <- dat[dat$context == "CG",]
    dat$context <- NULL ### cool!
    dat$chr <- paste("chr", dat$chr, sep = "")
    ## Now we need to handle that the data has separate lines for each strand
    ## We join these
    #we aggregated reads on the
    #forward and reverse strand to form a single value, and we assume the genomic position points to the C
    #of the CpG. It is not crucial in any way to do this, one may easily analyze each strand separately, but
    #CpG methylation is symmetric and this halves the number of loci.
    tmp <- dat[dat$strand == "+",]
    BS.forward <- BSseq(pos = tmp$pos, chr = tmp$chr, M = as.matrix(tmp$M, ncol = 1),
                        Cov = as.matrix(tmp$Cov, ncol = 1), sampleNames = "forward")
    tmp <- dat[dat$strand == "-",]
    BS.reverse <- BSseq(pos = tmp$pos - 1L, chr = tmp$chr, M = as.matrix(tmp$M, ncol = 1),
                        Cov = as.matrix(tmp$Cov, ncol = 1), sampleNames = "reverse")
    BS <- combine(BS.forward, BS.reverse)
    BS <- collapseBSseq(BS, columns = c("a", "a"))
    BS
}
######


###########
meth1 <- fread("largedata/bismark/SRR850332_pe.CX_report.txt")
cg <- meth1[V6 == "CG"]


