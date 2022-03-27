#!/bin/bash

## masked genome
fasta=$1

BuildDatabase -name ${fasta}db -engine ncbi ${fasta}


RepeatModeler -database ${fasta}db -pa 5

mkdir Repeat_result
RepeatMasker -nolow -norna -e ncbi -pa 5 -lib ./RM*/consensi.fa.classified -dir Repeat_result/ -gff ${fasta}

