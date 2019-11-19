# BIR (Best Interpretable Rotation)
The code has been written by Rebecca Marion and Adrien Bibal.

## Goal of BIR:
The purpose of BIR is to provide a linear explanation of 2D maps that are subject to rotational invariance. In our research, we considered Multidimensional Scaling (MDS) embeddings as an example of maps that are invariant to rotation. By invariant to rotation, we mean that the orientation of the map is arbitrary, and should therefore be considered when explaining the two dimensions of the map.

## Pre-requisites:
1) dataset.csv in the folder called Datasets. This file must contain the feature values used for explaining the embedding. 
Columns = features; rows = instances. The first line of the file contains the feature names.

2) embedding.csv in the folder called Datasets. This file must contain the embedding to explain. 
Columns = embedding dimensions; rows = instances. The first line of the file corresponds to the first instance.

## How to run BIR?
In order to run BIR, execute all lines of BIR.R. Inputs (the embedding X and the features Fe for explaining it) should be located in the folder Datasets. The results will be provided in the folder called Results.

If you want to run BIR as a script (with Rscript), you can either use no argument (in this case, dataset.csv and embedding.csv should be in the folder Datasets) or more. If you use arguments, the two first arguments are mandatory: the first one is the path to the embedding file and the second one is the path to the dataset used to explain the embedding. The additional arguments must be in ordre, but are optional. The third argument is the path indicating where the results should be stored, the fourth one is the start of the range of lamdas, the fifth one is the end of the range and the sixth one is the number of lamndas that should be evaluated.

Here is one example of use with the two first mandatory arguments and the first optinal one:<br> Rscript BIR.R a_path_to/my_embedding_file.csv another_path_to/my_dataset_file.csv an_output_path/output_file.RData

## How long does it take to run BIR?
The selection of lambda should be perform before running BIR for the last time. As lambda is selected by 10-fold cross validation and the optimization is performed using simulated annealing, running BIR will take (number of lambdas to test) * (number of folds in the cross validation) * (number of seconds for simulated annealing). In the current implementation, this means 10 lambdas * 10 folds * 2 seconds.

# References:
* Adrien Bibal, Rebecca Marion, and Benoît Frénay. "Finding the most interpretable MDS rotation for sparse linear models based on external features." ESANN, 2018, 537-542.
* Rebecca Marion, Adrien Bibal, and Benoît Frénay. "BIR: A method for selecting the best interpretable multidimensional scaling rotation using external variables." Neurocomputing 342 (2019): 83-96.
