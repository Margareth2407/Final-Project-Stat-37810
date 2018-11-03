

```python

```


```python
import math
import random
import numpy
import matplotlib as plt
import seaborn as sns
import statistics

sns.set(color_codes = True)

def gibbs(N = 50000, thin = 1000, B = 5):
    mat = numpy.empty((N  +1,3,))
    
    x = B/2
    y = B/2
    mat[0,0] = 0
    mat[0,1] = x
    mat[0,2] = y
    
    for i in range(1,N + 1):
       
        u1 = random.uniform(0,1)
        alpha = (1 - math.exp(-B*y))
        newx = -(1/y)*math.log(1-u1*alpha)
        
        x = newx
        
        u2  = random.uniform(0,1)
        beta = (1 - math.exp(-B*x))
        newy = -(1/x)*math.log(1-u2*beta)
        
        y = newy
        
        mat[i,0] = i
        mat[i,1] = newx
        mat[i,2] = newy
    seq = mat[:,0]
    xs = mat[:,1]
    ys = mat[:,2]
    
    mat = numpy.matrix(mat)
    return(mat)
  





```


```python
trials = gibbs(500)
plt.pyplot.hist(trials[:,1],bins = 50)
plt.pyplot.title('500 draws')
plt.pyplot.xlabel('Bins')
plt.pyplot.ylabel('Counts')
statistics.mean(numpy.asarray(trials)[:,1])

```




    1.2841215406495794




![png](output_2_1.png)



```python
trials = gibbs(5000)
plt.pyplot.hist(trials[:,1],bins = 50)
plt.pyplot.title('5000 draws')
plt.pyplot.xlabel('Bins')
plt.pyplot.ylabel('Counts')
statistics.mean(numpy.asarray(trials)[:,1])
```




    1.2586229563432523




![png](output_3_1.png)



```python
trials = gibbs(50000)
plt.pyplot.hist(trials[:,1],bins = 50)
plt.pyplot.title('50000 draws')
plt.pyplot.xlabel('Bins')
plt.pyplot.ylabel('Counts')
statistics.mean(numpy.asarray(trials)[:,1])
```




    1.2697125546442287




![png](output_4_1.png)

