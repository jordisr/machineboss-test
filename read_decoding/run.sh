#!/bin/bash
# fill out boss machine commands here

for alg in "--prefix-decode --prefix-backtrack 1" "--beam-decode"
do
  boss --recognize-csv nanopore_test.csv $alg
done
