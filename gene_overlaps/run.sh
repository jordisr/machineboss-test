#!/bin/bash

# download data

# align reads to genome
minimap2 -k12 -t8 -c genome/NC_000913.3.fasta reads/E_coli_K12_1D_R9.2_SpotON_2.pass.fasta > ecoli.paf

#
