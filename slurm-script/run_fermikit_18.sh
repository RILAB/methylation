$HOME/bin/fermikit/fermi.kit/fermi2.pl unitig -s2.3g -t16 -l100 -p $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2R \
"$HOME/bin/fermikit/fermi.kit/seqtk mergepe /group/jrigrp/teosinte-parents/seq-merged/Sample_JRIAL2R_index18_1.fastq.gz /group/jrigrp/teosinte-parents/seq-merged/Sample_JRIAL2R_index18_2.fastq.gz |  \
$HOME/bin/fermikit/fermi.kit/trimadap-mt -p15" > $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2R.mak
make -f $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2R.mak
$HOME/bin/fermikit/fermi.kit/run-calling -t15 $HOME/dbcenter/AGP/AGPv2/Zea_mays.AGPv2.14.dna.toplevel.fa $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2R.mag.gz | sh
rm $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2R*fq.gz
rm $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2R.flt.fmd
rm $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2R.pre.gz
rm $HOME/Documents/Github/methylation/largedata/fermi/JRIAL2R.unsrt.sam.gz
