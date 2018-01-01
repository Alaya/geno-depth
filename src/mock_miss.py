#!/usr/bin/python

from __future__ import division
import numpy as np
import pandas as pd

depths = pd.read_csv("data/depth.tsv", sep='\t', header=0)["Freq"][:3]
miss   = pd.read_csv("raw/miss_site_minDP0.tsv", 
                     sep='\t', header=0)[["N_Smp", "Freq"]]
miss.rename(columns={'Freq': '0'}, inplace=True)
print miss

total_sites = miss['0'].sum()
print total_sites + 10

# for depth in depths:
#   print depth, depth / total_sites 
#   print miss * depth / total_sites

miss.to_csv("data/miss.tsv", sep='\t')
