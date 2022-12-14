#!/usr/bin/env python3
from ast import literal_eval
from itertools import zip_longest


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

pair=[]
i=1
suma=0
ordered_pairs=[]
with open("input") as f:
  for line in f:
    if line.strip():
      pair.append(line.strip())
    else:
      pair=list(map(literal_eval, pair))
      left,right = pair
      ordered=True
      blessed=False
      ordered=zipcomp(left,right)
      if ordered==True:
        ordered_pairs.append(i)
      # reset and increment
      pair=[]
      i=i+1

print('Ordered pairs:',ordered_pairs)
for i in ordered_pairs:
  suma=suma+i
print('Sum of ordered indices:',suma)
