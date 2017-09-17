
import scipy.io as sio
import matplotlib.pyplot as plt
import numpy as np


a=100*sio.loadmat('D:\moving_50.mat')['accuracyte']

avr=np.mean(a,2)
i,j=np.unravel_index(avr.argmax(),avr.shape)

print(j)

maxmax=np.max(avr)
title=['Complex Tree',	'Medium Tree',	'Simple Tree',	'Linear Discriminant',	'Quadratic Discriminant',	'Logistic Regression',	'Linear SVM',	'Quadritic SVM',	'Cubic SVM',	'Fine Guassian SVM'	,'Medium Guassian SVM',	'Coarse Guassian SVM',	'Fine KNN',	'Medium KNN'	,'Coarse KNN'	,'Cosine KNN',	'Cubic KNN',	'Weighted KNN',	'Boosted Trees',	'Bagged Trees',	'Subspace Discriminant',	'Subspace KNN',	'RUSBoosted Trees']
chance=54.15

tempa=a[:,j,:]

x1=range(1,452,10)
X2=range(51,501,10)

fig, ax = plt.subplots()
ax.set_title("End Point (ms)",fontsize=12,y=1.02)
plt.xlabel('Start Point (ms)')
plt.ylabel('Accuracy (%)')
ax2 = ax.twiny()

ax.plot(x1,np.mean(tempa,1),label='Mean of the best classifier')

varoftempa=np.std(tempa,1)
shadedarea1=np.mean(tempa,1)+varoftempa
shadedarea2=np.mean(tempa,1)-varoftempa
ax.axhline(maxmax,color='g',linewidth=2,label='Highest mean accuracy ('+(title[j])+')')
ax.axhline(chance,color='r',linewidth=2,label='Chance')

llimity=np.floor(np.min(np.array([np.min(shadedarea2),chance])) - 2)
hlimity=np.ceil(np.max(np.array([np.max(shadedarea1),maxmax])) + 2)
plt.ylim( (llimity, hlimity) )

foryticks=list(range(int(llimity),int(hlimity),2))
[foryticks.append(i) for i in [float("%.2f" %(maxmax)),float("%.2f" %(chance))]]

ax.set_yticks(foryticks)
ax.set_yticklabels(foryticks)





ax.fill_between(x1,shadedarea1,shadedarea2, label='STD',alpha=0.15)
ax.legend()

ax2.plot(X2, maxmax*np.ones(45))

plt.show()

