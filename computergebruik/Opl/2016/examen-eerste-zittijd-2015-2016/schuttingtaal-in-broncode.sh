Schuttingtaal (https://dodona.ugent.be/nl/courses/19/exercises/1839353126/)
door Winnie

#! /bin/bash

#Error-message-functie
function error() {
        echo "Syntaxis: schuttingtaal [-f] [-c commit] <git-repo> <token> 1>&2"
        exit 1
}
#Lokale variabelen: zoeken naar bestanden of naar aantal matches?
bestanden=false
#Andere versie van repository doorzoeken?
versie=""

while getopts ":fc:" opt ; do
        case "$opt" in
        f)bestanden=true
                ;;
        c)versie="$OPTARG"
                ;;
        \?)error
        esac
done
shift $((OPTIND-1))

if [ $# -ne 2 ] ; then #Te weinig/veel argumenten(Enkel repo-locatie en token nodig)
        error
fi
dirnaam=$(echo "$1" | sed 's/\.git//' | sed 's/.*\/\([^/]*$\)/\1/')
#Meegegeven link omzetten naar correcte naam voor directory
if [ ! -d "$dirnaam" ] ; then
        git clone "$1" "$dirnaam" #Bestaat nog niet in working directory
        cd $dirnaam
else #Verplaatsen naar de nieuwe repository
        cd $dirnaam #Bestaat reeds, updaten naar recentste versie
        git pull origin master > /dev/null
fi
if [ ! -z "$versie" ] ; then
        git checkout -q "$versie"
        if [ $? != 0 ] ; then #Meegegeven commit bestaat niet
                echo "Pathspec $versie does not exist" 1>&2
                exit 2
        fi
fi
if [ "$bestanden" = true ] ; then
        grep -rl "$2" | wc -l #Tel het aantal bestanden met l-vlag
else                            #Alle bestanden doorzoeken via r-vlag(recursief)
        grep -r "$2" | wc -l
fi
exit 0



DEPRECATED niet zo'n goede code maar als legacy mag het blijven staan, was steun voor laatste vlag

c="false"
f="false"

while getopts ":c:f" opt; do
    case $opt in
        c )
            if [ ${#OPTARG} = 0 ]; then
                echo "Syntaxis: schuttingtaal [-f] [-c commit] <git-repo> <token>" 1>&2
                exit 1
            fi
            c=$OPTARG
            ;;
        f )
            f="true"
            ;;
        \? )
            echo "Syntaxis: schuttingtaal [-f] [-c commit] <git-repo> <token>" 1>&2
            exit 1
    esac
done
shift $((OPTIND - 1))

if [[ ! $# -eq 2 ]]; then
    echo "Syntaxis: schuttingtaal [-f] [-c commit] <git-repo> <token>" 1>&2
    exit 1
fi

gitrepo=$1
word=$2

directory=$(echo $gitrepo | egrep -o '[^//]*$' | sed 's/.git//')

if [[ ! -d $directory ]]; then
    git clone $gitrepo $directory > /dev/null
    cd $directory
else
    cd $directory
    git pull origin master > /dev/null
fi

if [[ $c != "false" ]]; then
    git checkout $c > /dev/null
    if [ $? != 0 ]; then
        exit 2
    fi
    if [ $f = "true" ]; then
        result="$(grep -rl $word | wc -l)"
    else
        result="$(grep -r $word | wc -l)"
    fi
else
    if [ $f = "true" ]; then
        result="$(grep -rl $word | wc -l)"
    else
        result="$(grep -r $word | wc -l)"
    fi
fi

echo $result








