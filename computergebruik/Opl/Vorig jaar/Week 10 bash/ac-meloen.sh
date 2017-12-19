test=$(</dev/stdin)

args=("$@")

if [ ${#args[@]} -eq 0 ]; then
    echo "Syntaxis: rvf patroon [bestand]" >&2
    exit 1
fi

if [ ${#args[@]} -gt 2 ]; then
    echo "Syntaxis: rvf patroon [bestand]" >&2
    exit 1
fi 

if [[ ! -f ${2:-/dev/stdin} ]] || [[ ! -r ${2:-/dev/stdin} ]]; then
    if [[ ${#test} -eq 0 ]]; then
        echo "rvf: bestand \"${args[1]}\" bestaat niet of is onleesbaar" >&2 
        exit 2
    fi
fi

pattern=$(echo ${args[0]} | sed "s/[aeiou]/\[aeiou\]/g")
result1=$(grep "^$pattern$" ${args[1]} | sed "/${args[0]}/d" | sort)

if [ ! ${#result1} -gt 0 ]; then
    result1=$(printf "$test" | grep "^$pattern$" | sed "/${args[0]}/d" | sort)
    if [ ! ${#result1} -gt 0 ]; then
        echo "rvf: geen uitdrukkingen gevonden die matchen met \"${args[0]}\"" >&2
        exit 3
    fi
fi

printf "$result1"
exit 0