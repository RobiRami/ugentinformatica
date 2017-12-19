#anagramscript - Bjorn De Vogelaere
# wellicht zijn er nog enkele fouten, maar wegens tijdsgebrek maak ik liever meerdere matige scripts dan een paar perfecte

function hash(str        ,res,letters){
        str = tolower(str)
	gsub(/[^a-z]/,"",str)
	split(str,letters,"")
	sorteer(letters,length(str))	
	for(i=1; i<=length(str); i++){
		res = res letters[i]
	}
	return res
}

function sorteer(array, aantal,     temp, i, j) {
  for (i=2; i<=aantal; ++i) {
    for (j=i; (j-1) in array && array[j-1] > array[j]; --j) {
      temp = array[j]
      array[j] = array[j-1]
      array[j-1] = temp
    }
  }
  return
}


{
	woorden++
	temph = hash($0)
	if( temph in hashes){
		hashes[temph] = hashes[temph]", "$0

		#voorlopige methode om aantal woorden bij te houden
		aantal[temph]++
		if(length($0)>maxletters){
        	        lwoord=hashes[temph]
                	maxletters=length($0)
	        }
        	else if(length($0)==maxletters){
                	lwoord=lwoord", "$0
        	}
	}
	else{
		aantal[temph] = 1
		hashes[temph] = $0
	}
}

# algemene statistieken
END{
OFS=": "
i=1
for( h in hashes){	
	if(index(hashes[h],",")>0){
		printf("%5s %s\n",i":",hashes[h])
		i++
		if(aantal[h]>max){
			mwoorden=hashes[h]
			max=aantal[h]
		}
	}
	else{
		woorden--
	}
}
print "#anagrammen",i
print "#woorden",woorden
print "langste woord",lwoord
print "meeste woorden",mwoorden
}
