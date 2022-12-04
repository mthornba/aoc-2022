#!/usr/bin/env awk -f
BEGIN{ FS="," }
{
  split($1,a,"-");
  split($2,b,"-");
  # print a[1] "-" a[2],b[1] "-" b[2]
  # set values as keys of array for in function to work
  delete range1; delete range2
  for(i=a[1];i<=a[2];i++){range1[i]=i}
  for(i=b[1];i<=b[2];i++){range2[i]=i}
  l1=length(range1); l2=length(range2);
  matching=0;
  for(i=a[1];i<=a[2];i++){
    if(range1[i] in range2){matching++}
  }
  if(matching == l1 || matching == l2){sum++}
  if(matching > 0)overlap++
}
END{
  print "contained: " sum
  print "overlap: " overlap
}
