import numpy as np

def normal(v):
    fac = abs(v).max()
    vn = v / v.max()
    return fac, vn
    
    
v = np.array([1, 2, 1])
x = np.array([[-2, 1, 4], [1, 1, 1], [4, 1, -2]])

for i in range(0):
    x = np.dot(x, v)
    eival_1, x = normal(v)
    
print("Eigenvalue for vector 1: ", eival_1, "Eigenvector for vector 1: ", x)
   
    
v = np.array([1, 2, -1])

for i in range(0):
    x = np.dot(x, v)
    eival_2, x = normal(v)
    
print("Eigenvalue for vector 2: ", eival_2, "Eigenvector for vector 2: ", x)