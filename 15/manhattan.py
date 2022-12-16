#!/usr/bin/env python3
# Optimized Bubble sort in Python
from itertools import zip_longest
import re

sensors = []
beacons = []
distance = []

with open('sample') as f:
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

print(sensors)
print(beacons)
num=len(sensors)

# build array of manhattan distances
for i in range(num):
  (xs,ys) = sensors[i]
  (xb,yb) = beacons[i]
  distance.append(abs(xb - xs) + abs(yb - ys))

print(distance)

# build list of coords within manhattan distance for each sensor

nobeacon=[set()]
for i in range(num):  # num of sensors
  M=distance[i]
  (x,y)=sensors[i]
  for j in range(M): # 0..M
    # print(i)
    nobeacon.append(set())
    for k in range(M): # 0..M
      # print(i,':',nobeacon[i])
      # print(type(nobeacon[i]))
      (nobeacon[i]).add((x+j,y+k-j))
      # nobeacon[i].add((x-j,y-k-j))

# add maps together to show all locations where there can't be a beacon

# print(nobeacon)

# clear coords that currently have beacons


# find coords with y=2000000
