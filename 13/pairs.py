#!/usr/bin/env python3
import ast

# read file as a tuple of tuples of lists
with open("sample") as f:
  pairs = [line.strip() for line in f]

print(pairs)
