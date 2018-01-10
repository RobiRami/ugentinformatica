veranderLetter(){
     echo $1 | tr 'A-Za-z' 'B-ZAb-za'
}

rijmschema=""

gedicht=$1
woorden=$2

staartlijst=""

while read line; do

    line=$(echo $line | sed 's/[-;]//g' | sed '/^\s*$/d')

if [[ -z $line ]]
then
continue;
fi
    
    eindwoord=$(echo $line | grep -o '[^ ]*$' | grep -o "[^.,? \";:]*")
    staart=$(grep -i "^$eindwoord " $woorden | egrep -io "[^ ]*[1-2][^12]*?$" | sed 's/[012]//')
    
    if [[ $staartlijst == "" ]]; then
        staartlijst="$staart@A;"
        rijmschema="A"
    else
    
    grep "$staart@" <<< $staartlijst 2> /dev/null 1>&2
    
    if [[ $? -eq 0 ]]
    then
        rijmschema+=$(grep -o "$staart@[^@;];" <<< $staartlijst | sed -e "s/$staart@//g" -e 's/;//g')
    else
        l=$(veranderLetter $(grep -o "@[^@;];$" <<< $staartlijst | sed -e 's/;//g' -e 's/@//g'))
        staartlijst+="$staart@$l;"
        rijmschema+="$l"
    fi
    fi
    
done < $gedicht

echo $rijmschema
