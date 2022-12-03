#!/usr/bin/env bash

while read -r line; do
  # echo $line
  first=${line:0:${#line}/2}
  second=${line:${#line}/2}
  for (( i=0; i<${#first}; i++ )); do
    if [[ $second == *"${first:$i:1}"* ]];then
      match="${first:$i:1}"
    fi
  done
  # printf '%d\n' "'$match"
  val=$(( $(printf '%d\n' "'$match") ))
  if (( $val >= 97 && $val <= 122 )); then
    priority=$(( $val - 96 ))
  else
    priority=$(( $val - 38 ))
  fi
  sum=$(( $sum + $priority ))
  # echo $priority
done <$1
echo $sum
