#!/usr/bin/env python3
import ast

# read file as a tuple of tuples of lists

pairs=[[]]
i=0
with open("sample") as f:
  for line in f:
    if line.strip():
      pairs[i].append(line.strip())
    else:
      pairs.append([])
      i=i+1

print(pairs,'\n')

pairs=tuple(tuple(map(ast.literal_eval, x)) for x in pairs)
# pairs=[list(map(ast.literal_eval, x)) for x in pairs]

# iterate over tuple
  # iterate over lists
    # elements can be both lists, both integers or 1 integer


def zipcomp(l,r):
  print(l,r)
  zipped=zip(l,r)
  # print(list(zipped))
  for a,b in zipped:
    print(a,b)
    if isinstance(a,int) and isinstance(b,int):
      # print('both integers')
      if a <= b:
        ordered=True
      else:
        ordered=False
        print('out of order')
        return
  #   elif isinstance(a,list) and isinstance(b,list):
  #     print('both lists')
  #   else:
  #     print('one integer')
  # print(ordered)

# ordered=False
for left,right in pairs:
  if isinstance(left,list) and isinstance(right,list):
    zipcomp(left,right)
    # print(ordered)
    break
