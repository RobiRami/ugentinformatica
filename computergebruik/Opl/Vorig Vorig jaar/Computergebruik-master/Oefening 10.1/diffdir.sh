#!/bin/bash

#auteur: 	Rien Maertens
#aangemaakt: 	4/12/14
#doel:		Twee mappen worden met elkaar vergeleken op basis van hun sha-waarde. Bestanden die toegevoegd,
#		verwijderd of verplaatst werden worden weergegeven.

#Controle of er twee argumenten zijn en of deze argumenten directories zijn.
if test "$#" -ne 2 -o ! -d "$1" -o ! -d "$2"
then
	echo "Gebruik: diffdir DIRECTORY DIRECTORY" >&2
	exit 1
fi

#Elke file in deze directories wordt omgezet naar zijn sha-haswaarde en neergeschreven in een temporary file.
find $1 -type f | xargs shasum | sort | sed "s/$1\///" > temp1
find $2 -type f | xargs shasum | sort | sed "s/$2\///" > temp2

#Deze twee files worden met elkaar vergeleken. De unieke lijntjes per file worden in twee nieuwe files opgeslagen.
comm -23 temp1 temp2 > temp3
comm -13 temp1 temp2 > temp4

#De verplaatste bestanden zijn bestanden waarvan de hashwaarde in beide bestanden voorkomt.
#Wanneer er in temp3 en temp4 twee files gevonden worden met een overeenkomstige hashwaarde dan worden deze
#bestanden toegevoegd aan de variabele moved met een pijltje tussen de oude en neiuwe locatie.
moved=""
while read line
	do
	hash=`echo $line | cut -d" " -f1`
	found=`grep "$hash" temp4`

	if test -n "$found"
		then
		moved+="  "
		moved+=`echo $line | cut -d" " -f2`
		moved+=" > "
		moved+=`echo $found | cut -d" " -f2`
		moved+="\n"
	fi

done < temp3

#Verwijderde bestanden zijn bestanden die enkel in temp1 zitten en niet in temp2.
#Wanneer er een haswaarde in temp1 wordt gevonden die niet in temp2 voorkomt, dan wordt de bestandsnaam opgeslagen
#in de variabele deleted.
deleted=""
while read line
	do
	hash=`echo $line | cut -d" " -f1`
	found=`grep "$hash" temp2`

	if test -z "$found"
		then
		deleted+="  "
		deleted+=`echo $line | cut -d" " -f2`
		deleted+="\n"
	fi
done < temp1

#Toegevoegde bestanden zijn bestanden die enkel in temp2 voorkomen en niet in temp1.
#Wanneer er een haswaarde uit temp2 wordt gevonden die niet in temp2 voorkomt, dan wordt de bestandsnaam opgeslagen
#in de variabele added.
added=""
while read line
        do
        hash=`echo $line | cut -d" " -f1`
        found=`grep "$hash" temp1`

        if test -z "$found"
                then
		added+="  "
                added+=`echo $line | cut -d" " -f2`
		added+="\n"
        fi
done < temp2

#De variablen deleted, added en moved worden getoond aan de gebruiker. Wanneer er een  variabele leeg is dan wordt
#dat gedeelte niet getoond.
if test -n "$deleted"
	then
	echo "verwijderde bestanden:"
	echo -ne "$deleted"
fi

if test -n "$added"
	then
	echo "toegevoegde bestanden:"
	echo -ne "$added"
fi

if test -n "$moved"
	then
	echo "verplaatste bestanden:"
	echo -ne "$moved"
fi

#Verwijderen van de tempfiles.
rm temp1 temp2 temp3 temp4

#Einde van het script.
