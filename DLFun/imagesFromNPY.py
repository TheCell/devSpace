import numpy as np
from matplotlib import pyplot as plt
import matplotlib
import glob

for filename in glob.glob("*.*"):
    if '.npy' in filename:
        img_array = np.load(filename)
        i = 0
        for img in img_array:
            plt.imshow(img, cmap="gray")
            img_name = filename+str(i)+".png"
            matplotlib.image.imsave(img_name, img)
            print(filename+str(i))
            i += 1
