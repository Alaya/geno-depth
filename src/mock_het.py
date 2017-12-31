#!/usr/bin/python

import numpy as np
import pandas as pd

df       = pd.read_csv("../data/het_minDP0.tsv", sep='\t')
df_means = pd.read_csv("../data/het_mean.tsv", sep='\t')

df = df.iloc[:, [0, 4]]
df.rename(columns={'F': '0'}, inplace=True)

base = df_means.iloc[0, 1]

for index, mean in enumerate(df_means.iloc[1:, 1]):
  noise =  np.random.normal(0,0.005)
  kwargs = {str(index+1) : df['0'].values + mean - base + noise}
  df = df.assign(**kwargs)

print df

df.to_csv("het.tsv", sep='\t', index=False)
