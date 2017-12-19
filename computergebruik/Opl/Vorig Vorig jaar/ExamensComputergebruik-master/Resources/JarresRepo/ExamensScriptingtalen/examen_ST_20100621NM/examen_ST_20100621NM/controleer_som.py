#!/opt/csw/bin/python

import sys

def controleer(getallen, som):
  totaal = 0
  for getal in getallen:
    totaal += int(getal)
  return totaal == int(som)

if __name__ == "__main__":
  if len(sys.argv) < 2:
    print "Geef minstens 2 getallen op."
  else:
    if controleer(sys.argv[1:-1], sys.argv[-1]):
      print "Correcte som!!"
    else:
      print "Foutieve som!!"
