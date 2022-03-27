#!/usr/bin/env bash


## required:
## STAR software
## geneMark software


reads1=$1 ## 
reads2=$2
fasta=$3  ##masked genome
out=

## index
mkdir -p star_index
STAR \
    --runThreadN 20 \
    --runMode genomeGenerate \
    --genomeDir star_index \
    --genomeFastaFiles ${fasta}


## align
STAR \
    --runThreadN 20 \
    --runMode alignReads \
    --genomeDir star_index \
    --outFileNamePrefix $out \
    --readFilesIn ${reads1} ${reads2} \
    --readFilesCommand zcat \
    --outSAMtype None \
    --outWigType None


## convert SJ.out.tab to introns.gff
~/soft/gmes_linux_64/star_to_gff.pl --star  ${out}SJ.out.tab --gff ${out}.introns.gff --label introns

## predict genes
~/soft/gmes_linux_64/gmes_petap.pl --sequence ${fasta} --ET ${out}.introns.gff --cores 10
