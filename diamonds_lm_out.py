import pandas as pd
import sklearn
import os
import matplotlib.pyplot as plt
import seaborn as sns
path_dir = 'C:\\Users\\Matt\\Desktop\\R_Stuff'
os.chdir(path_dir)
diamonds_data = pd.read_csv('diamonds.txt',delimiter = "	")
corr = diamonds_data.corr()
diamonds_corr_heatmap = sns.heatmap(corr,xticklabels=corr.columns,yticklabels=corr.columns)
diamonds_corr_heatmap = diamonds_corr_heatmap.get_figure()
diamonds_corr_heatmap.savefig("diamonds_corr_heatmap.png")