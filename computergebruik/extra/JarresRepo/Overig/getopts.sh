#!/bin/bash
usage() { echo "Syntax: $0: -i brontaal -o doeltaal [ -c cycli ] [-v] \"zin\""; }
verbose=0
cycli=10
while getopts ":i:o:c:v" opt; do
	case $opt in
                i) brontaal=$OPTARG
		if [ $(echo $OPTARG | egrep -c '^[a-z]+$') -eq 0 ]; then
		usage
		exit 1
		fi
;;
                o) doeltaal=$OPTARG
		if [ $(echo $OPTARG | egrep -c '^[a-z]+$') -eq 0 ]; then
                usage
                exit 1
                fi
;;
                c) cycli=$OPTARG
		if [ $(echo $OPTARG | egrep -c '^[0-9]+$') -eq 0 ]; then
                usage
                exit 1
                fi
;;
                v) verbose=1
;;
                \?) usage
;;
        esac
done
shift $((OPTIND - 1))
zin=$1
controlezin=$zin
heenvertalen() {
antwoord=`curl -s -i --user-agent "" -d "sl=${brontaal}" -d "tl=${doeltaal}" --data-urlencode "text=${zin}" https://translate.google.com`
vertaling=`echo ${antwoord} | sed "s/^.* id=result.box[^<]*<span[^>]*>\([^<]*\)<\/span>.*$/\1/" | sed "s/&[^;]*;//g"`
}
weervertalen() {
antwoord=`curl -s -i --user-agent "" -d "sl=${doeltaal}" -d "tl=${bronltaal}" --data-urlencode "text=${vertaling}" https://translate.google.com`
zin=`echo ${antwoord} | sed "s/^.* id=result.box[^<]*<span[^>]*>\([^<]*\)<\/span>.*$/\1/" | sed "s/&[^;]*;//g"`
}
while [ $cycli -gt 0 ]; do
heenvertalen
weervertalen
if [ "$(echo $zin | tr 'A-Z' 'a-z')" = "$(echo $controlezin | tr 'A-Z' 'a-z')" ]; then
	echo $1
	echo $zin
	exit 0
fi
if [ $verbose -eq 1 ]; then
	echo $vertaling
	echo $zin
fi
controlezin=$zin
cycli=`expr $cycli - 1`
done
