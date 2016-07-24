#!/bin/bash
#convert to eps 
[ -z $2 ] && exit 
for im in $1; do
    file=$(basename $im)
    convert $im $2/${file%.*}.pdf
done
