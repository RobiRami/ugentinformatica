#!/bin/bash

function isPriem {
lim=$(echo "sqrt($1)" | bc)
priem=0
i=2
# for i in $(seq $lim)
#for ((i=2; i<=$lim; i++))
while [ $i -le $lim -a $priem -eq 0 ]
do
    if (( $1 % $i == 0 ))
    then
        priem=1
    fi
    i=$[$i+1]
done

return $priem
}

if [ $# -ne 2 ]
then
    echo "Geef twee argumenten op" 1>&2
    exit 1
fi

# if [[ $2 =~ ^[0-9]+$ ]]

if expr "$2" : '^[0-9]\+$' >/dev/null
then
    echo "Argumenten zijn geldig" 1>&2
else
    echo "Het tweede argument moet een positief geheel getal zijn" 1>&2
    exit 1
fi

if [ -e "$1" ]
then
    begin=$(cat $1 | tail -1 | bc)
    if [ $begin -ge "$2" ]
    then
        echo "Niets om aan te vullen" 1>&2
        exit 0
    fi
else
    echo "2" >> "$1"
    begin=3
fi

for ((j=$begin; j<=$2; j++))
do
    if ( isPriem "$j" )
    then
        echo "$j" >> "$1"
    fi
done