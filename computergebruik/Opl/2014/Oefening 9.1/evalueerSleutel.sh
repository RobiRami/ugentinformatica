#!/bin/bash

#auteur: 	Rien Maertens
#aangemaakt: 	27/11/14
#doel:		Volgens een sleutel (permutatie v.h. alfabet) een reeks van woorden te coderen en kijken
#		bij hoeveel van die woorden de letters in alfabetische volgorde staan.

#Controle of de juiste hoeveelheid parameters werd meegegeven.
if test $# -eq 0 -o $# -gt 2
then
	echo "Gebruik: $0 sleutel [bestand]" 1>&2
	exit 1
fi

key=$1

#Controle of de sleutel een permutatie van het alfabet is.
if test `echo $key | sed  's/./&\n/g' | sort | tr -d '\n'` != "abcdefghijklmnopqrstuvwxyz"
then
	echo "fout: sleutel is geen permutatie van het alfabet" 1>&2
	exit 2
fi

#Zoeken naar naar de input file om te coderen in de parameters, de globale variabele $INVOER os standard input.
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

#Controle of de input file leesbaar is.
if test ! -r $file 
then
	echo "fout: bestand $file kon niet gelezen worden" 1>&2
	exit 3
fi

#De reeks van woorden wordt met tr gecodeerd en in een tempfile opgeslagen.
cat "$file" | tr 'abcdefghijklmnopqrstuvwxyz' $key > temp

#Met grep worden alle woorden waarvan de letters in alfabetische volgorde stan geselecteerd en met wc wordt het
#aantal hits geteld.
hits=`cat temp | grep '^a*b*c*d*e*f*g*h*i*j*k*l*m*n*o*p*q*r*s*t*u*v*w*x*y*z*$' | wc -l`

#De tempfile wordt verwijderd en het aantal hits wordt weergegeven.
rm temp
echo $hits

#Einde van het script.
