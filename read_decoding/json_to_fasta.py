import string
import json
import os
import sys

# import json sequence file from machine boss

def fasta_format(name, seq, width=60):
    fasta = '>'+name+'\n'
    window = 0
    while window+width < len(seq):
        fasta += (seq[window:window+width]+'\n')
        window += width
    fasta += (seq[window:]+'\n')
    return(fasta)

with open(sys.argv[1], "r") as json_file:
    data = json.load(json_file)
    seq = ''.join(data[0]['input']['sequence'])
    print(fasta_format(sys.argv[1], seq))
