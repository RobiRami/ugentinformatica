#!/bin/bash
# Geen commentaar, dat is leuker.
# Pieter De Bruyne , Juni 2011
if [[ ! $# -eq 4 || `echo $1 $2 $3 | grep '[^A-Z| ]'` || `echo $4 | grep '[^0-9]'` ]]
then
	echo -e "4 argumenten verwacht:\nArgumenten 1 tot 3 mogen enkel bestaan uit hoofdletters.\nArgument 4 mag enkel bestaan uit cijfers."
elif [[ ! $(echo $1$2$3 | gsed -f reduceer.sed | wc -c) -eq $(echo $4 | wc -c) ]]
then
	echo -e "Het aantal verschillende letters van de eerste 3 argumenten moet gelijk zijn \naan het aantal cijfers in argument 4."
exit 1
fi

function max(){
if [[ $# -eq 0 ]]
then
	echo 0
else
	local length=0
	for i in $*
	do
		if [ ${#i} -gt $length ]
		then
			length=${#i}
		fi
	done
echo $length
fi
}

function opmaak(){
	local length=$(max $1 $2 $3)+1
	length=$(echo $length | bc)
	printf "%+"$length"s\n" $1
	printf "%+"$length"s\n" $2 | gsed 's/^ /+/'
	printf "%"$length"s\n" " " | tr ' ' '-'
	echo =$3
}

function controleer_som(){
	local som=0
	for(( c=1; c<$#; c++))
	do
		let som+=${!c}
	done
	if [[ som -eq ${@: -1} ]]
	then
		echo "Correcte som!"
	else
		echo "Incorrecte som!"
	fi
}

opmaak $1 $2 $3

subs=$(echo $(opmaak $1 $2 $3 | gsed -f reduceer.sed),$4 | gsed ':a ; s/\([^0-9]\)\([^0-9]*\),\(.\)\(.*\)/\1\3\2,\4/g ; ta' | gsed 's/,//')

echo

(echo $subs ; opmaak $1 $2 $3) | gsed -f vervang.sed


somargs=$((echo $subs ; opmaak $1 $2 $3) | gsed -f vervang.sed | tr '\n' ' ' | gsed 's/[^0-9]/ /g' | gsed 's/[ ] */ /g; s/^[ ]*//; s/[ ]*$//')

echo

controleer_som $somargs

exit 0
