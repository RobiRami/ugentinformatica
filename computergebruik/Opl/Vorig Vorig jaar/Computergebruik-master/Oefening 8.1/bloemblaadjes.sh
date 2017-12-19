#!/bin/bash

#auteur: 	Rien Maertens
#aangemaakt:	20/11/14
#doel:		bashscript om het denkspel 'Bloemnlaadjes rond de Roos' te simuleren

#We selecteren een groepje getallen willekeurig uit bloemblaadjes.txt door eerst random te sorteren, en daarna
#enkel de eerste regel wordt opgeslagen.
random=`cat bloemblaadjes.txt | sort -R | sed -n '1p'`

#De eerste vier getallen worden getoond, met de vraag hoeveel bloemblaadjes er rond de roos staan.
echo $random | cut -c 1-9 | sed 's/^./Worp: &/'
echo "Hoeveel bloemblaadjes staan er rond de roos?"

#Het correcte antwoord wordt hier uit de getallen gehaald en opgeslagen.
correct=`echo $random | cut -c 11-`

#De user input wordt gelezen en opgeslagen.
read answer

#De user krijgt feedback of zijn antwoord al dan niet het correcte antwoord is en wordt verbeterd indien nodig.
if [ "$answer" = "$correct" ]
then
	echo "Correct! Er staan $answer bloemblaadjes rond de roos!"
	echo "( bij deze ben je gebonden aan strikte geheimhouding)"
else
	echo "Fout! Er staan $correct bloemblaadjes rond de roos!"
fi

#Einde van het script.
