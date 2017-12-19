getal=$1
totaal=0
add=false

for ((i=0; i<=$getal; i++))
do
    wholeNumber=$i
    for ((j=${#i}; j>0; j--))
    do
        nextNumber=$(($wholeNumber/(10**($j-1))))
        if [ $add = false ]; then
            totaal=$(($totaal-$nextNumber))
            add=true
        else
            totaal=$(($totaal+$nextNumber))
            add=false
        fi
        wholeNumber=$(($wholeNumber-(nextNumber*(10**($j-1)))))
    done
done

echo $totaal
exit 0