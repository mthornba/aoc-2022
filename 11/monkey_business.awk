#!/usr/bin/env awk -f

function math(var,op){
  old=var
  print "old="old
  sprintf(op,"%d")
}

function inspect(monkey){
}

function reduce(w){
  w=(w - w%3)/3
}

function throw(monkey){
}

BEGIN{
  FS=":"
  # OFS="="
  worry=0
  mounkey_count=0
  # round=1
  # new=0;old=1
  # op="old+2"
  # split(op,opa,/\>/)
  # print length(opa)
  # for(i=1;i<=length(opa);i++)printf "%d: %s\n",i,opa[i]
  # exit
}
{
  k=$1; v=$2
  gsub(/[[:blank:]]/, "", k);
  gsub(/[[:blank:]]/, "", v);
  # printf "%s\n",k

  if(k ~ /Monkey/){
    match(k, /[0-9]+/)
    monkey_num=substr(k, RSTART, RLENGTH)
    monkey_count++
    # printf "\nMonkey: %d\n",monkey_num
  }

  if(k == "Startingitems"){
    split(v,items[monkey_num],",")
    item_pointer[monkey_num]=1
    # for(i=1;i<=length(items[monkey_num]);i++){
    #   print items[monkey_num][i]
    # }
  }

  if(k == "Operation"){
    split(v,opa,"=")
    op[monkey_num]=opa[2]
    # print op # op[2]="old*19"
  }

  if(k == "Test"){
    match(v, /[0-9]+/)
    dividend[monkey_num]=substr(v, RSTART, RLENGTH)
    # print dividend[monkey_num]
  }

  if(k == "Iftrue"){
    match(v, /[0-9]+/)
    test_true[monkey_num]=substr(v, RSTART, RLENGTH)
    # print test_true[monkey_num]
  }

  if(k == "Iffalse"){
    match(v, /[0-9]+/)
    test_false[monkey_num]=substr(v, RSTART, RLENGTH)
    # print test_false[monkey_num]
  }

}
END{
  for(i=0;i<monkey_count;i++){
    printf "\nMonkey: %d\n",i
    printf "Starting items: "
    for(j=1;j<=length(items[i]);j++){
      printf "%s,",items[i][j]
    }
    printf "\n"
    printf "Operation: %s\n",op[i]
    printf "Test: %d\n",dividend[i]
    printf "If true: %d\n",test_true[i]
    printf "If false: %d\n",test_false[i]
    # inspect(i)
    # reduce(worry)
    # to=test(i)
    # throw(to)
  }

}
