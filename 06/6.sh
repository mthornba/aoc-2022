#!/usr/bin/env bash
counter=0
strlen=$1
while IFS= read -r -n1 char; do
  counter=$((counter+1))
  string="${string}${char}"
  sorted=$(<<<"${string: -${strlen}:${strlen}}" grep -o . | sort -u | tr -d "\n")
  if [[ ${#sorted} -eq ${strlen} ]]; then
    echo $counter
    break
  fi
done
