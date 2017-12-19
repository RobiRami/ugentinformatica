if [ $# -lt 2 ]; then
echo -e "$0 : atleast two regular files should be passed as an argument.\nUsage : $0 file file ... "
exit 1
fi

for file in $@
do
if [ ! -f $file ]; then
echo -e "$0 : $file is not a regular file.\n Usage: $0 file file ..."
exit 1
fi
done

for line in {0..99}
do
	a1=
	count=1
	for file in $@
	do
	a2=`dd if=$file bs=1 count=1 skip=$line 2> /dev/null`
		if [ "$a1" = "$a2" -o -z "$a1" ]; then
		a1="$a2"
		count=`expr $count + 1`
			if [ $count -eq $# ]; then
			b=`echo "$a1" | od -td1 | awk 'NR==1{print $2}'`
				if [ $b -lt 32 -o $b -eq 127 ]; then
				echo "$line: `echo $a1 | xxd -u -l1 | awk '{print $2}'`"
				else
				echo "$line : $a1"
				fi
			fi
		fi
	done
done

