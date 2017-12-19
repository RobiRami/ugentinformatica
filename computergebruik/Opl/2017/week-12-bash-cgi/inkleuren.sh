if [[ ${#1} = 0 ]] || [[ ${#2} = 0 ]] || [[ ${#3} != 0 ]]; then
    echo "Syntaxis: inkleuren svg-bestand csv-bestand" 1>&2
    exit 1
fi

if [[ $1 != *.svg ]] || [[ ! -f $1 ]] || [[ ! -r $1 ]]; then
    echo "Fout: onbestaand, onleesbaar of ongeldig svg-bestand: $1" 1>&2
    echo "Syntaxis: inkleuren svg-bestand csv-bestand" 1>&2
    exit 2
fi

if [[ $2 != *.csv ]] || [[ ! -f $2 ]] || [[ ! -r $2 ]]; then
    echo "Fout: onbestaand, onleesbaar of ongeldig csv-bestand: $2" 1>&2
    echo "Syntaxis: inkleuren svg-bestand csv-bestand" 1>&2
    exit 3
fi

cp $1 temp.svg

while read line; do
    id=$(echo $line | sed 's/\(^[^,]*\),.*$/\1/')
    color=$(echo $line | sed 's/^[^,]*,\(.*\)$/\1/')
    
    sed -in "s/\(id=\"$id\"\)/\1 style=\"fill:$color;\"/" temp.svg
done < $2

originalfilename=$(echo $1 | sed 's/.svg$//')
convert svg:temp.svg png:$originalfilename.png
rm temp.svg