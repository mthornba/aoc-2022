#!/usr/bin/env awk -f

BEGIN{
  dir_depth=0
  dircount=0
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
    sum=0
    for(j in sizes)
      if(j ~ regex){
        # print "dir: " dirs[i] " j: " j " size: " sizes[j]
        sum=sum+sizes[j]
      }
    if(sum < 100000){
      # print dirs[i] ": " sum
      total=total+sum
    }
  }
  print total
}
