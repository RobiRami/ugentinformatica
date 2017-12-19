#!/bin/bash
syntax () { echo "Syntax: $0: dir naam extensie regel"; exit 1; }
if [ $# -ne 4 ]; then
syntax
fi
for file in $(find $1 -name *.$3 | egrep "\/[^/]*$2[^/]*$"); do
sum=$sum`cat $file | sed -n "$4p" | tr '\n' '+'`
done
echo $sum|sed -r 's/(.*)\+$/echo "$((\1))"/' | bash
