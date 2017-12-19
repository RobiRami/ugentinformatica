#!/bin/bash

if [ $# -lt 1 ]
then
    echo "Geef minstens 1 getal op" 1>&2
fi

for getal
do
    ./genereerPriemgetallen.sh getallen.txt $getal
    nr=`grep -n ^$getal$ getallen.txt | cut -d: -f1 | bc`
    oud=$nr

    if [ "$nr" == "" ]
    then
        echo "$getal is geen superpriem"
    else
        echo "$getal is het "$nr"e priemgetal"
    fi

    while [ "$nr" != "" -a "$nr" != "1" ]
    do
        oud=$nr
        nr=`grep -n ^$nr$ getallen.txt | cut -d: -f1 | bc`
        echo "$oud is het "$nr"e priemgetal"
    done

    if [ "$nr" == "1" ]
    then
        echo
        echo "*** $getal is een superpriem ***"
        echo
    else
        echo "$oud is geen priemgetal"
        echo
        echo "*** $getal is geen superpriem ***"
        echo

    fi
done
