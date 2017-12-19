#!/bin/bash

gawk -v seconds="$2" '
!/-->/{
print $0
}

/-->/{

time_l = substr($0,0,8)
time_r = substr($0,18,8)
time_le = substr($0,9,4)
time_re = substr($0,26,4)
print processtime(time_l)""time_le" --> "processtime(time_r)""time_re
}

function processtime(time,timearray){

split(time,timearray,":")
timearray[3] += seconds
if(timearray[3] >= 60){
timearray[2] += int(timearray[3] / 60)
timearray[3] = timearray[3] % 60
}
if(timearray[2] >= 60){
timearray[1] += int(timearray[2] / 60)
timearray[2] = timearray[2] % 60
}
for(ding in timearray){
	if(timearray[ding] < 10 && substr(timearray[ding],1,1) != "0"){
		timearray[ding] = "0"timearray[ding]

}
}
return timearray[1]":"timearray[2]":"timearray[3]
}' $1

