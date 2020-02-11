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
width=10
for i in $(ls logits/*.npy)
do
    boss --recognize-merge-csv nanopore_test.csv --beam-decode --beam-width $width > json/$i.w$width.json
done

for i in $(ls logits/*.w25.json); do python json_to_fasta.py $i >> beam25.fasta; done

for i in $(ls logits/*.w25.json)
do
    python json_to_fasta.py $i >> beam25.fasta
done

for i in $(ls logits/*.w50.json)
do
    python json_to_fasta.py $i >> beam50.fasta
done

for i in $(ls logits/*.npy); do python ~/work2/poreover decode $i --basecaller bonito 1>> viterbi.fasta; done
