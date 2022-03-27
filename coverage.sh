
genome0=$1


cut -f 1,2 $genome0.fai > $genome0.fai.g
bedtools makewindows -g $genome0.fai.g -w 50000 > $genome0.fai.g.50k

samtools depth -m 100 -Q 60  $genome.$size.dedup.bam  | awk '{print $1"\t"$2-1"\t"$2"\t"$3}'  | bedtools map -a $genome0.fai.g.50k  -b - -c 4 -o median,mean,count  > $genome.$size.dedup.bam.cov-50k
