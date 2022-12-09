#!/usr/bin/env awk -f

function abs(v) {return v < 0 ? -v : v}
function check_tail(){
  mtx=0; mty=0
  if(abs(hx-tx) > 1){mtx=(hx-tx)/2}
  if(abs(hy-ty) > 1){mty=(hy-ty)/2}
  if(mtx != 0){tx=tx+mtx;ty=hy}
  if(mty != 0){ty=ty+mty;tx=hx}
  # print "X:"mtx"="tx,"Y:"mty"="ty
  # print tx","ty
}

BEGIN{
  # Head starts at 0,0
  hx=0; hy=0
  hx_min=0; hy_min=0
  h_coords[hx","hy]="H"
  # Tail starts at 0,0
  tx=0; ty=0
  tx_min=0; ty_min=0
  t_coords[tx","ty]="T"
}
{
  dir=$1
  count=$2
  for(i=1; i<=count;i++){
    if(dir == "R"){hx++;check_tail()}
    if(dir == "L"){hx--;check_tail()}
    if(dir == "U"){hy++;check_tail()}
    if(dir == "D"){hy--;check_tail()}
    h_coords[hx","hy]="H"
    t_coords[tx","ty]="T"
    if(hx>hx_max)hx_max=hx
    if(hx<hx_min)hx_min=hx
    if(hy>hy_max)hy_max=hy
    if(hy<hy_min)hy_min=hy
  }
}
END{
  for(hy=hy_max;hy>=hy_min;hy--){
    for(hx=hx_min;hx<=hx_max;hx++){
      if(h_coords[hx","hy]=="H"){
        # printf "H"
        h_count++
      }
      # else{printf "."}
    }
    # print ""
  }

  for(ty=hy_max;ty>=hy_min;ty--){
    for(tx=hx_min;tx<=hx_max;tx++){
      if(t_coords[tx","ty]=="T"){
        printf "T"
        t_count++
      }
      else{printf "."}
    }
    print ""
  }
    print t_count
}
