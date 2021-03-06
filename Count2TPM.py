#!/usr/bin/env python
# _*_ coding: utf-8 _*_

## This script is  used to convert reads count to TPM
## length file   eg.   gene1    23323
          #            gene2   2343


## reads count  eg. *** The fisrt charcter of first row must be 'name'!
# name sample1  sample2 ..
# gene1  343    4343
# gene2 3434    343

from __future__ import  division
from optparse import OptionParser


usage = "\n\npython %prog (-l lengh) -f count_matrix [-w]"
parser = OptionParser(usage=usage)
parser.add_option("-l", "--length", dest="len", help="Input gene extron length file (flag '-w' is recommended to switch on)\n eg: gene1  10000")
parser.add_option("-w", "--provide length file or not", dest="add", default=False, action="store_true", help="provide length or not??\n")
parser.add_option("-f", "--file", dest="file", help="Input reads count matrix file")

(opt,args) = parser.parse_args()


info_len = {}    
flag = 1         
total_len = {}  

if opt.add == True:
    with open(opt.len) as f:
        for i in f:
            i=i.strip().split()
            info_len[i[0]] = int(i[1])/1000
else:
    flag = 0

# read the raw reads count/   divided gene length
with open(opt.file) as f1,\
    open("%s_div_len" %opt.file, "w") as o:
    name = f1.readline().strip().split()
    o.write("%s\n" %"\t".join(name))
    for line in f1:
        if 'name' not in line:
            line = line.strip().split()
            out_tem = []
            count = 0
            for sample in line[1:]:
                count +=1
                if flag ==1:
                    if line[0] not in info_len:
                        print 'Please provided %s length!!! '%line[0]
                        break
                    else:
                        divi_num = int(sample)/info_len[line[0]]
                else:
                    divi_num = int(sample)
                out_tem.append(str(divi_num))
                if name[count] not in total_len:
                    total_len[name[count]] = 0
                total_len[name[count]] = total_len[name[count]]+divi_num
            o.write("%s\t%s\n" %(line[0],"\t".join(out_tem)))

# read the read count divided length
IN = opt.file+"_div_len"
with open(IN) as f2,\
    open("%s_norm" %opt.file, "w") as o1:
    o1.write("%s\n" %"\t".join(name))
    for j in f2:
        if "name" not in j:
            j=j.strip().split()
            out1_tem = []
            count1 = 0
            for sample1 in j[1:]:
                count1 +=1
                norm_count = float(sample1)/total_len[name[count1]]
                out1_tem.append(str(norm_count*1000000))
            o1.write("%s\t%s\n" %(j[0],"\t".join(out1_tem)))









