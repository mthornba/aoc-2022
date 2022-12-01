#!/usr/local/bin/gawk -f
BEGIN{ RS="" }
{ for(i=1;i<=NF;i++){arr[NR]+=$i;} }
END{
  asort(arr)
  for(i=FNR;i>=FNR-2;i--){sum=sum+arr[i]}
  printf "Most calories: %i\n",arr[FNR]
  printf "Top 3 total: %i\n",sum
}
