## activate
source ~/miniconda2/etc/profile.d/conda.sh
conda activate allhic

scaf=./input/Sp_YY_v1/tig.HiCcorrected.fasta
reads1=./input/fastq/bocai_R1.fastq.gz
reads2=./input/fastq/bocai_R2.fastq.gz

## index
samtools faidx $scaf
bwa index -a bwtsw  $scaf


## alignment
bwa aln -t 20  $scaf  $reads1 >bocai_R1.sai
bwa aln -t 20  $scaf  $reads2 >bocai_R2.sai
bwa sampe  $scaf bocai_R1.sai bocai_R2.sai  $reads1  $reads2 >sample.bwa_aln.sam


## filter
PreprocessSAMs.pl sample.bwa_aln.sam $scaf HindIII
filterBAM_forHiC.pl sample.bwa_aln.REduced.paired_only.bam sample.clean.sam
samtools view -bt ${scaf}.fai sample.clean.sam > sample.clean.bam
rm sample.clean.sam bocai_R1.sai bocai_R2.sai

ALLHiC_partition -b sample.clean.bam -r $scaf -e AAGCTT -k 6 

## extract
allhic extract sample.clean.bam $scaf --RE AAGCTT 


## optimized
for i in sample.clean.counts_AAGCTT.6g*.txt;do allhic optimize ${i} sample.clean.clm;done

## chromosome level
ALLHiC_build  $scaf
