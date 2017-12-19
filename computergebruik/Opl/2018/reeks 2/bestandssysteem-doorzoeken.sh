### command 1 ###

find \! -newer participants.txt

### command 2 ###

find files/* -type f -size 0 -delete

### command 3 ###

find * -type f -size +10k | xargs  gzip

### command 4 ###

find -maxdepth 2 -name "*" -type d

### command 5 ###
find /etc -perm /a+x \( -name "*[[:digit:]]" -o -name "[[:digit:]]*" \) -print 2> /dev/null



