#!/usr/bin/env awk -f

function abs(v) { return v < 0 ? -v : v }
function sgn(v) { return v < 0 ? -1 : v > 0 }

function move_next(h,t){
  # print "head:"h,"tail:"t
  movex=0; movey=0
  hx=coords[h]["x"]
  hy=coords[h]["y"]
  tx=coords[t]["x"]
  ty=coords[t]["y"]
  diffx=hx-tx
  diffy=hy-ty
  if(debug==1){
    print "head_start: "hx","hy
    print "tail_start: "tx","ty
    # print "movex: "movex
    # print "movey: "movey
    print "diff: "diffx","diffy
  }

  sumsq=diffx^2 + diffy^2
  if(sumsq > 2){
    if(diffx==0)movex=0
    else{movex=diffx/abs(diffx)}
    if(diffy==0)movey=0
    else{movey=diffy/abs(diffy)}
  }
  else{
    diffx=0
    diffy=0
  }
  tx=tx+movex
  ty=ty+movey

  if(debug==1){
    print "movex: "movex
    print "movey: "movey
    print "tail_end: "tx","ty
    print ""
  }
  visits[t][tx","ty]="X"
  coords[t]["x"]=tx
  coords[t]["y"]=ty
  if(hx>x_max)x_max=hx
  if(hx<x_min)x_min=hx
  if(hy>y_max)y_max=hy
  if(hy<y_min)y_min=hy
  # print "tail_end: "tx","ty
  # print ""
  return t tx ty
}

function print_path(knot){
  # print "x_min=" x_min,"x_max=" x_max,"y_min=" y_min,"y_max=" y_max
  for(fy=y_max;fy>=y_min;fy--){
    for(fx=x_min;fx<=x_max;fx++){
      if(visits[knot][fx","fy] == "X")printf knot
      else{
        printf "."
        delete visits[knot][fx","fy]
      }
    }
    print ""
  }
}

function print_rope(){
  # print "x_min=" x_min,"x_max=" x_max,"y_min=" y_min,"y_max=" y_max

  # for(knot=num_knots-1;knot>=0;knot--){
  #   print "knot:",knot,coords[knot]["x"]","coords[knot]["y"]
  # }

  for(fy=y_max;fy>=y_min;fy--){
    for(fx=x_min;fx<=x_max;fx++){
  # printf "fx=%s fy=%s", fx, fy
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
  # Head starts at 0,0
  x=0; y=0
  x_min=0; y_min=0
  x_max=5; y_max=4
  steps=0
  debug=0
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
      steps++
      # if((45<=steps) && (steps<=55)){debug=1}
      # else{debug=0}
      if(debug==1){
        printf "Step: %s\n",steps
        # if(j)printf "Head: %s,%s\n",coords[j]["x"],coords[j]["y"]
        # if(j)printf "Tail: %s,%s\n",coords[j+1]["x"],coords[j+1]["y"]
        print_rope()
        printf "\n"
      }
      # move_next(head, tail)
      move_next(j,j+1)
      # visits[j+1][tx","ty]="X"
      # coords[j+1]["x"]=tx
      # coords[j+1]["y"]=ty
      # print "tail_end:",coords[j+1]["x"] "," coords[j+1]["y"]
    }
  }
}
END{
  for(i=9;i<num_knots;i++){
    print_path(i)
    print length(visits[i])
  }
}
