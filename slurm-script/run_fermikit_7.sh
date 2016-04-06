$HOME/bin/fermikit/fermi.kit/fermi2.pl unitig -s2.3g -t16 -l100 -p $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2G \
"$HOME/bin/fermikit/fermi.kit/seqtk mergepe /group/jrigrp/teosinte-parents/seq-merged/Sample_JRIAL2G_index7_1.fastq.gz /group/jrigrp/teosinte-parents/seq-merged/Sample_JRIAL2G_index7_2.fastq.gz |  \
$HOME/bin/fermikit/fermi.kit/trimadap-mt -p15" > $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2G.mak
make -f $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2G.mak
$HOME/bin/fermikit/fermi.kit/run-calling -t15 $HOME/dbcenter/AGP/AGPv2/Zea_mays.AGPv2.14.dna.toplevel.fa $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2G.mag.gz | sh
rm $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2G*fq.gz
rm $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2G.flt.fmd
rm $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2G.pre.gz
rm $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2G.unsrt.sam.gz
