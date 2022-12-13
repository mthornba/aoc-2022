#!/usr/bin/env python3

from networkx import grid_2d_graph
from networkx import shortest_path_length

# read file and create a coordinate grid
with open("input") as f:
  grid = [list(line.strip()) for line in f]

rows=len(grid)
cols=len(grid[0])

# replace S with a & E with z
startpoint='S'
startpoint_node=[(i,row.index(startpoint)) for i, row in enumerate(grid) if startpoint in row][0]
(sx,sy)=startpoint_node
print(startpoint_node)

endpoint='E'
endpoint_node=[(i,row.index(endpoint)) for i, row in enumerate(grid) if endpoint in row][0]
(ex,ey)=endpoint_node
print(endpoint_node)

grid[sx][sy]='a'
grid[ex][ey]='z'
# print(grid)

# replace letters with numbers
grid = [[ord(c) for c in row] for row in grid]
# print(grid)

# transform grid to graph
  # https://networkx.org/documentation/stable/reference/generated/networkx.generators.lattice.grid_2d_graph.html#grid-2d-graph
  # grid_2d_graph(m, n, periodic=False, create_using=None)
  # Returns the two-dimensional grid graph.
  # empty grid graph with nodes=(rows*cols), edges=(rows*(cols-1) + cols*(rows-1))
graph=grid_2d_graph(rows,cols)
# print(graph)

# how to set edges only on connected nodes?
  # use weights instead
  # weight == difference in letters = ord(node_)
  # only use edge if diff is <= 1

# find shortest_path leading to E from S
  # weight should be a function, the weight of an edge is the value returned by the function. The function must accept exactly three positional arguments: the two endpoints of an edge and the dictionary of edge attributes for that edge. The function must return a number

def edge_weight(src,tgt,edict):
  source=grid[src[0]][src[1]]
  target=grid[tgt[0]][tgt[1]]
  if target - source > 1:
    return None
  # elif target - source = 0:
  #   return 0
  # else
  return 1

spl=shortest_path_length(graph, source=startpoint_node, target=endpoint_node, weight=edge_weight, method='dijkstra')
print(spl)
