# Cynric Huys
# plaats de eerste regel (de transformatie) in de holdspace
1H
# print de eerste regel niet uit
1d
# voor de tweede t.e.m. de laatste regel wordt, als de regel hoofdletters bevat, de inhoud van de holdspace teruggehaald, elke hoofdletter door het overeenkomstige cijfer vervangen (door 'g' voor elk voorkomen van die letter). Dit wordt herhaald zolang de regel nog hoofdletters bevat.
2,${
	:a
	/[A-Z]/G
	s/^\([^A-Z]*\)\(.\)\(.*\)\n.*\2\(.\).*$/\1\4\3/g
	/[A-Z]/ta
}
# verwijder de newlines
s/\n//g
# print alle regels die leeg zijn niet uit
/^$/d
