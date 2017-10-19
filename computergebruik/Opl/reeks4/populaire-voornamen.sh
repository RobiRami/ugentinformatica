find -type f -name *_WE.txt -exec cat {} ";"| grep "^00016"| cut -f3 -d \;|sort -r |uniq --count | sort -k1rn -k2 |head -n 5
