#!/bin/bash
reeks=`cat ~/.bloemblaadjes | sort -R | head -1`
gegeven=`echo $reeks | cut -d" " -f1-5`
antwoord=`echo $reeks | cut -d" " -f6 | egrep -o '[0-9]*'`
echo "Worp: $gegeven"
read -p "Hoeveel bloemblaadjes staan er rond de doos? " input
if [ "$(echo $input | tr 'E' 'e')" = "e" ]; then
exit 1
elif [ $input -eq $antwoord ]; then
echo "Correct! Er staan $antwoord bloemblaadjes rond de doos!"
echo "(Bij deze ben je gebonden aan een strikte geheimhouding)"
else
echo "Fout! Er staan $antwoord bloemblaadjes rond de doos!"
fi
