#!/bin/bash

set -e

name=lazy-points
version=$(git describe --abbrev=0 --tags)
filename=$name-$version.pk3

rm -f $filename

zip $filename    \
    zscript/*.zs \
    *.md  \
    *.txt \
    *.zs  \

gzdoom -iwad $IWAD     \
       -file $filename \
       "$1" "$2" "$3"  \
       +map test
