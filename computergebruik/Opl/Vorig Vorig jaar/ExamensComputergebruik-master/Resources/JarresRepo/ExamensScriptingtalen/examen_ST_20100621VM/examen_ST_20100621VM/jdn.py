#!/opt/csw/bin/python

def jdn(dag,maand,jaar):

  a = (14-maand)//12
  y = jaar + 4800 - a
  m = maand + 12*a - 3
  return dag + (153*m+2)//5 + y*365 + y//4 - y//100 + y//400 - 32045

if __name__ == "__main__":
  import sys
  if len(sys.argv) == 1:
    import datetime
    d = datetime.date.today()
    print jdn(d.day,d.month,d.year)
  elif len(sys.argv) == 2:
    d = sys.argv[1].split("-")
    if len(d)<>3: d = sys.argv[1].split("/")
    if len(d)==3: print jdn(int(d[0]),int(d[1]),int(d[2]))
