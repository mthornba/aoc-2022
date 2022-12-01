# Usage

```shell
$ ./cal_count.awk input
Most calories: 71934
Top 3 total: 211447
```

# 1-liner for fun
```awk
$ <input gawk 'BEGIN{RS=""}{for(i=1;i<=NF;i++)a[NR]+=$i}END{asort(a);for(i=FNR;i>=FNR-2;i--)sum=sum+a[i];print a[FNR],sum}'
71934 211447
```
