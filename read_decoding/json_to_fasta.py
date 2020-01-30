import string
import json
import os
import sys

# import json sequence file from machine boss

with open(sys.argv[1], "r") as json_file:
    data = json.load(json_file)
    print(''.join(data[0]['input']['sequence']))
