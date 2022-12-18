#!/usr/bin/env python3
# Optimized Bubble sort in Python
from itertools import chain
from itertools import tee
import re
import time
start_time = time.monotonic_ns()

sensors = []
beacons = []
distance = []
# Ty = 10
# filename = 'sample'
# Dsquare = 20
Ty = 2000000
filename = 'input'
Dsquare = 4000000

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
# print(set(beacons))
num=len(sensors)

# build array of manhattan distances
for i in range(num):
  (xs,ys) = sensors[i]
  (xb,yb) = beacons[i]
  distance.append(abs(xb - xs) + abs(yb - ys))

# print('Distances:',distance)

# build list of coords within manhattan distance for each sensor

for Ty in range(Dsquare+1):
  if (Ty)%1000 == 0: print('Working on Y',Ty)
  TxRange = range(0)
  for i in range(num):  # num of sensors
  # for i in range(7):  # num of sensors
    # print('Sensor',i+1)
    M = distance[i]          # Manhattan distance for Sensor i
    (Sx,Sy)=sensors[i]       # get coords of Sensor i
    D = abs(Ty - Sy)              # distance to Target y (Ty)
    # if (i == 3 or i == 9) and Ty == 11:
    #   print('Sensor:',i+1,'M:',M,'D:',D)
    #   print('range:',range(max(Sx+D-M,0),min(Sx+M-D,Dsquare)+1))
    if M >= D:
      TxRange = chain(TxRange, range(max(Sx+D-M,0),min(Sx+M-D,Dsquare)+1))

  # find coords with y=2000000 (y=10 for sample)

  # count beacons on target Y and subtract from ranges
  beaconCount = len({b for b in beacons if b[1] == Ty})
  TxRange, TxRangeTest = tee(TxRange) # copy range to test length
  TxRangeLen = len(set(TxRangeTest))
  # print('Tlen:',TxRangeLen,'Dsq:',Dsquare)
  if TxRangeLen < Dsquare+1:
    print('x =',set(range(Dsquare+1)).difference(set(TxRange)))
    print('y =',Ty)
    # print(set(range(Dsquare+1)))
    # print(set(TxRange))
  # if (len(set(TxRange)) - beaconCount) == Dsquare: next
  # else: print(Ty)

print("--- %s microseconds ---" % ((time.monotonic_ns() - start_time)/1000))
