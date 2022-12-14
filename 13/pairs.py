#!/usr/bin/env python3
from ast import literal_eval
from itertools import zip_longest

def zipcomp(l,r):
  global ordered
  print('l:',l)
  print('r:',r)
  # print('zipping')
  print('Starting order',ordered)
  zipped=zip_longest(l,r)
  for l,r in zipped:
    print(l,r)
    if isinstance(l,list) and isinstance(r,list):
      # print('list:list',l,r)
      zipcomp(l,r)
      print('Returning order',ordered)
      return ordered
    elif isinstance(l,int) and isinstance(r,int):
      # print('int:int',l,r)
      if l > r:
        ordered=False
        print('index',i,'is out of order (l > r)')
        # raise Exception('FAIL')
        return ordered
      elif l <= r:
        ordered=True
        # print('Returning order',ordered)
        next
    elif isinstance(l,int) and isinstance(r,list):
      l=[l]
      zipcomp(l,r)
      return ordered
    elif isinstance(l,list) and isinstance(r,int):
      r=[r]
      zipcomp(l,r)
      return ordered
    else:
      # print('int/None',l,r)
      if l is None:
        ordered=True
        return ordered
      if r is None:
        print('int/None',l,r)
        ordered=False
        print('index',i,'order is',ordered,'(r = None)')
        return ordered
        break
  print('Returning order',ordered)
  return ordered
  # print(ordered)

pair=[]
i=1
sum=0
ordered_pairs=[]
ordered=True
with open("input") as f:
  for line in f:
    if line.strip():
      pair.append(line.strip())
      # print(pair)
    else:
      print('#### index:',i,'###################')
      pair=list(map(literal_eval, pair))
      left,right = pair
      # print(left,right)
      ordered=zipcomp(left,right)
      print('Returned order',ordered)
      if ordered==True:
        print('Index',i,'is ordered')
        ordered_pairs.append(i)
        sum=sum+i
      print('#################################')
      # reset and increment
      ordered=True
      pair=[]
      i=i+1
      # break

print('Ordered pairs:',ordered_pairs)
print('Sum of ordered indices:',sum)

# pairs=[list(map(ast.literal_eval, x)) for x in pairs]

# print('\n',pair)

# iterate over tuple
  # iterate over lists
    # elements can be both lists, both integers or 1 integer
