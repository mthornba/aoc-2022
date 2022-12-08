#!/usr/bin/env awk -f

BEGIN{
  dir_depth=0
  dircount=0
  dirs[0]="/"
  space_total=70000000
  space_free_target=30000000
}
{
  if($1 == "$"){
    if($2 == "cd"){
      if($3 == "/"){
        dir_depth=0
        cd[dir_depth]=$3
      }
      else if($3 == ".."){
        --dir_depth
      }
      else{
        ++dir_depth
        cd[dir_depth]=$3 "/"
      }
      path=""
      for(key=0; key<=dir_depth; key++){
        path = path cd[key]
      }
    }
  }
  if($1 == "dir"){
    ++dircount
    dirs[dircount]=path $2
  }
  if($1 ~ /^[0-9]+$/){
    filepath=path $2
    sizes[filepath]=$1
  }
}
END{
  for(i in dirs){
    regex="^" dirs[i]
    sum[i]=0
    for(j in sizes)
      if(j ~ regex){
        sum[i]=sum[i]+sizes[j]
      }
      dirsizes[dirs[i]]=sum[i]
      if(sum[i] < 100000){
        total=total+sum[i]
      }
  }
  print "Part 1: "
  printf "\tSum of sub-100000 dirs: %s\n",total

  space_used=sum[0]
  space_unused=space_total - space_used
  need_to_free=space_free_target - space_unused

  print "Part 2:"
  printf "\tUsed: %s\n",space_used
  printf "\tFree: %s\n",space_unused
  printf "\tNeed to free: %s\n",need_to_free

  smallest=dirsizes["/"]
  for(k in dirsizes){
    if(dirsizes[k] > need_to_free){
      if(dirsizes[k]<smallest)smallest=dirsizes[k]
    }
  }
  printf "\tSmallest dir to delete: %s\n",smallest
}
