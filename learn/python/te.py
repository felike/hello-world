#!/usr/bin/env python3
import matplotlib
import numpy as np
import matplotlib.pyplot as plt

#matplotlib.use('macosx')
matplotlib.use('Qt5Agg')

x=np.random.uniform(0.0, 5, 10000)
print(x)
plt.hist(x,100)
plt.show()

plt.pause(5)

