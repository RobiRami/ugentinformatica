#!/bin/bash
if [ $# -eq 0 -o $# -gt 2 ]; then
echo "gebruik: evalueersleutel.sh sleutel [ bestand ]"
exit 1
elif [ `echo $1 | egrep '^.{26}$' | egrep -cv 'abcdefghijklmnopqrstuvwxyz'` -eq 0 ]; then
echo "fout: sleutel is geen permutatie van het alfabet"
exit 2
fi

if [ $2 ]; then
	if [ ! -r $2 ]; then
	echo "fout: bestand $2 kan niet gelezen worden"
	else
	cat "$2" | dos2unix | tr "abcdefghijklmnopqrstuvwxyz" "$1" | egrep -c '^a?b?c?d?e?f?g?h?i?j?k?l?m?n?o?p?q?r?s?t?u?v?w?x?y?z?$'
	fi
elif [ "$INVOER" ]; then
cat "$INVOER" | dos2unix | tr "abcdefghijklmnopqrstuvwxyz" "$1" | egrep -c '^a?b?c?d?e?f?g?h?i?j?k?l?m?n?o?p?q?r?s?t?u?v?w?x?y?z?$'
else
read INVOER
echo "$INVOER" | dos2unix | tr "abcdefghijklmnopqrstuvwxyz" "$1" | egrep -c '^a?b?c?d?e?f?g?h?i?j?k?l?m?n?o?p?q?r?s?t?u?v?w?x?y?z?$'
fi
