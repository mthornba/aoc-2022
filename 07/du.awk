#!/usr/bin/env awk -f

BEGIN{
  # tree["/"]=""
  index_dir=0
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
      j = cd[0]
      for(key=1; key<=index_dir; key++)
        j = j cd[key] "/"
      print j
      print "Current dir: " cd[index_dir]
    }
  }
}
END{
  # for(key in tree)
  # print key ": " tree[key]
}
