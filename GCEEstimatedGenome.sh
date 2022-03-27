
reads1=
reads2=
kmer=21
reads_len=150
out=

realpath $reads1 >reads.list
realpath $reads2 >>reads.list

kmer_freq_hash -k $kmer -l reads.list -L $reads_len -a 10 -d 10 -i 450000000 -t 5 -o 0 -p $out 2>kmerfreq.log 

### get -g from the $out
gce -g 52257937107  -m 1 -D 8 -b 1 -f ${out}.freq.stat >${out}.gce.table 2>${out}.gce.log
