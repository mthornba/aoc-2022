# 1-liner

```awk
<input awk 'BEGIN{v="ABCXYZ"}{i=index(v,$1);j=index(v,$2)-3;s+=3*((index(v,$2)-index(v,$1)+1)%3)+j;t+=3*(j-1)+(i+j+3)%3+1}END{print s,t}'
```
