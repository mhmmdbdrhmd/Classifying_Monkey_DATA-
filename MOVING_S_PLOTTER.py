import scipy.io as sio
import matplotlib.pyplot as plt
import numpy as np

a=100*sio.loadmat('D:\MOVING_SP.mat')['accuracyte']
x=range(10,501,10)

avr=np.mean(a,2)
i,j=np.unravel_index(avr.argmax(),avr.shape)


title=['Complex Tree',	'Medium Tree',	'Simple Tree',	'Linear Discriminant',	'Quadratic Discriminant',	'Logistic Regression',	'Linear SVM',	'Quadritic SVM',	'Cubic SVM',	'Fine Guassian SVM'	,'Medium Guassian SVM',	'Coarse Guassian SVM',	'Fine KNN',	'Medium KNN'	,'Coarse KNN'	,'Cosine KNN',	'Cubic KNN',	'Weighted KNN',	'Boosted Trees',	'Bagged Trees',	'Subspace Discriminant',	'Subspace KNN',	'RUSBoosted Trees']


maxmax=np.max(avr)

chance=54.15

tempa=a[:,j,:]

x=range(10,501,10)

fig, ax = plt.subplots()

ax.plot(x,np.mean(tempa,1),label='Mean of the best classifier')

varoftempa=np.std(tempa,1)
shadedarea1=np.mean(tempa,1)+varoftempa
shadedarea2=np.mean(tempa,1)-varoftempa
ax.axhline(maxmax,color='g',linewidth=2,label='Highest mean accuracy over all classifier')
ax.axhline(chance,color='r',linewidth=2,label='Chance')


llimity=np.floor(np.min(np.array([np.min(shadedarea2),chance])) - 2)
hlimity=np.ceil(np.max(np.array([np.max(shadedarea1),maxmax])) + 2)
plt.ylim( (llimity, hlimity) )
ax.set_yticks(range(int(llimity),int(hlimity),2))
ax.set_yticklabels(range(int(llimity),int(hlimity),2))


ax.fill_between(x,shadedarea1,shadedarea2, label='STD',alpha=0.15)
ax.legend()

plt.show()

