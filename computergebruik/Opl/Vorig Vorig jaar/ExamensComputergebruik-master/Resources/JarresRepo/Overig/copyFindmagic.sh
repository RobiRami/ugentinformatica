#!/bin/bash/
#Controleert als er minstens 2 input files zijn.
if [ $# -lt 2 ]
then
	echo "findmagic.sh: at least two regular files should be passed as an argument."
	echo "Usage: findmagic.sh file file ..."
fi
#Controleert als alle files gewone files zijn.
for input in $@
do
	if [ ! -f $input ]
	then
	echo "$input is not readable"
	fi
done
##############################################

#Bestand met minst aantal regels bepalen
#2 kolommen via wc -l: aantal regels & bestandsnaam --> daarom enkel eerste kolom via cut
#via een while loop die telt tot het laatste bestand die via input meegegeven werden bepalen we het laagste aantal regels.
#Instantiëren van variabele
i=0
#Tellen van het aantal regels van het eerste bestand.
lowlines=`wc -l $1 | cut -d " " -f1`
while [ $i -lt $# ]; do
	i=`expr $i + 1`
	#Nieuw aantal regels bepalen. ${�!i} zorgt dat de variabele i wordt meegegeven om het i-de bestand te tonen.
	lines=`wc -l ${!i} | cut -d " " -f1`
	#Als het nieuw aantal regels kleiner is dan het laagste aantal regels dan is dit het nieuwe laagst aantal regels.
	if [ $lines -lt $lowlines ]; then
		lowlines=$lines
	fi
done

#Lijn per lijn wordt overlopen (enkel het aantal regels van het bestand met het minst aantal regels want de andere regels hebben geen nut aangezien het nooit allemaal identiek zal zijn.
#in beide while loops maakt men gebruik van een variabele die alle lijnen/bestanden overloopt, resp. i/j.
i=0
while [ $i -lt $lowlines ]
do
	j=0
	olda=""
	#Counter=1 aangezien een bestand altijd dezelfde regel bevat als zichzelf.
	counter=1
	#Via een nieuwe while loop overloopt men dezelfde lijn van ELK bestand.
	while [ $j -lt $# ]
	do
	j=`expr $j + 1`
	#De i-de byte wordt berekend voor elk bestand.
	a=`dd if=${!j} bs=1 count=1 skip=$i 2> /dev/null`
	#De decimale ASCII-waarde van de variabele a
	b=`echo "$a" | od -td1 | awk 'NR==1{print $2}'`
	#De hexadecimale ASCII-waarde van de variabele a
	c=`echo "$a" | xxd -u -l1 | awk '{print $2}'`
	#Als de vorige a gelijk is aan de nieuwe a dan gaat de counter met één omhoog.
	if [ "$olda" = "$a" ]
		then
		counter=`expr $counter + 1`
	fi
	#Als de counter gelijk is aan het aantal bestanden ( dus als alle bestanden op één regel dezelfde byte hebben ).
	#Dan wordt ofwel a ofwel zijn hexadecimale waarde uitgeprint.
	if [ $counter -eq $# ];	then
		if [ $b -lt 32 -o $b -eq 127 ]
        	then
			#Indien de decimale onder 32 of gelijk aan 127 is wordt de hexadecimale waarde uitgeprint.
			echo "$i: $c"
		else
			#Zoniet wordt de byte zelf uitgeprint.
			echo "$i: $a"
		fi
	fi
	#De a wordt vastgezet als vorige a, om te kunnen vergelijken.
	olda=$a
	done
	i=`expr $i + 1`
done






