i="false"
m="false"
M="false"
naam=""
bestand=""

while getopts ":im:M:" opt; do
    case $opt in
        i )
            i="true"
            ;;
        m )
            if [ ${#OPTARG} = 0 ]; then
                echo "Gelieve voor de minimumwaarde een getal op te geven" 1>&2
                exit 1
            fi
            m=$OPTARG
            ;;
        M )
            if [ ${#OPTARG} = 0 ]; then
                echo "Gelieve voor de maximumwaarde een getal op te geven" 1>&2
                exit 1
            fi
        M=$OPTARG
            ;;
        \? )
            echo "Syntaxis: gebruikersnamen naam -i -m <int> -M <int> [woordenlijst]" 1>&2
            exit 1
    esac
done
shift $((OPTIND - 1))

args=("$@")

if [[ ${#args[@]} -eq 0 ]]; then
    echo "Syntaxis: gebruikersnamen naam -i -m <int> -M <int> [woordenlijst]" >&2
    exit 1
fi

if [[ ${#args[@]} -gt 2 ]]; then
    echo "Syntaxis: gebruikersnamen naam -i -m <int> -M <int> [woordenlijst]" >&2
    exit 1
fi 

naam=$1

if [[ ! ${#2} -eq 0 ]]; then
    bestand=$2
    
    if [[ ! -f $bestand ]] || [[ ! -r $bestand ]]; then
        echo "gebruikersnamen: bestand \"$bestand\" bestaat niet of is onleesbaar" >&2
        exit 2
    fi
else
    while read line; do
        echo $line >> temp.txt
    done </dev/stdin
    bestand="temp.txt"
fi

oldnaam=$naam
naam=$(echo $naam | tr -d .)
patroon=$(echo $naam | sed 's/ //g' | sed 's/\(.\)/\1?/g')
patroon="^$patroon$"

if [[ $i == "false" ]]; then
    if [[ $m == "false" ]] && [[ $M == "false" ]]; then
        result=$(egrep $patroon $bestand | sort)
        egrep $patroon $bestand | sort
    elif [[ $m != "false" ]] && [[ $M == "false" ]]; then
        result=$(egrep $patroon $bestand | egrep "^.{$m,}$" | sort)
        egrep $patroon $bestand | egrep "^.{$m,}$" | sort
    elif [[ $m == "false" ]] && [[ $M != "false" ]]; then
        result=$(egrep $patroon $bestand | egrep "^.{,$M}$" | sort)
        egrep $patroon $bestand | egrep "^.{,$M}$" | sort
    else 
        result=$(egrep $patroon $bestand | egrep "^.{$m,$M}$" | sort)
        egrep $patroon $bestand | egrep "^.{$m,$M}$" | sort
    fi
else
    if [[ $m == "false" ]] && [[ $M == "false" ]]; then
        result=$(egrep -i $patroon $bestand | sort)
        egrep -i $patroon $bestand | sort
    elif [[ $m != "false" ]] && [[ $M == "false" ]]; then
        result=$(egrep -i $patroon $bestand | egrep "^.{$m,}$" | sort)
        egrep -i $patroon $bestand | egrep "^.{$m,}$" | sort
    elif [[ $m == "false" ]] && [[ $M != "false" ]]; then
        result=$(egrep -i $patroon $bestand | egrep "^.{,$M}$" | sort)
        egrep -i $patroon $bestand | egrep "^.{,$M}$" | sort
    else
        result=$(egrep -i $patroon $bestand | egrep "^.{$m,$M}$" | sort)
        egrep -i $patroon $bestand | egrep "^.{$m,$M}$" | sort
    fi
fi

rm temp.txt 2>/dev/null

if [[ ${#result} -eq 0 ]]; then
    echo "gebruikersnamen: geen gebruikersnamen gevonden voor \"$oldnaam\"" >&2
    exit 3
fi