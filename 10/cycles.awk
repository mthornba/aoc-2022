#!/usr/bin/env awk -f

BEGIN{
  cycle_counter=1
  x[cycle_counter]=1
}
{
  if($1 == "noop"){
    cycle_counter++
    x[cycle_counter]=x[cycle_counter-1]
  }
  else if($1 == "addx"){
    cycles=2
    cycle_counter++
    x[cycle_counter]=x[cycle_counter-1]
    cycle_counter++
    x[cycle_counter]=x[cycle_counter-1] + $2
  }
}
END{
  for(i=20;i<=220;i=i+40){
    print i, x[i]
    sum=sum+(i*x[i])
  }
  print sum
}
