#!/usr/bin/env python3
from ast import literal_eval
from itertools import zip_longest

debug=False

def zipcomp(l,r):
  global ordered,blessed
  global debug
  if debug: print('l:',l)
  if debug: print('r:',r)

  if debug: print('Starting order',ordered)
  if blessed: return ordered
  if debug: print('l,r:',l,r)
  if isinstance(l,list) and isinstance(r,list):
    if debug: print('list:list',l,r)
    if l==[] and r==[]:
      if debug: print('EMPTY')
    zipped=zip_longest(l,r)
    if debug: print('Zipped:',list(zip_longest(l,r)))
    for l,r in zipped:
      if debug: print('Comparing lists')
      zipcomp(l,r)
      if debug: print('Returning order',ordered)
    return ordered
  elif isinstance(l,int) and isinstance(r,int):
    if debug: print('int:int',l,r)
    if l > r:
      ordered=False
      blessed=True
      if debug: print('index',i,'is out of order (l > r)')
      return ordered,blessed
    elif l < r:
      ordered=True
      blessed=True
      if debug: print('Left side smaller - EXIT HERE')
      if debug: print('Returning order',ordered)
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
      if debug: print('None:None',l,r)
      next
    if l is None:
      if debug: print('None:int',l,r)
      ordered=True
      blessed=True
      if debug: print('Left side ran out, EXIT HERE returning order',ordered)
      return ordered,blessed
    if r is None:
      if debug: print('int:None',l,r)
      ordered=False
      blessed=True
      if debug: print('Right side ran out, EXIT HERE returning order',ordered)
      if debug: print('index',i,'order is',ordered,'(r = None)')
      return ordered,blessed
    next
  if debug: print('Returning order',ordered)
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
      if debug: print('#### index:',i,'###################')
      pair=list(map(literal_eval, pair))
      left,right = pair
      if debug: print(left)
      if debug: print(right)
      ordered=True
      blessed=False
      ordered=zipcomp(left,right)
      if debug: print('Returned order',ordered)
      if ordered==True:
        if debug: print('Index',i,'is ordered')
        ordered_pairs.append(i)
      else:
        if debug: print('Index',i,'is NOT ordered')
      # reset and increment
      pair=[]
      i=i+1

print('Ordered pairs:',ordered_pairs)
for i in ordered_pairs:
  suma=suma+i
print('Sum of ordered indices:',suma)
