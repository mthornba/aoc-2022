#!/usr/bin/env awk -f
{
  if($0=="A X")n=3
  if($0=="A Y")n=4
  if($0=="A Z")n=8
  if($0=="B X")n=1
  if($0=="B Y")n=5
  if($0=="B Z")n=9
  if($0=="C X")n=2
  if($0=="C Y")n=6
  if($0=="C Z")n=7
  sum+=n
}
END{
  print sum
}
