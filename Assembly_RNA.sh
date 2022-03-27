#!/usr/bin/env bash


## NOTE:
## STAR software
## Stringtie


masked_ref=
sample=
outname=

############################################# 1 alignment RNA-seq to masked-genome ################################

## index
mkdir -p star_index
STAR \
    --runThreadN 20 \
    --runMode genomeGenerate \
    --genomeDir star_index \
    --genomeFastaFiles ${masked_ref}


## align
for i in $(cat $sample)
do
STAR \
    --runThreadN 20 \
    --runMode alignReads \
    --outFileNamePrefix ${i} \
    --genomeDir star_index \
    --readFilesIn ${i}.fq.1.clean.gz  ${i}.fq.2.clean.gz\
    --readFilesCommand zcat \
    --outSAMtype BAM SortedByCoordinate \
    --outWigType None
done


####################################### 2 assembly transcript sequences using stringTie #############################
for i in $(ls *.bam);do samtools  index $i;done
samtools  merge -@ 10  ${outname}_transcript.sorted.bam  $(for i in $(ls *bam);do echo $i;done)
stringtie -p 10 -o ${outname}.gtf  ${outname}_transcript.sorted.bam
gtf_genome_to_cdna_fasta.pl ${outname}.gtf ${masked_ref} > ${outname}.transcript.fa

