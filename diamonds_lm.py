##### Linear Regression Python #####
## Using sklearn & pandas ##

import pandas as pd
import sklearn
import os
import matplotlib.pyplot as plt
import seaborn as sns
path_dir = 'C:\\Users\\Matt\\Desktop\\R_Stuff'
os.chdir(path_dir)
diamonds_data = pd.read_csv('diamonds.txt',delimiter = "	",header = None)

sns.pairplot(diamonds_data)
plt.show()

sns.distplot(diamonds_data['price']
plt.show()

diamonds_data.corr()
corr = diamonds_data.corr()
sns.heatmap(corr,xticklabels=corr.columns,yticklabels=corr.columns)
diamonds_corr_heatmap = sns.heatmap(corr,xticklabels=corr.columns,yticklabels=corr.columns)
diamonds_corr_heatmap.savefig("diamonds_corr_heatmap.png")

from sklearn.linear_model import LinearRegression
lm = LinearRegression()
ind_vars = diamonds_data[['x','y','z']]
dep_vars = diamonds_data['price']

lm.fit(ind_vars,dep_vars)
predictions = lm.predict(ind_vars)

plt.scatter(dep_vars,predictions)
plt.show()

lm.score(ind_vars,dep_vars)

