#!/usr/bin/env python3
# Optimized Bubble sort in Python
from itertools import zip_longest
import re

sensors = []
beacons = []
distance = []
Ty = 10
filename = 'sample'
# Ty = 2000000
# filename = 'input'

# Generate set of target square coords
# (x,y) = (0,0) => (20,20)
Tsquare = set()
Dsquare = 20
for x in range(Dsquare):
  for y in range(Dsquare):
    Tsquare.add((x,y))
print(len(Tsquare))

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

# limit value n to be within distance M
def M_limit(n, M):
  return max(min(M, n), -M)

for i in range(num):  # num of sensors
# for i in range(1,2):  # num of sensors
  print('\nWorking on Sensor',i+1)
  M = distance[i]          # Manhattan distance for Sensor i
  (Sx,Sy)=sensors[i]       # get coords of Sensor i
  nobeacon.append(set())   # add an empty set to nobeacon list (at index i)
  nobeacon[i].add((Sx,Sy)) # add Sensor i coord to nobeacon list (at index i)
  D = Ty - Sy              # distance to Target y (Ty)
  R = M - abs(D)           # if M>=D then set(points within M) intesects Ty
  # print('M =',M)
  # print('D =',D)
  # print('R =',R)
  # if R >= 0:
  xRangeMin = M_limit(-Sx,M)
  xRangeMax = M_limit(Dsquare-Sx,M)
  # print('xRangeMin =',xRangeMin)
  # print('xRangeMax =',xRangeMax)
  for j in range(xRangeMin,xRangeMax+1):    # add coords for M intersect Ty
    yRangeMin = max(M_limit(-Sy,M),abs(j)-M)
    yRangeMax = min(M_limit(Dsquare-Sy,M),M-abs(j))
    # print('yRangeMin =',yRangeMin)
    # print('yRangeMax =',yRangeMax)
    for k in range(yRangeMin,yRangeMax+1):
      # Syd = M - j
      # print('Sx =',Sx,'j =',j)
      # print('Sy =',Sy,'k =',k)
      # print('Sx - R =',Sx - j)
      # print('Sx + R =',Sx + j)
      # print((Sx-j,Ty))
      # print((Sx+j,Ty))
      # print('Adding...',(Sx+j,Sy+k),(Sx+j,Sy-k),(Sx-j,Sy+k),(Sx-j,Sy-k))
      (nobeacon[i]).add((Sx+j,Sy+k))
      # intersect with target square
      Tsquare.difference_update(nobeacon[i])
  # add sets together to show all locations where there can't be a beacon
  # nobeacon_sum = nobeacon_sum.union(nobeacon[i])
  # calculate Manhattan Area to verify length of nobeacon
  Am = 1
  for n in range(M+1):
    Am = Am + 4*n

  # print('nobeacon:',nobeacon[i])
  print('length nobeacon = ',len(nobeacon[i]))
  print('M =',M,'Am = ',Am)
  print('Possible beacon locations:',len(Tsquare))
  # print('Possible beacon locations:',Tsquare)

(x,y)=Tsquare.pop()
tuning_signal = 4000000 * x + y
print('Beacon is at',(x,y))
print('Tuning signal is',tuning_signal)
# print('Finished M intersect Ty')

# clear coords that currently have beacons
# nobeacon_sum.difference_update(set(beacons))
# print('Finished sum_difference')

# find coords with y=2000000 (y=10 for sample)
# print(len(nobeacon_sum))

# count = 0
# xcoords=[]
# for x,y in nobeacon_sum:
#   if y==Ty:
#     xcoords.append(x)
#     xcoords.sort()
#     count=count+1

# print('xcoords in row',Ty,':',xcoords)
# print(count)

# Part 2:
#   - find where there could be a beacon
#   - must be between x,y=0 and x,y=20 (x,y=4000000)
#   - how to limit range to this square?
#   - for each y, is there a free beacon spot?
#   - no need to clear existing beacons this time
#   - just need to find an empty spot

#   - create a set of locations covered by M for each beacon
#   - create a set covering coords of square range
#   - union the sets to get total area covered by all M's
#   - difference_update range with unioned M's
#   - should be 1 coord left in range set
