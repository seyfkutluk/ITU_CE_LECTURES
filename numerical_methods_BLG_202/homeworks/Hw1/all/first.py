# Seyfülmülük Kutluk 150180073
import matplotlib.pyplot as plt # İmporting pyplo
import numpy as np   #importing numpy for sin and cos functions
x0=1.2

array = np.logspace(1, 20, 20, base=pow(10,-1))
array = array.astype(float)


#print(array)
# sonuç=(np.sin(90) - np.sin(60))/2
# print(sonuç)
f1der = (np.sin(x0+array) - np.sin(x0))/array
absl=np.cos(x0)         # Derivative of the sinx
f1=np.absolute(f1der-absl)   #to find the absolute error
#print(f1der)

# plt.plot(h,f1der)

f2der =( 2*(np.cos(x0+(array/2))*np.sin(array/2)))/array
f2=np.absolute(f2der-absl)   # to find the absolute error

plt.loglog(array,f1,label="F1")
plt.loglog(array,f2,label="F2")


plt.legend()
plt.show()



# k=[1.e-20 ,1.e-19, 1.e-18 ,1.e-17 ,1.e-16, 1.e-15 ,1.e-14 ,1.e-13, 1.e-12 ,1.e-11,
#  1.e-10 ,1.e-09, 1.e-08 ,1.e-07, 1.e-06, 1.e-05, 1.e-04 ,1.e-03 ,1.e-02 ,1.e-01,
#  1.e+00]
# plt.plot(k)
