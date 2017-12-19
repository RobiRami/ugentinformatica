E="false"
G="false"
O="false"
T="false"

numberofflags=0
header="NAAM ACTEUR"
subheader='___________'

while getopts ":EGOT" opt; do
    case $opt in
        E )
            E="true"
            numberofflags=$(($numberofflags+1))
            ;;
        G )
            G="true"
            numberofflags=$(($numberofflags+1))
            ;;
        O )
            O="true"
            numberofflags=$(($numberofflags+1))
            ;;
        T )
            T="true"
            numberofflags=$(($numberofflags+1))
            ;;
        \? )
            echo "Syntaxis: uitslover -EGOT" 1>&2
            exit 1
    esac
done
shift $((OPTIND - 1))

if [[ $numberofflags -lt 2 ]]; then
    echo "uitslover: minder dan twee awards opgegeven" 1>&2
    exit 2
fi

if [[ $E == "true" ]]; then
    header=$header"\tEMMY"
    subheader=$subheader"\t____"
fi

if [[ $G == "true" ]]; then
    header=$header"\tGRAMMY"
    subheader=$subheader"\t_____"
fi

if [[ $O == "true" ]]; then
    header=$header"\tOSCAR"
    subheader=$subheader"\t_____"
fi

if [[ $T == "true" ]]; then
    header=$header"\tTONY"
    subheader=$subheader"\t____"
fi

echo -e $header
echo -e $subheader

if [[ $E == "true" ]]; then
    cp emmy.txt temp1.txt
    cut -f 2 temp1.txt | sort
fi

if [[ $G == "true" ]]; then
    if [[ ! -f temp1.txt ]]; then
        cp grammy temp1.txt
    else
        join temp1.txt grammy.txt > temp2.txt
    fi
fi

cat temp2.txt