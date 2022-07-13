#Seyfülmülük Kutluk
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.image import imread
clown=r'C:\Users\seyfk\OneDrive - Merhaba Kullanıcı\Desktop\DERSLER\BLG202E YUSUF YASLAN\homeworks\Hw2\clown.bmp'
image=imread(clown)
print("size")
u, s, vh=np.linalg.svd(image)
s=np.diag(s)
for i in(2**k for k in range(1,7)):
    plt.imshow(u[ :,:i] @s [0:i,:i] @vh[:i,:]).set_cmap('gray')
    plt.show()
    print("size: ", s.shape[0]*s.shape[1] +  u.shape[0]*i +i*vh.shape[1])
    