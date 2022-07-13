#Seyfülmülük Kutluk
#import matplotlib.pyplot as plt # İmporting pyplo
import numpy as np   #importing numpy for sin and cos functions

x= np.array([1,2,1])
y= np.array([[-2,1,4],[1,1,1],[4,1,-2]])

a= np.array([1,2,-1])
b= np.array([[-2,1,4],[1,1,1],[4,1,-2]])

for i in range(6):
    x = np.dot(y,x)
    last= x.max()
    x = x/x.max()
    print("eigenvslue1: ", last)
    print("eigenvalue2: ", x)
    
print("Part Two")

for i in range(6):
    a = np.dot(b,a)
    last1 = a.max()
    a = a/a.max()
    print("eigenvslue1: ",-last1)
    print("eigenvalue2: ", a)
    


    