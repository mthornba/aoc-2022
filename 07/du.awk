#!/usr/bin/env awk -f

BEGIN{
  # tree["/"]=""
  index_dir=0
  dircount=0
}
{
  if($1 == "$"){
    if($2 == "cd"){
      if($3 == ".."){
        --index_dir
      }
      else if($3 == "/"){
        index_dir=0
        cd[index_dir]=$3
      }
      else{
        ++index_dir
        cd[index_dir]=$3
        # print index_dir ": " cd[index_dir]
      }
    }
    path = "/"
    for(key=1; key<=index_dir; key++)
      path = path cd[key] "/"
    print path
  }
  if($1 == "dir"){
    ++dircount
    dirs[dircount]=path "/" $2
  }
  if($1 ~ /^[0-9]+$/){
    filepath=path $2
    sizes[filepath]=$1
    # print filepath " = " sizes[filepath]
  }
  # print "Current dir: " cd[index_dir]
}
END{
  print "Dirs:"
  for(key in dirs)
    print dirs[key]
  print "Files:"
  for(key in sizes)
    print key ": " sizes[key]
}
