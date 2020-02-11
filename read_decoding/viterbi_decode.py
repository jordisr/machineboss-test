# Viterbi decode CSV of Bonito output (same as input to Machine Boss)

import numpy as np
import csv
import os
import sys

def fasta_format(name, seq, width=60):
    fasta = '>'+name+'\n'
    window = 0
    while window+width < len(seq):
        fasta += (seq[window:window+width]+'\n')
        window += width
    fasta += (seq[window:]+'\n')
    return(fasta)

logits = np.loadtxt(sys.argv[1], delimiter=',', skiprows=1)
argmax_path = np.argmax(logits, axis=1)
viterbi_string = ''.join(np.take(np.array(list("ACGT")), np.array([g[0] for g in groupby(argmax_path)])))

print(fasta_format(sys.argv[1], viterbi_string))
