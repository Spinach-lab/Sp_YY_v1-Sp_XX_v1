ref=
reads=

minimap2 -t 10 $ref $reads >round_1.paf
racon -t 10 $reads round_1.paf  $ref > ${ref}.r1.fa
minimap2 -t 10 ${ref}.r1.fa   $reads >round_2.paf
racon -t 10 $reads round_2.paf  ${ref}.r1.fa >${ref}.r2.fa
minimap2 -t 10 ${ref}.r2.fa $reads >round_3.paf
racon -t 10 $reads round_3.paf ${ref}.r2.fa >${ref}.r3.fa
