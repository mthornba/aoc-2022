#!/usr/bin/env python3
# Optimized Bubble sort in Python
from itertools import zip_longest
import re
import time
start_time = time.monotonic_ns()

sensors = []
beacons = []
distance = []
Ty = 10
filename = 'sample'
# Ty = 2000000
# filename = 'input'

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

nobeacon=[set()]
nobeacon_sum=set()

for i in range(num):  # num of sensors
# for i in range(7):  # num of sensors
  print('Working on Sensor',i+1)
  M = distance[i]          # Manhattan distance for Sensor i
  nobeacon.append(set())   # add an empty set to nobeacon list (at index i)
  (Sx,Sy)=sensors[i]       # get coords of Sensor i
  D = Ty - Sy              # distance to Target y (Ty)
  R = M - abs(D)           # if M>=D then set(points within M) intesects Ty
  # print('M =',M)
  # print('D =',D)
  # print('R =',R)
  if R >= 0:
    for j in range(R+1):       # add coords for M intersect Ty
      # print('Sx =',Sx,'R =',j)
      # print('Sx - R =',Sx - j)
      # print('Sx + R =',Sx + j)
      # print((Sx-j,Ty))
      # print((Sx+j,Ty))
      (nobeacon[i]).add((Sx-j,Ty))
      (nobeacon[i]).add((Sx+j,Ty))
    # add sets together to show all locations where y=Ty and there can't be a beacon
    nobeacon_sum = nobeacon_sum.union(nobeacon[i])

print('Finished M intersect Ty')

# clear coords that currently have beacons
nobeacon_sum.difference_update(set(beacons))
print('Finished sum_difference')

# find coords with y=2000000 (y=10 for sample)
print(len(nobeacon_sum))

# count = 0
# xcoords=[]
# for x,y in nobeacon_sum:
#   if y==Ty:
#     xcoords.append(x)
#     xcoords.sort()
#     count=count+1

# print('xcoords in row',Ty,':',xcoords)
# print(count)

print("--- %s microseconds ---" % ((time.monotonic_ns() - start_time)/1000))
