#!/usr/bin/env python3
import ast
import itertools
from itertools import groupby

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
