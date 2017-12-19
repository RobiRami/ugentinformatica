#!/bin/bash
if [ $# -eq 2 ]; then
if [ ! -d $1 -o ! -d $2 ]; then
echo "Gebruik: diffdir DIRECTORY DIRECTORY" >2
exit 1
fi
else
echo "Gebruik: diffdir DIRECTORY DIRECTORY" >2
exit 1
fi
count=0
for verwijderd in $(comm -23 <(find $1 -type f -exec shasum '{}' \; | cut -d" " -f1| sort ) <(find $2 -type f -exec shasum '{}' \;| cut -d" " -f1 | sort))
do
if [ $count = 0 ]; then
echo "verwijderde bestanden:"
count=1
fi
find $1 -type f -exec shasum '{}' \; | egrep "$verwijderd" | sed -r 's/^[A-z1-9]*\s*[^/]*\/(.*)$/\1/'
done
count=0
for toegevoegd in $(comm -13 <(find $1 -type f -exec shasum '{}' \; | cut -d" " -f1| sort ) <(find $2 -type f -exec shasum '{}' \;| cut -d" " -f1 | sort))
do
if [ $count = 0 ]; then
echo "toegevoegde bestanden:"
count=1
fi
find $2 -type f -exec shasum '{}' \; | egrep "$toegevoegd" | sed -r 's/^[A-z1-9]*\s*[^/]*\/(.*)$/\1/'
done
count=0
for file1 in $(find $1 -type f)
do
shasum1=`shasum $file1`
sha1=`echo $shasum1 | cut -d' ' -f1`
	for file2 in $(find $2 -type f)
	do
	shasum2=`shasum $file2`
	sha2=`echo $shasum2 | cut -d' ' -f1`
	if [ "$sha1" =  "$sha2" ]; then
		filename1=`echo $shasum1 | cut -d" " -f2 | sed 's/^[^/]*\///'`
		filename2=`echo $shasum2 | cut -d" " -f2 | sed 's/^[^/]*\///'`
		if [ "$filename1" != "$filename2" ]
		then
			if [ $count = 0 ]; then
			echo "verplaatste bestanden"
			count=1
			fi
		echo "$filename1 > $filename2"
		fi
	fi
	done
done
