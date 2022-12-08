#!/usr/bin/env awk -f

BEGIN{ FS="" }
{
  # i rows (records), j cols (fields)
  i=NR
  for(j=1; j<=NF; j++){
    heights[i","j]=$j
  }
}
END{
  rows=i; cols=j-1
  print "Rows: "rows, "Cols: "cols
  for(row=1; row<=i; row++){
    for(col=1; col<=j-1; col++){
      this_height=heights[row "," col]
      visible[row "," col]=0

      # look from left
      for(x=0; x<col; x++){
        if(this_height > heights[row "," x]){
          visible[row "," col]=1
        }
        else{
          visible[row "," col]=0
          break
        }
      }

      # look to left
      for(x=col-1; x>=1; x--){
        mult_l[row","col]=mult_l[row","col]+1
        if(this_height <= heights[row "," x])break
      }

      if(visible[row "," col]==0){
        # look from right
        for(x=cols; x>col; x--){
          if(this_height > heights[row "," x]){
            visible[row "," col]=1
          }
          else{
            visible[row "," col]=0
            break
          }
        }
      }

      # look to right
      for(x=col+1; x<=cols; x++){
        mult_r[row","col]=mult_r[row","col]+1
        if(this_height <= heights[row "," x])break
      }

      if(visible[row "," col]==0){
        # look from up
        for(y=0; y<row; y++){
          if(this_height > heights[y "," col]){
            visible[row "," col]=1
          }
          else{
            visible[row "," col]=0
            break
          }
        }
      }

      # look towards up
      for(y=row-1; y>=1; y--){
        mult_t[row","col]=mult_t[row","col]+1
        if(this_height <= heights[y "," col])break
      }

      if(visible[row "," col]==0){
        # look from down
        for(y=rows; y>row; y--){
          if(this_height > heights[y "," col]){
            visible[row "," col]=1
          }
          else{
            visible[row "," col]=0
            break
          }
        }
      }

      # look towards down
      for(y=row+1; y<=rows; y++){
        mult_d[row","col]=mult_d[row","col]+1
        if(this_height <= heights[y "," col])break
      }

      # hack to set all boundary trees visible
      if(row==1 || row==rows || col==1 || col==cols)visible[row "," col]=1
      total=total+visible[row "," col]
      scenic[row","col]=mult_l[row","col] * mult_r[row","col] * mult_t[row","col] * mult_d[row","col]
      if(scenic[row","col] > highest)highest=scenic[row","col]

      # printf visible[row "," col] # uncomment to print visible array
      # printf scenic[row","col] # uncomment to print scenic score
    }
    # print ""
  }
  printf "Trees visible from outside: %s\n",total
  printf "Highest scenic score: %s\n",highest
}
