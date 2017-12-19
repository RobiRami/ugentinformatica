#!/bin/bash

#auteur:	Rien Maertens
#aangemaakt:	4/12/14
#doel:		Via google translate een tekst van een gegeven brontaal naar een doeltaal heen en terug vertalen
#		tot de tekst stabiliseerd.

#De standaard variabalen (verbose uit en maximum aantal cycli 10) worden ingesteld.
verbose=0
cycli=10
use="use: $0 -[v](verbose) -[c integer](cycli) -i(source language) -o(target language) TEXT"

#De arguments die worden weergegeven worden afgehandeld.
while getopts ":vc:i:o:" opt
do
	case $opt in
		v ) verbose=1
			;;
		#Bij de c-flag wordt er eerst gecontroleerd of het argument die werd weergegeven een getal is
		#en daarna wordt de waarde van het maximum aantal cycli aangepast.
		c )	if test $OPTARG -eq $OPTARG 2>/dev/null
				then
			 	cycli=$OPTARG
				else
				echo $OPTARG
				echo "$0: the -c flag needs an integer as argument" >&2
				echo $use >&2
				exit 1
			fi
			;;
		#Bij de i-flag wordt er gecontroleerd of er een argument werd ingevoerd.
		i )	if test -n $OPTARG
				then
				sl=$OPTARG
				else
				echo "$0: the -i flag needs an argument" >&2
				echo $use >&2
				exit 1
			fi
			;;
		#Bij de o-flag wordt er gecontroleerd of er een argument werd ingevoerd.
		o )	if test -n $OPTARG
				then
				tl=$OPTARG
				else
				echo "$0: the -o flag needs an argument" >&2
				echo $use >&2
				exit 1
			fi
			;;
		#Wanneer er onbekende flags worden ingevperd dan wordt  het script afgesloten.
		\? )	echo $use >&2
			exit 0
	esac
done
shift $((OPTIND - 1))

#De tekst die moet vertaald worden wordt in een variabele opgeslagen.
text=$*

#Controle of alle verplichte argumenten zijn ingevoerd.
if test -z "$sl"
	then
	echo "$0: the -i flag is required" >&2
	echo $use >&2
	exit 2
elif test -z "$tl"
	then
	echo "$0: the -o flag is required" >&2
	echo $use >&2
	exit 2
elif test -z "$text"
	then
	echo "$0: this command requires some text to translate" >&2
	echo $use >&2
	exit 2
fi

#Wanneer verbose uitstaat wordt de originele tekst weergegeven.
if test $verbose -eq 0
	then
	echo $text
fi
completed=0
i=0
while test $i -lt $cycli -a $completed = 0
	do
		#De tekst wordt van de brontaal naar de doeltaal vertaald.
		antwoord=$(curl -s -i --user-agent "" -d "sl=$sl" -d "tl=$tl" --data-urlencode "text=$text" https://translate.google.com)
		vertaling=$(echo $antwoord | sed "s/^.*id=result_box[^<]*<span[^>]*>\([^<]*\)<\/span>.*$/\1/" | sed "s/&[^;]*;//g")

		#In verbose modus wordt deze vertaling weergegeven.
		if test $verbose -eq 1
			then
			echo $vertaling
		fi

		#De vertaalde tekst wordt van de doeltaal naar de brontaal vertaald.
                antwoord=$(curl -s -i --user-agent "" -d "sl=$tl" -d "tl=$sl" --data-urlencode "text=$vertaling" https://translate.google.com)
                vertaling=$(echo $antwoord | sed "s/^.*id=result_box[^<]*<span[^>]*>\([^<]*\)<\/span>.*$/\1/" | sed "s/&[^;]*;//g")

		#in verbose modus wordt de vertaling weergegeven.
		if test $verbose -eq 1
                        then
                        echo $vertaling
                fi

		#Wanneer de laatste vertaling overeenkomt met de tekst die moest vertaald worden aan het begin
		#van de cyclus, dan wordt de loop beeindigd.
		if test "$vertaling" = "$text"
			then
			completed=1
		fi

		#De laatste vertaling wordt opgeslagen als de te vertalen tekst.
		text="$vertaling"

i=$(($i+1))
done


#Wanneer de verbose modus uitstaat wordt de uiteindelijke tekst weergegeven.
if test $verbose -eq 0
	then echo $text
fi

#Einde van het script.




