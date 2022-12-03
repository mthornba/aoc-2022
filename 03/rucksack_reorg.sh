#!/usr/bin/env bash

# translate string into sorted list of unique values
unique(){
  echo $1 | grep -o . | sort |tr -d "\n" | tr -s 'a-zA-Z'
}

# calculate priority of character
priority(){
  val=$(( $(printf '%d\n' "'$1") ))
  if (( $val >= 97 && $val <= 122 )); then
    priority=$(( $val - 96 ))
  else
    priority=$(( $val - 38 ))
  fi
}

organize(){
  local line=$1
  local first=${line:0:${#line}/2}
  local second=${line:${#line}/2}
  for (( i=0; i<${#first}; i++ )); do
    if [[ $second == *"${first:$i:1}"* ]];then
      local match="${first:$i:1}"
    fi
  done
  priority "$match"
  sum1=$(( $sum1 + $priority ))
}

while read -r line1; do
  read -r line2
  read -r line3

  # Part One
  organize "$line1"
  organize "$line2"
  organize "$line3"

  # Part Two
  line1=$(unique "$line1")
  line2=$(unique "$line2")
  line3=$(unique "$line3")

  for (( i=0; i<${#line1}; i++ )); do
    if [[ $line2 == *"${line1:$i:1}"* ]];then
      in1and2+="${line1:$i:1}"
    fi
  done

  for (( i=0; i<${#in1and2}; i++ )); do
    if [[ $line3 == *"${in1and2:$i:1}"* ]];then
      match="${in1and2:$i:1}"
    fi
  done

  priority "$match"
  sum2=$(( $sum2 + $priority ))
done <$1

printf "Part One: %s\nPart Two: %s\n" "$sum1" "$sum2"
