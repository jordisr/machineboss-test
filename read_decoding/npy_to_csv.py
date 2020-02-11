# convert Bonito npy logits to csv for Machine Boss decoding
import numpy as np
import csv
import os
import sys

logits = np.load(sys.argv[1])

np.savetxt(sys.argv[1]+'.csv', logits[:,[1,2,3,4,0]], header='A,C,G,T,', delimiter=',', comments='')
