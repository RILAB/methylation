
### indexing
kallisto index -k 31 -i Osativa_204_v7_1transcript Osativa_204_v7.0.transcript_primaryTranscriptOnly
### quantification
kallisto quant -i index -o output pairA_1.fastq pairA_2.fastq pairB_1.fastq pairB_2.fastq