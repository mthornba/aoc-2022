#!/usr/bin/env bash
while read -r line; do
  for strlen in 4 14; do
  counter=0
  string=""
  sorted=""
    while IFS= read -r -n1 char; do
      counter=$((counter+1))
      string="${string}${char}"
      sorted=$(<<<"${string: -${strlen}:${strlen}}" grep -o . | sort -u | tr -d "\n")
      if [[ ${#sorted} -eq ${strlen} ]]; then
        [[ ${strlen} -eq 4 ]] && type='packet' || type='message'
        printf "start-of-%s:\t%s\n" $type $counter
        break
      fi
    done <<<"${line}"
  done
done
