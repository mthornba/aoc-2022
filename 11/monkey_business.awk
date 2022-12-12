#!/usr/bin/env gawk -f

function print_monkeys(){
  for(m=0;m<monkey_count;m++){
    printf "Monkey: %d\n",m
    printf "Items: "
    for(j=item_pointer[m];j<=length(items[m]);j++){
      printf "%s,",items[m][j]
    }
    printf "\n"
    printf "Operation: %s\n",op_func[m]
    printf "Test: %d\n",dividend[m]
    printf "If true: %d\n",test_true[m]
    printf "If false: %d\n",test_false[m]
    printf "\n"
  }
}

function inspect(n){
  worry=items[n][item_pointer[n]]
  item_pointer[n]++
  return worry
}

function operate(m){
  # print op_func[m],worry
  cmd="echo 'old="worry";"op_func[m]"'|bc"
  cmd | getline worry
  close(cmd)
  return worry
}

function bored(old,modulus){
  # new=int(old/3)
  new=old%modulus
  # print worry
  return new
}

function test(m){
  if(worry/dividend[m] == int(worry/dividend[m])){
    return test_true[m]
  }
  else{
    return test_false[m]
  }
}

function throw(n){
  items[n][length(items[n])+1]=worry
}

BEGIN{
  FS=":"
  # OFS="="
  worry=0
  monkey_count=0
  modulus=1
  rounds=10000
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
    op_func[monkey_num]=opa[2]
    # print op # op[2]="old*19"
  }

  if(k == "Test"){
    match(v, /[0-9]+/)
    dividend[monkey_num]=substr(v, RSTART, RLENGTH)
    modulus=modulus*dividend[monkey_num]
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
  print_monkeys()
  print modulus

  for(r=1;r<=rounds;r++){
    for(m=0;m<monkey_count;m++){
      for(n=item_pointer[m];n<=length(items[m]);n++){
        inspect(m)
        operate(m)
        worry=bored(worry,modulus)
        to=test(m)
        throw(to)
      }
      inspections[m]=item_pointer[m]-1
    }
    if(r==1 || r==20 || r%1000 == 0){
      printf "### After Round %d: \n\n",r
      # print_monkeys()
      for(m=0;m<monkey_count;m++){
        print inspections[m]
      }
    }
  }
  asort(inspections,inspections,"@val_num_desc")
  monkey_business=inspections[1]*inspections[2]
  print "Monkey Business Score:",monkey_business

}
