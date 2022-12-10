#!/usr/bin/env awk -f

function add(y){
  cycle_counter++
  x[cycle_counter]=x[cycle_counter-1] + y
}

BEGIN{
  cycle_counter=1
  x[cycle_counter]=1
}
{
  if($1 == "noop")add(0)
  else if($1 == "addx"){ add(0);add($2) }
}
END{
  for(i=20;i<=220;i=i+40){
    sum=sum+(i*x[i])
  }
  printf "Sum of signal strengths: %s\n\n",sum

  for(key in x){
    horiz_pos=(key-1)%40
    if((x[key]-1 <= horiz_pos) && (horiz_pos <= x[key]+1))printf "#"
    else{printf "."}
    if((key)%40 == 0)printf "\n"
  }
}
