#!/usr/bin/env awk -f

function peek(i){
  return substr(stack[i],length(stack[i]),1)
}

function pop(i){
  letter=peek(i)
  stack[i]=substr(stack[i],0,length(stack[i])-1)
  return letter
}

function push(i,val){
  return stack[i]=stack[i] val
}

function mv(k,i,j){
  for(x=1;x<=k;x++)push(j,pop(i))
}

BEGIN{
  stack[1]="DLJRVGF"
  stack[2]="TPMBVHJS"
  stack[3]="VHMFDGPC"
  stack[4]="MDPNGQ"
  stack[5]="JLHNF"
  stack[6]="NFVQDGTZ"
  stack[7]="FDBL"
  stack[8]="MJBSVDN"
  stack[9]="GLD"
}
{
  if($1 != "move")next
  mv($2,$4,$6)
}
END{
  for(i=1;i<=9;i++)push("code",peek(i))
  # print stack[1]
  # print stack[2]
  # print stack[3]
  print stack["code"]
}
