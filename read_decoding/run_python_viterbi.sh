#!/bin/bash

rm decoded.viterbi_py.fasta
for i in $(ls logits/*.csv); do python viterbi_decode.py $i >> decoded.viterbi_py.fasta; done
