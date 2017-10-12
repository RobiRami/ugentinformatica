#3 manieren
find . -name '*.$extension' | xargs wc -l | tr -dc '1-9\n' | tail -n 1
//OF//    find . -name '*.$extension' | xargs wc -l | tr -dc '[[:digit:]]\n' | tail -n 1
//OF//    find . -name '*.$extension' -exec cat {} ';'| wc -l 
