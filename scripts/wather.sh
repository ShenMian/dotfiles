#!/bin/bash

result=$(curl -m 1 "wttr.in/$1" 2>/dev/null)
while [ -z "$result" ]
do
  result=$(curl -m 1 "wttr.in/$1" 2>/dev/null)
done
echo "$result"
