#!/usr/bin/python

import numpy as np
import pandas as pd

df       = pd.read_csv("het_minDP0.tsv", sep='\t')
df_means = pd.read_csv("het_mean.tsv", sep='\t')

df = df.iloc[:, [0, 4]]
df.rename(columns={'F': '0'}, inplace=True)

mean_diffs = df_means.diff().iloc[1:, 1]

for index, mean_diff in enumerate(mean_diffs):
  noise =  np.random.normal(0, mean_diff / 3, len(df.index))
  kwargs = {str(index+1) : df.iloc[:, -1].values + mean_diff + noise}
  df = df.assign(**kwargs)

print df

df.to_csv("het.tsv", sep='\t', index=False)
