#!/bin/bash
# run machine boss decoding and time it

echo "Viterbi decoding"
time bash run_boss_viterbi.sh

echo "Beam search (w=5)"
time bash run_boss_beam5.sh

echo "Beam search (w=50)"
time bash run_boss_beam50.sh
