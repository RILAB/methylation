#!/bin/bash
#SBATCH -D /home/jolyang/Documents/Github/methylation
#SBATCH -o /home/jolyang/Documents/Github/methylation/slurm-log/testout-%j.txt
#SBATCH -e /home/jolyang/Documents/Github/methylation/slurm-log/err-%j.txt
#SBATCH -J drna-seq
#SBATCH --mail-user=yangjl0930@gmail.com
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL #email if fails
set -e
set -u

ascp -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l 200m anonftp@ftp.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR175/SRR1758152/SRR1758152.sra /group/jrigrp4/BS_teo20/RNA-seq
ascp -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l 200m anonftp@ftp.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR175/SRR1758140/SRR1758140.sra /group/jrigrp4/BS_teo20/RNA-seq
ascp -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l 200m anonftp@ftp.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR175/SRR1758128/SRR1758128.sra /group/jrigrp4/BS_teo20/RNA-seq
ascp -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l 200m anonftp@ftp.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR175/SRR1758104/SRR1758104.sra /group/jrigrp4/BS_teo20/RNA-seq
ascp -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l 200m anonftp@ftp.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR175/SRR1758091/SRR1758091.sra /group/jrigrp4/BS_teo20/RNA-seq
ascp -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l 200m anonftp@ftp.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR175/SRR1758079/SRR1758079.sra /group/jrigrp4/BS_teo20/RNA-seq
ascp -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l 200m anonftp@ftp.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR175/SRR1758067/SRR1758067.sra /group/jrigrp4/BS_teo20/RNA-seq
ascp -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l 200m anonftp@ftp.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR175/SRR1758055/SRR1758055.sra /group/jrigrp4/BS_teo20/RNA-seq
ascp -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l 200m anonftp@ftp.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR175/SRR1758044/SRR1758044.sra /group/jrigrp4/BS_teo20/RNA-seq
ascp -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l 200m anonftp@ftp.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR175/SRR1758029/SRR1758029.sra /group/jrigrp4/BS_teo20/RNA-seq
ascp -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l 200m anonftp@ftp.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR175/SRR1758021/SRR1758021.sra /group/jrigrp4/BS_teo20/RNA-seq
ascp -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l 200m anonftp@ftp.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR175/SRR1758014/SRR1758014.sra /group/jrigrp4/BS_teo20/RNA-seq
ascp -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l 200m anonftp@ftp.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR175/SRR1757990/SRR1757990.sra /group/jrigrp4/BS_teo20/RNA-seq
ascp -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l 200m anonftp@ftp.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR175/SRR1757978/SRR1757978.sra /group/jrigrp4/BS_teo20/RNA-seq
ascp -i ~/.aspera/connect/etc/asperaweb_id_dsa.openssh -QT -l 200m anonftp@ftp.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/SRR/SRR175/SRR1757965/SRR1757965.sra /group/jrigrp4/BS_teo20/RNA-seq
