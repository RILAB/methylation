$HOME/bin/fermikit/fermi.kit/fermi2.pl unitig -s2.3g -t16 -l100 -p $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2P \
"$HOME/bin/fermikit/fermi.kit/seqtk mergepe /group/jrigrp/teosinte-parents/seq-merged/Sample_JRIAL2P_index16_1.fastq.gz /group/jrigrp/teosinte-parents/seq-merged/Sample_JRIAL2P_index16_2.fastq.gz |  \
$HOME/bin/fermikit/fermi.kit/trimadap-mt -p15" > $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2P.mak
make -f $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2P.mak
$HOME/bin/fermikit/fermi.kit/run-calling -t15 $HOME/dbcenter/AGP/AGPv2/Zea_mays.AGPv2.14.dna.toplevel.fa $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2P.mag.gz | sh
rm $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2P*fq.gz
rm $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2P.flt.fmd
rm $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2P.pre.gz
rm $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2P.unsrt.sam.gz
