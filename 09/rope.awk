#!/usr/bin/env awk -f

function abs(v) { return v < 0 ? -v : v }

function move_next(h,t){
  movex=0; movey=0
  hx=coords[h]["x"]
  hy=coords[h]["y"]
  tx=coords[t]["x"]
  ty=coords[t]["y"]
  diffx=hx-tx
  diffy=hy-ty

  # sum of squares to check distance between knots
  sumsq=diffx^2 + diffy^2
  if(sumsq > 2){
    if(diffx==0)movex=0
    else{movex=diffx/abs(diffx)}
    if(diffy==0)movey=0
    else{movey=diffy/abs(diffy)}
  }
  tx=tx+movex
  ty=ty+movey

  visits[t][tx","ty]="X"
  coords[t]["x"]=tx
  coords[t]["y"]=ty
  if(hx>x_max)x_max=hx
  if(hx<x_min)x_min=hx
  if(hy>y_max)y_max=hy
  if(hy<y_min)y_min=hy
}

# print path followed by given knot
function print_path(knot){
  for(fy=y_max;fy>=y_min;fy--){
    for(fx=x_min;fx<=x_max;fx++){
      if(visits[knot][fx","fy] == "X")printf knot
      else{
        printf "."
        delete visits[knot][fx","fy]
      }
    }
    printf "\n"
  }
}

# print current position of rope for debugging
function print_rope(){
  for(fy=y_max;fy>=y_min;fy--){
    for(fx=x_min;fx<=x_max;fx++){
      char="."
      for(knot=num_knots-1;knot>=0;knot--){
        if((coords[knot]["x"] == fx) && (coords[knot]["y"] == fy)){
          char=knot
        }
      }
    printf char
    }
    printf "\n"
  }
}

BEGIN{
  num_knots=10
  # All knots start at 0,0
  x=0; y=0
  x_min=0; y_min=0
  x_max=0; y_max=0
  for(i=0;i<num_knots;i++){
    visits[i][x","y]="X"
    coords[i]["x"]=x
    coords[i]["y"]=y
  }
}
{
  dir=$1
  count=$2
  for(i=0;i<count;i++){
    if(dir == "R")x++;
    else if(dir == "L")x--;
    else if(dir == "U")y++;
    else if(dir == "D")y--;
    knot=0 # save visit & coords of Head
    visits[knot][x","y]="X"
    coords[knot]["x"]=x
    coords[knot]["y"]=y
    # calculate position of next knot
    for(j=0;j<num_knots-1;j++){
      # move_next(head, tail)
      move_next(j,j+1)
    }
    # uncomment to print rope position after each move of head
    # print_rope()
    # printf "\n"
  }
}
END{
  for(i=0;i<num_knots;i++){
    # uncomment to print path taken by each knot
    # print_path(i)
    printf "Knot %d visited %d spaces.\n\n",i,length(visits[i])
  }
}
