#!/usr/bin/env bash

unique(){
  echo $1 | grep -o . | sort |tr -d "\n" | tr -s 'a-zA-Z'
}

while read -r line1; do
  read -r line2
  read -r line3

  line1=$(unique "$line1")
  line2=$(unique "$line2")
  line3=$(unique "$line3")
  in1and2=""
  match=""

  for (( i=0; i<${#line1}; i++ )); do
    # echo "${line1:$i:1}"
    if [[ $line2 == *"${line1:$i:1}"* ]];then
      in1and2+="${line1:$i:1}"
    fi
  done

  for (( i=0; i<${#in1and2}; i++ )); do
    if [[ $line3 == *"${in1and2:$i:1}"* ]];then
      match="${in1and2:$i:1}"
    fi
  done

  val=$(( $(printf '%d\n' "'$match") ))
  if (( $val >= 97 && $val <= 122 )); then
    priority=$(( $val - 96 ))
  else
    priority=$(( $val - 38 ))
  fi
  sum=$(( $sum + $priority ))
done <$1

echo $sum
