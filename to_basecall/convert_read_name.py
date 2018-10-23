import re, os, sys

'''
expect header file to be larger than the reads we want, so read all the reads
we want into memory, then iterate through the header list and pull out thes ones
that match
'''

reads = []

with open(sys.argv[1],'r') as readnames:
    for line in readnames:
        reads.append(line.strip())
        #print(line)

with open(sys.argv[2],'r') as headers:
    for line in headers:
        fields = line.strip().rsplit()
        if fields[0][1:] in reads:
            print('\t'.join([fields[1], fields[0][1:]]))
