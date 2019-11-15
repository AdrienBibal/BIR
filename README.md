# BIR
The code has been written by Rebecca Marion and Adrien Bibal.

## Pre-requisites:
1) dataset.csv in the folder called Datasets. This file must contain the feature values used for explaining the embedding. 
Columns = features; rows = instances. The first line of the file contains the feature names.

2) embedding.csv in the folder called Datasets. This file must contain the embedding to explain. 
Columns = embedding dimensions; rows = instances. The first line of the file corresponds to the first instance.

## How to run BIR:
In order to run BIR, execute all lines of BIR.R. Inputs (the embedding X and the features Fe for explaining it) should be located in the folder Datasets. The results will be provided in the folder called Results.

## How long does it take to run BIR?
The selection of lambda should be perform before running BIR for the last time. As lambda is selected by 10-fold cross validation and the optimization is performed using simulated annealing, running BIR will take (number of lambdas to test) * (number of folds in the cross validation) * (number of seconds for simulated annealing). In the current implementation, this means 10 lambdas * 10 folds * 2 seconds.

# References:
* Bibal, Adrien, Rebecca Marion, and Benoît Frénay. "Finding the most interpretable MDS rotation for sparse linear models based on external features." ESANN. 2018.
* Marion, Rebecca, Adrien Bibal, and Benoît Frénay. "BIR: A method for selecting the best interpretable multidimensional scaling rotation using external variables." Neurocomputing 342 (2019): 83-96.
