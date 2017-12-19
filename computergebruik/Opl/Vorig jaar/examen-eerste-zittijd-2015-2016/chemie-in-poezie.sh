#!/bin/bash



function hoofdletters() {
    if [[ ! $# -eq 2 ]]; then
        echo "Syntaxis: hoofdletters <woord> <zin>" >&2
        exit 1
    fi
    
    woord=$1
    zin=$2
    
    patroon=$(echo $woord | sed 's/\(.\)/\1\[\^a\-z\]\*/g')
    greppedword=$(echo $zin | egrep -io $patroon)
    substitute=$(echo $greppedword | tr 'a-z' 'A-Z')
    
    if [[ ${#greppedword} -eq 0 ]]; then
        echo $zin
        exit 0
    fi
    
    newsentence=$(echo $zin | sed "s/$greppedword/$substitute/")
    
    if [[ ${#newsentence} -lt ${#zin} ]]; then
        newsentence=$(echo $zin | sed "s/$greppedword/$substitute /")
    fi
    
    echo $newsentence
    
    return 0
}



function markeren() {
    if [[ ! $# -eq 2 ]]; then
        echo "Syntaxis: markeren <tekst> <woordenlijst>" >&2
        exit 1
    fi
    
    tekst=$1
    woordenlijst=$2
    
    while read sentence; do
        sentence=$(echo $sentence | tr 'A-Z' 'a-z')
        if [[ ${#sentence} -gt 2 ]]; then
            while read word; do
                if [[ ${#word} -gt 2 ]]; then
                    sentence=$(hoofdletters "$word" "$sentence")
                fi
            done < $woordenlijst
        fi
        echo $sentence
    done < $tekst
    return 0
}







