#!/usr/bin/env python3
# Optimized Bubble sort in Python
from itertools import chain
import shapely
import matplotlib.pyplot as plt
import re
import time
start_time = time.monotonic_ns()

sensors = []
beacons = []
distance = []
vertices = []
polygons = []
Ty = 10
filename = 'sample'
Dsquare = 20
# Ty = 2000000
# filename = 'input'
# Dsquare = 4000000

def get_cmap(n, name='hsv'):
    '''Returns a function that maps each index in 0, 1, ..., n-1 to a distinct
    RGB color; the keyword argument name must be a standard mpl colormap name.'''
    return plt.cm.get_cmap(name, n)

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

num=len(sensors)
cmap = get_cmap(num)

plt.rcParams["figure.figsize"] = [7.00, 3.50]
plt.rcParams["figure.autolayout"] = True
# build list of vertex coords
for i in range(num):
  print('Working on Sensor',i)
  (Sx,Sy) = sensors[i]
  (Bx,By) = beacons[i]
  M=(abs(Bx - Sx) + abs(By - Sy))
  distance.append(M)
  vertices.append(((Sx-M,Sy),(Sx,Sy+M),(Sx+M,Sy),(Sx,Sy-M)))
  print(vertices[i])
  polygon = shapely.Polygon(vertices[i])
  polygons.append(polygon)
  print(polygon.exterior.xy)
  x, y = polygon.exterior.xy
  plt.plot([Sx],[Sy], c=cmap(i),marker="o")
  plt.plot([Bx],[By], "g^")
  plt.grid(True,which="both")
  plt.plot(x, y, c=cmap(i))

zone = shapely.box(0, 0, Dsquare, Dsquare)
nobeacon = shapely.union_all(polygons,1)
print(shapely.difference(zone,nobeacon,1))
tuningX,tuningY = list(chain.from_iterable(shapely.get_coordinates(shapely.difference(zone,nobeacon,1).centroid).tolist()))
tuningFreq = 4000000 * tuningX + tuningY
print('Tuning Frequency:',tuningFreq)

print("--- %s microseconds ---" % ((time.monotonic_ns() - start_time)/1000))

plt.show()
