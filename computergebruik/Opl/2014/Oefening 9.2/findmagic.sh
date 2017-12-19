#!/bin/bash
#auteur:	Rien Maertens
#aangemaakt:	27/11/14
#doel:		Van twee of meer bestanden worden de eerste 100 bytes met elkaar vergeleken en worden
#		de overeenkomstige bytes weergegeven. Hiermee kunje de mgic bits van een bestandstype vinden.

#Controle of minstens twee argymenten werden megegven.
if test $# -le 1
then
	echo "$0: at least two regular files should be passed as an argument"
	echo "Usage: findmagic.sh file file ..."
	exit 1
fi

#Twee arrays worden aangemaakt, met een lengte die overeenkomt met het aantal argumenten die werden megegeven.
files=($*)
bytes=($*)
k=0

#Controle of alle bestanden normale bestanden zijn.
while test $k -lt ${#files[*]}
	do
	if test ! -f ${files[$k]}
		then
		echo "$0: ${files[$i]} is not a regular file."
        	echo "Usage: findmagic.sh file file ..."
		exit 2

	fi
        k=$(($k+1))
done

#De eerste 100 bytes worden afgelopen.
j=0
while test $j -lt 99
	do
		#Alle files worden afgelopen.
		i=0
		while test $i -lt ${#bytes[*]}
			do

			#Van elke file worden de eerste 100 bytes afgelopen en omgezet naar hun decimale waarde.
			bytes[$i]=""
			bytes[$i]+="$j: "
			dec=`dd if=${files[$i]} bs=1 count=1 skip=$j 2>/dev/null | od -td1 | awk 'NR==1{print $2}'`

			#Elke byte wordt opgeslagen als een ascii-karakter (indien mogelijk) als de byte geen
			#uitprintbare ascii-karakter is dan wordt deze in hexadecimale vorm opgeslagen.
			if test $dec -lt 32 -o $dec -eq 127
				then
				bytes[$i]+="0\\\x"
				bytes[$i]+=`dd if=${files[$i]} bs=1 count=1 skip=$j 2>/dev/null | xxd -u -l1 |awk '{print $2}'`

				else
				bytes[$i]+=`printf "\x$(printf %x $dec)"`
			fi

			#Eerst wordt de byte van de eerste file op de huidige positie opgeslagen in een variabele.
			#Bij de volgende files wordt er gekeken of de byte op deze positie dezelfde is als de
			#eerste file, wanneer dit niet zo is wordt de variabele leeggemaakt.
			if test $i -eq 0
				then
				line=${bytes[0]}
				line+="\n"
				else
					if test "${bytes[0]}" != "${bytes[$i]}"
						then
						line=""
					fi
			fi

		i=$(($i+1))
		done

#Na elke byte die wordt afgelopen word de overeenkomstige byte neergeschreven (als er een is).
result+=$line

j=$(($j+1))
done

echo -e $result

#Einde van het script.
