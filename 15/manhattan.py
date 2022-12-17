#!/usr/bin/env python3
# Optimized Bubble sort in Python
from itertools import chain
import re
import time
start_time = time.monotonic_ns()

sensors = []
beacons = []
distance = []
# Ty = 10
TxRange = range(0)
# filename = 'sample'
Ty = 2000000
filename = 'input'

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
print(beacons)
num=len(sensors)

# build array of manhattan distances
for i in range(num):
  (xs,ys) = sensors[i]
  (xb,yb) = beacons[i]
  distance.append(abs(xb - xs) + abs(yb - ys))

print('Distances:',distance)

# build list of coords within manhattan distance for each sensor

for i in range(num):  # num of sensors
# for i in range(7):  # num of sensors
  print('Working on Sensor',i+1)
  M = distance[i]          # Manhattan distance for Sensor i
  (Sx,Sy)=sensors[i]       # get coords of Sensor i
  D = abs(Ty - Sy)              # distance to Target y (Ty)
  # print('M =',M)
  # print('D =',D)
  if M >= D:
    TxRange = chain(TxRange, range(Sx+D-M,Sx+M-D+1))
    # print(set(range(Sx+D-M,Sx+M-D+1)))

# find coords with y=2000000 (y=10 for sample)

# count beacons on target Y and subtract from ranges
beaconCount = len({b for b in beacons if b[1] == Ty})
# print(list(set(TxRange)))
print(len(set(TxRange)) - beaconCount)

print("--- %s microseconds ---" % ((time.monotonic_ns() - start_time)/1000))
