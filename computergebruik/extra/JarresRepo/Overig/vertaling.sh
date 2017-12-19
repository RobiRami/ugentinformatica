#!/bin/bash
usage() { echo "Syntax: $0: -i brontaal -o doeltaal[-i cycli] [-v] \"zin\""; }
while getopts ":i:o:c:v" opt; do
	case $opt in
		i)
		if [ $OPTARG ]; then
		 brontaal=$OPTARG
echo "ja 1"
		else
		 usage
		 exit 1
		fi
		;;
		o)
		if [ $OPTARG ]; then
                 doeltaal=$OPTARG
echo "ja 2"
                else
                 usage
                 exit 1
		fi
		;;
		c)
		if [ $OPTARG -gt 0 ] 2> /dev/null
		then
			cycli=$OPTARG
echo "ja 3"
		else
			usage
			exit 1
		fi
		;;
		v) verbose=1
echo "ja 4"
		;;
		\?) usage
		exit 1
		;;
		:) usage
		;;
	esac
done
shift $((OPTIND - 1))
zin=$1
echo "######"
echo "i: $brontaal"
echo "o: $doeltaal"
echo "c: $cycli"
echo "zin: $zin"
exit
while [ $cycli -gt 0 ]; do
antwoord=`curl -s -i --user-agent "" -d "sl=${brontaal}" -d "tl=${doeltaal}" --data-urlencode "text=${zin}" https://translate.google.com`
vertaling=`echo ${antwoord} | sed "s/^.* id=result.box[^<]*<span[^>]*>\([^<]*\)<\/span>.*$/\1/" | sed "s/&[^;]*;//g"`
echo $vertaling
cycli=`expr $cycli - 1`
tmptaal=$brontaal
brontaal=$doeltaal
doeltaal=$tmptaal
zin="$vertaling"
done

