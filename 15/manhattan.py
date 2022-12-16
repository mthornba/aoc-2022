#!/usr/bin/env python3
# Optimized Bubble sort in Python
from itertools import zip_longest
import re

sensors = []
beacons = []
distance = []
target_y = 10
filename = 'sample'

with open(filename) as f:
  lines = filter(None, (line.rstrip() for line in f))
  for line in lines:
    coords = [line.split(':')]
    # print(coords)
    for s,b in coords:
      # extract x,y and convert to int for sensors
      match = re.search(r"[^x]+x=(-?\d+),\s*y=(-?\d+)", s)
      sensors.append((int(match.group(1)),int(match.group(2))))
      # extract x,y and convert to int for sensors
      match = re.search(r"[^x]+x=(-?\d+),\s*y=(-?\d+)", b)
      beacons.append((int(match.group(1)),int(match.group(2))))

# print(sensors)
# print(beacons)
num=len(sensors)

# build array of manhattan distances
for i in range(num):
  (xs,ys) = sensors[i]
  (xb,yb) = beacons[i]
  distance.append(abs(xb - xs) + abs(yb - ys))

print('Distances:',distance)

# build list of coords within manhattan distance for each sensor

nobeacon=[set()]
nobeacon_sum=set()

for i in range(num):  # num of sensors
  M=distance[i]
  nobeacon.append(set())
  (x,y)=sensors[i]
  for j in range(M+1): # 0..M+1
    # print(i)
    for k in range(M+1): # 0..M+1
      # print(i,':',nobeacon[i])
      # print(type(nobeacon[i]))
      (nobeacon[i]).add((x+j,y+k-j))
      (nobeacon[i]).add((x-j,y-k-j))
  # add sets together to show all locations where there can't be a beacon
  nobeacon_sum = nobeacon_sum.union(nobeacon[i])

# print(nobeacon_sum)

# clear coords that currently have beacons
#   not required since they won't be counted in part 1

# find coords with y=2000000 (y=10 for sample)

count = 0
xcoords=[]
for x,y in nobeacon_sum:
  if y==target_y:
    xcoords.append(x)
    xcoords.sort()
    count=count+1

print('coords in row',target_y,':',xcoords)
print(count)
