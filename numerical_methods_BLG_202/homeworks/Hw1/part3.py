import numpy as np

v = np.array([1,2,-1])

x = np.array([[-2,1,4],[1,1,1],[4,1,-2]])

print(x)

a = range(0,5,1)


for n in a:
    v = x @ v
    print(v)
    


v = v / 162

print("Eigenvector for after 5 iterations")
print(v)



v = np.array([1,2,1])

for n in a:
    v = x @ v
    print(v)


v = v /324

print("Eigenvector for after 5 iterations")

print(v)



e = np.linalg.eig(x)

print(e)