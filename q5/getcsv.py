import pandas as pd

# read data from rps.tsv as dataframe
dfs = pd.read_csv('rps.tsv', sep="\t", header=None, dtype = str)
to_concat= ['cpu.tsv', 'memory.tsv']
# loop all files that need to concatenate
for filename in to_concat:
    df = pd.read_csv(filename, sep="\t", header=None, dtype = str)
    dfs = pd.concat([dfs, df], axis=1, join='inner')

# write it out
dfs.to_csv("result.csv", header=None, index=None)