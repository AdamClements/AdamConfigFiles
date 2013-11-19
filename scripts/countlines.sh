#!/usr/bin/env bash
(
echo 0;
for ext in "$@"; do
    for i in $(find . -name "*$ext"); do
        sed '/^\s*$/d' $i | wc -l ## skip blank lines
        #cat $i | wc -l; ## count all lines
        echo +;
    done
done
echo p q;
) | dc;
