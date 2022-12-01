#!/usr/bin/env gawk -f
BEGIN{ RS="" }
{ for(i=1;i<=NF;i++)arr[NR]+=$i }
END{
  asort(arr,arr,"@val_num_desc")
  for(i=1;i<=3;i++)sum+=arr[i]
  printf "Most calories: %i\n",arr[1]
  printf "Top 3 total: %i\n",sum
}
