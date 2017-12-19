#!/bin/bash

#auteur:	Rien Maertens
#aangemaakt:	20/11/14
#doel:		Bash script om de schijngestalten van de maan voor een gegeven maand weer te geven.

#De parameters die met het script werden meegegeven worden opgeslagen.
month=$1
year=$2

#Het juliaanse dagnummer wordt hier berekend en afgetrokken van dat van 6/1/2001 (dit is onze referentiedatum).
a=`echo "(14 - $month)/12" | bc`
y=`echo "$year + 4800 - $a" | bc`
m=`echo "12*$a - 3 + $month" | bc`
jdn=`echo "(153*$m +2)/5 + 365*$y + $y/4 -$y/100 + $y/400 - 32045" | bc`
day1=`echo $jdn - 2451550 | bc`

#Voor elke dag van de maan wordt afgelopen om de maanfase van die dag te berekenen.
i="1"
while [ $i -lt 32 ]
	do

	#De waarde die weergeeft hoe ver de maan in haar periode van 29 dagen zit wordt berekend.
	period=`echo "scale=0;($day1 + $i )%29.5306"  | bc`

	#Op basis van deze waarde wordt de maanfase gesymboliseerd door een @,),0 of een (.
	#Voor elk symbool wordt ook telkens de dag weergegeven.
	response+="$i"
	if [ `echo "$period>14.7653" | bc` = "0" ]
	then
		if [ `echo "$period>7.38265" | bc` = "0" ]
		then
			response+="@"
		else
			response+=")"
		fi
	else
		if [ `echo "$period>22.14795" | bc` = "0" ]
		then
			response+="O"
		else
			response+="("
		fi

	fi

	i=$[$i+1]
done

#Het antwoord (de string met maanfasen per dag) wordt getoond.
echo $response

#Einde van het script.
