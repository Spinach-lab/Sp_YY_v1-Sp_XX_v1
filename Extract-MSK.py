#!/usr/bin/env python
# _*_ coding: utf-8 _*_


#Output
# The output will be a txt file of kemers with the number of occurances in the second column.


from __future__ import  division
from optparse import OptionParser


usage = "\n\npython %prog -f <kmes from female pools> -m <kmers from male pools> -x <minKmers> -y <maxKmers> -o <MSK.txt>"
parser = OptionParser(usage=usage)
parser.add_option("-f", "--female_kmer", dest="female", help="Input kmers with the number of occurances in the female pools")
parser.add_option("-m", "--male_kmer", dest="male", help="Input kmers with the number of occurances in the male pools")
parser.add_option("-x", "--minKmers", dest="Min", type="int", help="Min number of kmer occurances to the ouput")
parser.add_option("-y", "--maxKmers", dest="Max",  type="int",help="Max number of kmer occurances to the ouput")
parser.add_option("-o", "--output_file", dest="file", help="Output file name")

(opt,args) = parser.parse_args()



info_female = {}

with open(opt.female) as f:
     for i in f:
	 i=i.strip().split()
	 info_female[i[0]] = i[1]

with open(opt.male) as f1,\
     open(opt.file,'w')  as o:
     for m in f1:
	 m=m.strip().split()
         if m[0] not in info_female and opt.Min  <= int(m[1])  <= opt.Max:
	    o.write("%s\t%s\n" %(m[0],m[1]))
