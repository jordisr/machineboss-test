from Bio import SeqIO
import operator, sys
import json

record = SeqIO.read("genome/NC_000913.3.gb","genbank")

# load gene features from genbank
feature_table = []
for g in record.features:
    if g.type == 'gene':
        feature_table.append([g.qualifiers['gene'][0], int(g.location.start),  int(g.location.end),  g.location.strand])

feature_table.sort(key=operator.itemgetter(1))
print(feature_table[:10])

read_to_genes = dict()
with open('ecoli.paf','r') as f:
    for line in f:
        fields = line.split()

        read_name = fields[0]

        read_start = int(fields[7])
        read_end = int(fields[8])
        if fields[4] == '+':
            read_strand = 1
        elif fields[4] == '-':
            read_strand = -1

        for g in feature_table:
            if read_strand != g[3]:
                continue
            if read_end < g[1]:
                break
            elif g[2] < read_start:
                continue
            elif (g[1] > read_start) and (g[2] < read_end): # AND since we want genes that are contained
                if read_name not in read_to_genes:
                    read_to_genes[read_name] = [g[0]]
                else:
                    read_to_genes[read_name].append(g[0])
                print('Read {}. Gene {} ({}). \n\tRead starts at {} and ends at {}. Gene starts at {} and ends at {}'.format(read_name, g[0], g[3],read_start, read_end,g[1],g[2]))

with open('overlapping_genes.json','w') as jf:
    print(json.dumps(read_to_genes,sort_keys=True, indent=1),file=jf)
