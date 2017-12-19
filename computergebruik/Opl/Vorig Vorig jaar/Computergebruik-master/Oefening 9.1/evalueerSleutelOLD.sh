#!/bin/bash
#minder efficient script (duurt 30+ seconden om uit te voeren)
if test $# -eq 0 -o $# -gt 2
then
	echo "Gebruik: $0 sleutel [bestand]" 1>&2
	exit 1
fi

key=$1

if [ ! `echo $key | sed  's/./&\n/g' | sort | tr -d '\n'` = "abcdefghijklmnopqrstuvwxyz" ]
then
	echo "fout: sleutel is geen permutatie van het alfabet" 1>&2
	exit 2
fi

if [ $2 ]
then
	file=$2
elif [ $INVOER ]
then
	file=$INVOER
elif [ /dev/stdin ]
then
	file=/dev/stdin
fi

if test ! -r $file 
then
	echo "fout: bestand $file kon niet gelezen worden" 1>&2
	exit 3
fi

hits=0

while read line
do
converted=`echo $line | tr 'abcdefghijklmnopqrstuvwxyz' $key`
convertedA=`echo $converted | sed  's/./&\n/g' | sort | tr -d '\n'`

if test  $converted = $convertedA 
then
hits=$(($hits+1))
fi

echo $line

done <$file

echo $hits
