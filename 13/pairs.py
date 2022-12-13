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

print(pairs)

pairs=tuple(tuple(map(ast.literal_eval, x)) for x in pairs)

for pair in pairs:
  print(pair)

# iterate over tuple
  # iterate over elements of both lists, comparing them
