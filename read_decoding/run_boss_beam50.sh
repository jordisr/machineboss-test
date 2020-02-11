#!/bin/bash
# run machine boss decoding

width=50
for i in $(ls logits/*.csv)
do
    #echo $i
    boss --recognize-merge-csv $i --beam-decode --beam-width $width > $i.w$width.json
done
