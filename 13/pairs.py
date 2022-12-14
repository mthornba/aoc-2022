#!/usr/bin/env python3
from ast import literal_eval
from itertools import zip_longest

def zipcomp(l,r):
  print('zipping')
  if isinstance(l,list) and isinstance(r,list):
    print('list:list',l,r)
    zipped=zip_longest(l,r)
    pzipped=list(zipped)
    print(pzipped)
    for l,r in zipped:
      if isinstance(l,list) and isinstance(r,list):
        print('list:list',l,r)
        zipcomp(l,r)
      elif isinstance(l,int) and isinstance(r,int):
        # print('int:int',l,r)
        if l > r:
          ordered=False
          print('index',i,'is out of order')
          return
        else:
          ordered=True
      elif isinstance(l,int) and isinstance(r,list):
        l=[l]
        zipcomp(l,r)
      elif isinstance(l,list) and isinstance(r,int):
        r=[r]
        zipcomp(l,r)
      else:
        print('one integer')
    # print(ordered)

pair=[]
i=1
with open("sample") as f:
  for line in f:
    if line.strip():
      pair.append(line.strip())
      # print(pair)
    else:
      pair=list(map(literal_eval, pair))
      print('\nindex:',i,pair)
      # pairs.append([])
      # ordered=False
      left,right = pair
      # print(left,right)
      zipcomp(left,right)
      pair=[]
      i=i+1
      # break


# pairs=[list(map(ast.literal_eval, x)) for x in pairs]

# print('\n',pair)

# iterate over tuple
  # iterate over lists
    # elements can be both lists, both integers or 1 integer
