#!/usr/bin/bash

bam=./output/align/bam_list.txt
gff=


cd output
mkdir ExpreSet
cd ..

## 1.  featureCounts

for i in $(cat $bam)
do
 out=$(basename ${i} _.sorted.bam)
 featureCounts -T 10 -p -t exon  -g ID -a $gff -o ./output/ExpreSet/${out}.featureCounts.txt $i
done

