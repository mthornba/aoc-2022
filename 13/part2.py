#!/usr/bin/env python3
from itertools import zip_longest
from ast import literal_eval

def zipcomp(l,r):
  global ordered,blessed

  if blessed: return ordered
  if isinstance(l,list) and isinstance(r,list):
    zipped=zip_longest(l,r)
    for l,r in zipped:
      zipcomp(l,r)
    return ordered
  elif isinstance(l,int) and isinstance(r,int):
    if l > r:
      ordered=False
      blessed=True
      return ordered,blessed
    elif l < r:
      ordered=True
      blessed=True
      return ordered,blessed
  elif isinstance(l,int) and isinstance(r,list):
    l=[l]
    zipcomp(l,r)
    return ordered
  elif isinstance(l,list) and isinstance(r,int):
    r=[r]
    zipcomp(l,r)
    return ordered
  else:
    if l is None and r is None:
      next
    if l is None:
      ordered=True
      blessed=True
      return ordered,blessed
    if r is None:
      ordered=False
      blessed=True
      return ordered,blessed
    next
  return ordered

### main ###

line=''
pair=[]
i=1
suma=0
ordered_pairs=[]
with open('sample') as f_in:
  lines = filter(None, (line.rstrip() for line in f_in))
  # for line in lines:
  #   print(line)
  line=literal_eval(next(lines,'EOF'))
  while line != 'EOF':
    left=line
    right=literal_eval(next(lines,'EOF'))
    print(left)
    print(right)
    ordered=True
    blessed=False
    ordered=zipcomp(left,right)
    print(ordered)
    if not ordered:

    line=right
