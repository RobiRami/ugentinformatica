if [ $# -ne 1 ]; then
echo "Syntax: $0: file1.fasta"
exit 1
fi
if [ ! -r $1 ]; then
echo "$1 is not readable"
exit 1
fi
acc=`cat $1 | head -1 |  cut -d"|" -f2 | tr -d " "`
mv "$1" "$acc.fasta"
