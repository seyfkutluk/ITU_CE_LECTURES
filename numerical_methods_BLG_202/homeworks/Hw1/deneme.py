
import numpy as np
import matplotlib.pyplot as plt

def func_real(x,h):
    return (np.sin(x + h) - np.sin(x))/h
def func(x,h):
    return (2*np.cos((2*x + h)/2)*np.sin(h/2))/h


fig = plt.figure()



h = np.logspace(1, 20, 20, base=pow(10,-1)).astype(float)
print(h)
cos = np.cos(1.2 + h)
solution_better = func(1.2,h) - cos
solution_real = func_real(1.2,h) - cos
print(solution_better)
print(solution_real)

##, marker='.',color='black', label='Better'
##, marker='.',color='blue', label='Real'

fig, ax = plt.subplots(figsize=(12, 6))
ax.loglog(h, abs(solution_better))
ax.loglog(h, abs(solution_real))

plt.show()