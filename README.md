# FingerPrintClusterKmean
Use Kmean Clustering to deal with all AP data in FingerPrint Solution.

Fingerprint is a ordinary solution to solve the problem of Indoor Position.
The solution of Fingerprint includes two step named offline and online, which is an analogy to two stepes in machine learning.
Therefor, offline which means building the fingerprints database is a training process and online using to position is a testing proces.

The core of this solution is to find the quantative relationship between two variables including AP RSSI and position coordinates.
This program is to use Kmean Clustering to search this kind of correlation.
