#!/opt/csw/bin/python

def maanfase(dag,maand,jaar):

  from jdn import jdn

  p  = 29.530588853
  dr = jdn(dag,maand,jaar) - jdn(6,1,2000)
  dn = dr % p

  if dn < p/4:
    return "@"
  elif dn < p/2:
    return ")"
  elif dn < 3*p/4:
    return "O"
  else:
    return "("

if __name__ == "__main__":
  import sys
  if len(sys.argv) == 1:
    import datetime
    d = datetime.date.today()
    print maanfase(d.day,d.month,d.year)
  elif len(sys.argv) == 2:
    d = sys.argv[1].split("-")
    if len(d)<>3: d = sys.argv[1].split("/") 
    if len(d)==3: print maanfase(int(d[0]),int(d[1]),int(d[2]))
