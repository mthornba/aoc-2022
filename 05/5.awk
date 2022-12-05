#!/usr/bin/env awk -f

function peek(i,len){
  return substr(stack[i],length(stack[i])-len+1,length(stack[i]))
}

function pop(i,len){
  popstr=peek(i,len)
  stack[i]=substr(stack[i],0,length(stack[i])-len)
  return popstr
}

function push(i,val){
  return stack[i]=stack[i] val
}

function mv(count,from,to,mode){
  if(mode == "9000"){
    repeat=count
    num=1
  }
  if(mode == "9001"){
    repeat=1
    num=count
  }
  for(x=1;x<=repeat;x++)push(to,pop(from,num))
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
  mv($2,$4,$6,mode)
}
END{
  for(i=1;i<=9;i++)push("code",peek(i,1))
  print stack["code"]
}
