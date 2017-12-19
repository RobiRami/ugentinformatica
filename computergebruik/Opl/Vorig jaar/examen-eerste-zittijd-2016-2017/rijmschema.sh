rijmschema=""

gedicht=$1
woorden=$2

A=""
B=""
C=""

while read line; do
    line=$(echo $line | sed 's/[-;]//g')
    
    eindwoord=$(echo $line | grep -o '[^ ]*$' | grep -o "[^.,? \"]*")
    staart=$(grep -i "^$eindwoord " $woorden | egrep -io "[^ ]*[1-2][^12]*?$" | sed 's/[012]//')
    
    if [[ $A == "" ]]; then
        A=$staart
        rijmschema=$rijmschema"A"
    else
        if [[ $A == $staart ]]; then
            rijmschema=$rijmschema"A"
        elif [[ $B == "" ]]; then
            B=$staart
            rijmschema=$rijmschema"B"
        elif [[ $B == $staart ]]; then
            rijmschema=$rijmschema"B"
        elif [[ $C == "" ]]; then
            C=$staart
            rijmschema=$rijmschema"C"
        elif [[ $C == $staart ]]; then
            rijmschema=$rijmschema"C"
        fi
    fi
    
done < $gedicht

echo $rijmschema



