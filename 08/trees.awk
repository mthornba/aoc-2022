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
  # for(row=4; row<=4; row++){
  #   for(col=4; col<=4; col++){
      this_height=heights[row "," col]
      visible[row "," col]=0

      # look from left
      for(x=0; x<col; x++){
        # printf heights[row "," x]
        if(this_height > heights[row "," x]){
          # print this_height,">",heights[row "," x]
          # print "left"
          visible[row "," col]=1
        }
        else{
          visible[row "," col]=0
          break
        }
      }
      # print ""

      # look to left
      for(x=col-1; x>=1; x--){
        mult_l[row","col]=mult_l[row","col]+1
        if(this_height <= heights[row "," x])break
      }

      if(visible[row "," col]==0){
        # look from right
        for(x=cols; x>col; x--){
          # printf heights[row "," x]
          if(this_height > heights[row "," x]){
            # print "right"
            visible[row "," col]=1
          }
          else{
            visible[row "," col]=0
            break
          }
        }
      }
      # print ""

      # look to right
      for(x=col+1; x<=cols; x++){
        mult_r[row","col]=mult_r[row","col]+1
        if(this_height <= heights[row "," x])break
      }

      if(visible[row "," col]==0){
        # look from up
        for(y=0; y<row; y++){
          # printf heights[y "," col]
          if(this_height > heights[y "," col]){
            # print "up"
            visible[row "," col]=1
          }
          else{
            visible[row "," col]=0
            break
          }
        }
      }
      # print ""

      # look towards up
      for(y=row-1; y>=1; y--){
        mult_t[row","col]=mult_t[row","col]+1
        if(this_height <= heights[y "," col])break
      }

      if(visible[row "," col]==0){
        # look from down
        for(y=rows; y>row; y--){
          # print "row:",row,"col:",col
          # printf heights[y "," col]
          if(this_height > heights[y "," col]){
            # print "down"
            visible[row "," col]=1
          }
          else{
            visible[row "," col]=0
            break
          }
        }
      }
      # print ""

      # look towards down
      for(y=row+1; y<=rows; y++){
        mult_d[row","col]=mult_d[row","col]+1
        # print "mult=",mult_d[row","col]
        if(this_height <= heights[y "," col])break
      }

      if(row==1 || row==rows || col==1 || col==cols)visible[row "," col]=1
      total=total+visible[row "," col]
      mult[row","col]=mult_l[row","col] * mult_r[row","col] * mult_t[row","col] * mult_d[row","col]
      # print "row="row, "col="col, "height="this_height, visible[row "," col]
      # printf visible[row "," col]
      # printf mult[row","col]
      if(mult[row","col] > highest)highest=mult[row","col]
    }
    # print ""
  }
  print "Trees visible from outside:",total
  print "Highest scenic score:",highest
}
