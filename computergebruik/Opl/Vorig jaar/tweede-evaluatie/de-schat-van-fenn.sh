stopwoord=$1
directory=$2
file=$3
linenumber=$4

word=""
zin=""

cd $directory

while [[ $word != $stopwoord ]]; do
    zin=$zin' '$word
    line=$(head -$linenumber $file | tail -1)

    word=$(echo $line | egrep -o '^[^ ]*')
    file=$(echo $line | egrep -o '\s[^ ]*\s')
    linenumber=$(echo $line | egrep -o '[^ ]*$')
done

echo $zin