#!/bin/bash
# run machine boss decoding

for i in $(ls logits/*.csv)
do
    #echo $i
    boss --recognize-merge-csv $i --viterbi-decode > $i.viterbi.json
done
