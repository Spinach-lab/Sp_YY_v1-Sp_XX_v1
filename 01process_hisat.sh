#!/usr/bin/bash


ref=
sample=samples

mkdir output && cd output
mkdir align
cd ..

## index for ref
hisat2-build -p 5 $ref $ref

## mapping
for i in $(cat $sample)
do
  hisat2 -x $ref -p 20 -1 ${i}_1.fq.gz -2 ${i}_2.fq.gz  -S ./output/align/${i}.sam
  samtools view -@ 20 -bS ./output/align/${i}.sam -o ./output/align/${i}.bam
  samtools sort -@ 20 -o  ./output/align/${i}.sorted.bam  ./output/align/${i}.bam
  rm ./output/align/${i}.sam ./output/align/${i}.bam
  echo " $i done " >>log
done

realpath ./output/align/*bam >> ./output/align/bam_list.txt 
