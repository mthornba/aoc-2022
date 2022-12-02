#!/usr/bin/env awk -f
{
  if($0=="A X"){a+=4;b+=3}
  if($0=="A Y"){a+=8;b+=4}
  if($0=="A Z"){a+=3;b+=8}
  if($0=="B X"){a+=1;b+=1}
  if($0=="B Y"){a+=5;b+=5}
  if($0=="B Z"){a+=9;b+=9}
  if($0=="C X"){a+=7;b+=2}
  if($0=="C Y"){a+=2;b+=6}
  if($0=="C Z"){a+=6;b+=7}
}
END{
  print a,b
}
