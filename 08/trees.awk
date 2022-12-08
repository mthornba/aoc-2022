#!/usr/bin/env awk -f

# i rows (records), j cols (fields)
BEGIN{
  FS=""
}
{
  i=NR
  for(j=1; j<=NF; j++){
    coord=i "," j
    heights[coord]=$j
  }
}
END{
  rows=i; cols=j-1
  print "Rows: "rows, "Cols: "cols
  for(row=1; row<=i; row++){
    for(col=1; col<=j-1; col++){
      this_height=heights[row "," col]
      visible[row "," col]=0
      # look left
      for(x=0; x<col; x++){
        if(this_height > heights[row "," x]){
          # print this_height,">",heights[row "," x]
          visible[row "," col]=1
        }
        else{
          visible[row "," col]=0
          break
        }
      }
      # look right
      for(x=cols; x>col; x--){
        if(this_height > heights[row "," x]){
          visible[row "," col]=1
        }
        else{
          visible[row "," col]=0
          break
        }
      }
      # look up
      for(y=0; y<row; y++){
        if(this_height > heights[y "," col]){
          # print this_height,">",heights[row "," x]
          visible[row "," col]=1
        }
        else{
          visible[row "," col]=0
          break
        }
      }
      # look down
      for(y=cols; y>col; y--){
        if(this_height > heights[y "," col]){
          visible[row "," col]=1
        }
        else{
          visible[row "," col]=0
          break
        }
      }
      # print "row="row, "col="col, "height="this_height, visible[row "," col]
      printf visible[row "," col]
    }
    print ""
  }
}
