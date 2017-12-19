#! /bin/bash
# Matthias Lemmens

# maand en jaar bepalen van input of van date-commando

if [ $# == 0 ]
then
	month=$(date '+%m')
	year=$(date '+%y')
else
	month=$1
	year=$2
fi

# datum verwerken en jdn van berekenen

function jdn {

	dd=$(echo $1 | gsed -ne 's/^\([0-3][0-9]\)[\/\-]\([0-1][0-9]\)[\/\-]\([0-9]*\)$/\1/p')
	mm=$(echo $1 | gsed -ne 's/^\([0-3][0-9]\)[\/\-]\([0-1][0-9]\)[\/\-]\([0-9]*\)$/\2/p')
	jjjj=$(echo $1 | gsed -ne 's/^\([0-3][0-9]\)[\/\-]\([0-1][0-9]\)[\/\-]\([0-9]*\)$/\3/p')

	a=$(echo "(14 - $mm)/12" | bc )
	y=$(echo "$jjjj + 4800 - $a" | bc)
	m=$(echo "12 * $a - 3 + $mm" | bc)
	jdn=$(echo "$dd + ( 153 * $m + 2 ) / 5 + 365 * $y + $y / 4 - $y / 100 + $y / 400 - 32045" | bc)
	echo $jdn
}

# maandstand berekenen voor opgegeven datum adhv jdn. mndstnd staat wel degelijk voor maandstAnd, niet maandstond

function maandstand {

	jdn1=$(jdn 06-01-2000)
	jdn2=$(jdn $1)

	dr=$(echo "$jdn2 - $jdn1" | bc)
	dn=$(echo "( $dr % 29.530588853 ) / 1" | bc)

	if [ $dn -lt 7 ]
	then
		mndstnd="@"
	elif [ $dn -lt 15 ]
	then
		mndstnd=")"
	elif [ $dn -lt 22 ]
	then
		mndstnd="O"
	else
		mndstnd="("
	fi
	echo $mndstnd
}

# Alle dagen van de opgegeven maand overlopen, maandstand berekenen en mooi weergeven op een lijntje

for (( x=1; x<=31; x++ ))
do

	if [ $x -lt 10 ]
	then
		date=0$x/$month/$year
	else
		date=$x/$month/$year
	fi

	stnd=$(maandstand $date) 

	echo -n "$x $stnd "
done

echo
