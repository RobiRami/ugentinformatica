#zet alles op 1 regel en verwijder newlines
:a
$!N
s/\n//g
s/[^A-Z]//g
ta
:b
#verwijder duplicaten
s/\(.*\)\(.\)\(.*\)\2\(.*\)/\1\2\3\4/
tb
#plak het alfabet achter de ongesorteerde tekenreeks
s/.*/&,ABCDEFGHIJKLMNOPQRSTUVWXYZ/
:c
#zet rond elke letter die voor de komma voorkomt(tekens) na de komma 2 dubbele punten
s/\(.*\)\(.\)\(.*\),\(.*\)\2\(.*\)/\1\3,\4:\2:\5/g
tc
#verwijder alles dat niet tussen dubbele punten staat: resultaat gesorteerd
s/[^:]*:\(.\):[^:]*/\1/g




