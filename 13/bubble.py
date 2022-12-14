#!/usr/bin/env python3
# Optimized Bubble sort in Python
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

def bubbleSort(array):
  global ordered,blessed

  # iteratation count <= number of elements to be sorted
  for i in range(len(array)):

    # current element has not been swapped yet
    swapped = False

    # loop to compare array elements
    for j in range(0, len(array) - i - 1):

      # check if 2 lists are in order
      ordered=True
      blessed=False
      ordered=zipcomp(array[j],array[j+1])
      # if elements are not in order, swap them
      if ordered==False:
        temp = array[j]
        array[j] = array[j+1]
        array[j+1] = temp

        # mark that a swap occured
        swapped = True

    # the array is sorted if no swapping occurs
    if not swapped:
      break

### main ###

data=[[[2]],[[6]]]
ordered=True
blessed=False

# read file into list, 1 line at a time, filtering out blank lines
with open('input') as f_in:
  lines = filter(None, (line.rstrip() for line in f_in))
  for line in lines:
    data.append(literal_eval(line))

# sort lines
bubbleSort(data)

decoder_index_1 = data.index([[2]])+1
decoder_index_2 = data.index([[6]])+1
decoder_key = decoder_index_1 * decoder_index_2

# print('Sorted Array in Ascending Order:')
# print(data)
print('Index of [[2]]:',decoder_index_1)
print('Index of [[6]]:',decoder_index_2)
print('Decoder key:',decoder_key)
