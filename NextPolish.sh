
#Set input and parameters
NP_path=/ifs1/User/shehongbing/soft/NextPolish
round=1
threads=10
read1=CRR339305_f1.clean.fq.gz
read2=CRR339305_r2.clean.fq.gz
input=

for ((i=1; i<=${round};i++)); do
echo -e "start round $i" >>polish.log
starttime=$(date +%s)
#step 1:
   #index the genome file and do alignment
   ${NP_path}/bin/bwa index ${input};
   ${NP_path}/bin/bwa mem -t ${threads} ${input} ${read1} ${read2}| ${NP_path}/bin/samtools view --threads 3 -F 0x4 -b -| ${NP_path}/bin/samtools fixmate -m --threads 3  - -| ${NP_path}/bin/samtools sort -m 2g --threads 5 -| ${NP_path}/bin/samtools markdup --threads 5 -r - sgs.sort.bam
      #index bam and genome files
   ${NP_path}/bin/samtools index -@ ${threads} sgs.sort.bam;
   ${NP_path}/bin/samtools faidx ${input};
   #polish genome file
   python ${NP_path}/lib/nextpolish1.py -g ${input} -t 1 -p ${threads} -s sgs.sort.bam > genome.polishtemp.fa;
   input=genome.polishtemp.fa;
#step2:
         #index genome file and do alignment
   ${NP_path}/bin/bwa index ${input};
   ${NP_path}/bin/bwa mem -t ${threads} ${input} ${read1} ${read2}| ${NP_path}/bin/samtools view --threads 3 -F 0x4 -b -| ${NP_path}/bin/samtools fixmate -m --threads 3  - -| ${NP_path}/bin/samtools sort -m 2g --threads 5 -| ${NP_path}/bin/samtools markdup --threads 5 -r - sgs.sort.bam
      #index bam and genome files
   ${NP_path}/bin/samtools index -@ ${threads} sgs.sort.bam;
   ${NP_path}/bin/samtools   faidx ${input};
   #polish genome file
   python ${NP_path}/lib/nextpolish1.py -g ${input} -t 2 -p ${threads} -s sgs.sort.bam > genome.nextpolish.fa;
   input=genome.nextpolish.fa;
   endtime=$(date +%s)
   cost=$((endtime - starttime))
   echo -e "finish round $i, run time: ${cost} s" >>polish.log
done;
#Finally polished genome file: genome.nextpolish.fa
