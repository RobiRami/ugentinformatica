#!/bin/bash
#BEREKENINGEN
a=`echo "scale=10;(14-$1)/12"|bc`
y=`echo "scale=10;$2+4800- $a"|bc`
m=`echo "scale=10;12*$a-3+$1"|bc`
p=29.530588853
p1=`echo "scale=10;$p/4"|bc`
p2=`echo "scale=10;$p/2"|bc`
p3=`echo "scale=10;3*$p/4"|bc`
############
for dd in {1..31}; do
jdn=`echo "$dd+(153*$m+2)/5+365*$y+$y/4-$y/100+$y/400-32045-2451549"|bc`
dn=`echo "$jdn%$p"|bc`
if [ `echo "$dn<$p1"|bc` -eq 1 ]; then
echo -n "$dd@"
elif [ `echo "$dn<$p2"|bc` -eq 1 ]; then
echo -n "$dd)"
elif [ `echo "$dn<$p3"|bc` -eq 1 ]; then
echo -n "${dd}O"
else
echo -n "$dd("
fi
done
echo
