#!/bin/bash

# sample small number of klebsiella reads
# klebsiella_reads= ...
find $klebsiella_reads -name "*.fast5" | grep -v mux | grep -v restart | shuf | head -n 100 > sampled_reads.txt
mkdir reads
for i in $( cat sampled_reads.txt)
do
    cp $i reads
done

# run bonito basecaller
# bonito_path= ...
bonito basecaller reads $bonito_path/bonito/models/quartz5x5-s3-4000/ --device cuda

# copy logits
mkdir logits
mv *.npy logits

# convert saved npy to csv
for i in $(ls logits/*.npy)
do
    python npy_to_csv.py $i
done

# boss machine commands here
mkdir json

# convert JSON machines to FASTA
for w in w5 w50 viterbi
do
  for i in $(ls logits/*.$w.json); do python json_to_fasta.py $i >> decoded.$w.fasta; done
done

# get viterbi with PoreOver (instead of Machine Boss)
for i in $(ls logits/*.npy); do python ~/work2/poreover decode $i --basecaller bonito 1>> viterbi.fasta; done

# get viterbi with PoreOver (instead of Machine Boss)
for i in $(ls logits/*.csv); do python viterbi_decode.py $i >> decoded.viterbi_py.fasta; done
