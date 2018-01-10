declare -A schema
alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
while read line
do
	rijm=$(sed -r "s#.* ([[:alpha:]]+)[^[:alpha:]]*\$#\1##" <<< "$line" | xargs -i egrep "^{} " -i "$2" | sed -r "s#.*? ([[:alpha:]]*(1|2)[^1-9]*$)#\1#" | tr -d "[:digit:]")
	if [ ! ${schema["$rijm"]+_} ]; then
		schema["$rijm"]=${alphabet:${#schema[@]}:1}
	fi
	printf ${schema["$rijm"]}
done < <(sed '/^$/d' "$1")
printf "\n"
