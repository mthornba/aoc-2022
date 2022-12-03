#!/usr/bin/env awk -f
BEGIN{ v="ABCXYZ" }
{
  # assign values based on index, A/X=1, B/Y=2, C/Z=3
  # i=field 1, j=field 2
  i=index(v,$1);j=index(v,$2)-3
  # part 1:
  s+=3*((j-i+4)%3)+j
  # part 2:
  t+=3*(j-1)+(i+j+3)%3+1
}
END{
  print s,t
}
