:x#!/bin/bash
syntax () { echo "Syntax: $0: file.zip [naam extensie regel]"; exit 1; }
if [ $# -lt 4 ]; then
syntax
fi
if [ $(echo $1 | egrep -c ".zip$") -ne 1 ]; then
syntax
fi
product=1
unzip -q $1
dir=`ls | grep "$1" | sed -r 's/(.*)\.zip/\1/'`
shift
while [ $# -gt 0 ]; do
	if [ $# -lt 3 ]; then
	num=1
	else
	num=`./som.sh $dir $1 $2 $3`
	fi
shift 3
product=`echo "$(($product * $num))"`
done
echo $product
rm -r $dir
