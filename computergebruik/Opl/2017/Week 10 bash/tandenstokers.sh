prevChar="|"
uitdrukking=""
totaal="0"
buffer="0"
buffer2="0"
multiplication="false"
operator="+"
usedMatches="0"

args=("$@")
for ((i=0; i<=$#; i++)); do
  argument+=${args[$i]}
done

for ((i=0; i<${#argument}; i++)); do
  if [ ! -z ${argument:$i:1} ]; then
    if [ ${argument:$i:1} = $prevChar ]; then
      uitdrukking+=$prevChar
    else
      prevChar=${argument:$i:1}
      uitdrukking+=" "
      uitdrukking+=$prevChar
    fi
  else
    continue
  fi
  
  if [ ${argument:$i:1} = "|" ]; then
    if [ $multiplication = "true" ]; then
      buffer2=$((buffer2+1))
    else
      buffer=$(($buffer+1))
    fi
    
    usedMatches=$(($usedMatches+1))
    
    if [ $i = $((${#argument} - 1)) ]; then
      if [ $multiplication = "true" ]; then
        buffer=$(($buffer*$buffer2))
      fi
      
      totaal=$(($totaal+$buffer))
    fi
  else
    usedMatches=$(($usedMatches+2))
    operator=${argument:$i:1}
    if [ $operator = "+" ]; then
      if [ $multiplication = "true" ]; then
        buffer=$(($buffer*$buffer2))
        buffer2="0"
        multiplication="false"
      fi
      
      totaal=$(($totaal+$buffer))
      buffer="0"
    else
      if [ $multiplication = "true" ]; then
        buffer=$(($buffer*$buffer2))
        buffer2="0"
      else
        multiplication="true"
      fi
    fi
  fi
done

echo "$uitdrukking = $totaal ($usedMatches tandenstokers)"