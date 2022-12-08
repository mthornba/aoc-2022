#!/usr/bin/env awk -f

BEGIN{
  dir_depth=0
  dircount=0
  dirs[0]="/"
}
{
  if($1 == "$"){
    if($2 == "cd"){
      if($3 == "/"){
        dir_depth=0
        cd[dir_depth]=$3
        # print "depth: " dir_depth " cd: " cd[dir_depth]
      }
      else if($3 == ".."){
        --dir_depth
        # print "depth: " dir_depth " cd: " cd[dir_depth]
      }
      else{
        ++dir_depth
        cd[dir_depth]=$3 "/"
        # print "depth: " dir_depth " cd: " cd[dir_depth]
        # print index_dir ": " cd[index_dir]
      }
      path=""
      for(key=0; key<=dir_depth; key++){
        # print "key: " key " cd: " cd[key]
        path = path cd[key]
        # print "path = " path
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
    # print filepath " = " sizes[filepath]
  }
}
END{
  # printf "\nFiles:\n"
  # for(key in sizes)
    # print key ": " sizes[key]

  # printf "\nDirs:\n"
  for(i in dirs){
    # print dirs[i]
    regex="^" dirs[i]
    sum[i]=0
    for(j in sizes)
      if(j ~ regex){
        # print "dir: " dirs[i] " j: " j " size: " sizes[j]
        sum[i]=sum[i]+sizes[j]
      }
      dirsizes[dirs[i]]=sum[i]
      # print dirs[i] ": " dirsizes[dirs[i]]
      if(sum[i] < 100000){
        total=total+sum[i]
      }
  }
  print "Part 1: " total

  space_total=70000000
  space_free_target=30000000
  space_used=sum[0]
  space_unused=space_total - space_used
  need_to_free=space_free_target - space_unused

  print "Part 2:"
  print "Used: " space_used
  print "Free: " space_unused
  print "Need to free: " need_to_free

  smallest=dirsizes["/"]
  for(k in dirsizes){
    if(dirsizes[k] > need_to_free){
      if(dirsizes[k]<smallest)smallest=dirsizes[k]
    }
  }
  print "Smallest dir to delete =",smallest
}
