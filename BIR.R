#######################################
#### Main function for BIR         ####
#######################################

rm(list = ls())

library(glmnet) # Lasso
library(pbapply)
library(GenSA) # simulated annealing

#### File paths ####

data.path <- "Datasets/"
out.path <- "Results/result.RData"
function.path <- "Functions/"

args <- commandArgs(TRUE)

source.files <- list.files(path = function.path, recursive = TRUE)
invisible(sapply(source.files, function(x) source(file = paste0(function.path, x))))

if (length(args) == 0) {
  # Default files for Fe and X
  Fe <- read.csv(paste0(data.path, "dataset.csv"))
  X <- read.csv(paste0(data.path, "embedding.csv"), header=F)
} else if (length(args) < 4) {
  stop("The number of inputs you provided is not enough. You should provide (in order) the path to the embedding, the path to the dataset for explaining the embedding and then the path to the output file.")
} else if (length(args) == 4) {
  # The order should be: embedding first and then the dataset used to explain the embedding
  X <- args[1]
  Fe <- args[2]
  out.path <- args[3]
} else {
  stop("You provided too many inputs.")
}

lambda.vals <- seq(0.0001, 3.5, length = 10)
# lambda.vals <- exp(seq(log(0.0001), log(3.5), length.out = 20))


#### Run BIR ####

# Prepare fold ids
seed <- 155000
set.seed(seed)

eval.res.lambda <- c()
lambda.vals.index = 0

# Beware, running BIR takes (# lambdas)*(# folds)*(2 seconds)
# In the current setup, this means 10*10*2 = 200 seconds = 3.3 minutes
for (lambda in lambda.vals) {
  lambda.vals.index <- lambda.vals.index + 1
  K <- 10 # number of folds for K-fold cross-validation
  # Split data row indexes randomly into K folds
  fold.ids <- suppressWarnings(split(sample(nrow(Fe)), seq(1, nrow(Fe), length = K)))
  
  eval.res.K <- c()
  for (index.fold in 1:K){
    # Process fold data
    fold.data <- ProcessFoldData(X = X, Fe = Fe, test.id = fold.ids[[index.fold]])
    
    # normalize lambda
    lambda.norm <- lambda/sqrt(ncol(fold.data$Fe.norm))
    
    # Get rotation matrix and weights
    res <- RunBIR(X = fold.data$X.norm, 
                  Fe = fold.data$Fe.norm,
                  lambda = lambda.norm)
    R <- res$R
    W <- res$W
    
    # Eval
    tmp <- Eval(R = R, W = W, 
                Fe.test = fold.data$Fe.test,
                X.test = fold.data$X.test)
    
    if (!is.na(tmp$MSE)) eval.res.K <- c(eval.res.K, tmp$MSE)
  }
  
  
  eval.res.lambda[[lambda.vals.index]] <- cbind.data.frame(lambda = lambda,
                                                           lambda.norm = lambda.norm,
                                                           avg_MSE = mean(eval.res.K))
}
eval.res.lambda <- do.call(rbind.data.frame, eval.res.lambda)

# Consider the lambda with the min avg_MSE
best_lambda.index <- which.min(eval.res.lambda$avg_MSE)
best_lambda.norm <- eval.res.lambda$lambda.norm[best_lambda.index]

# Some elements of Fe can have a standard deviation (sd) equal to 0, which is an issue when scaling.
# In ordre to solve the problem, the sd for these columns is set to 1.
Fe.sd <- apply(Fe, 2, sd) # Check which columns have sd = 0
zero.sd <- which(Fe.sd == 0)
if (length(zero.sd) > 0){
  Fe.sd[zero.sd] <- 1
}

# Compute BIR on the full dataset with the best lambda
res <- RunBIR(X = scale(X, center=T, scale=F), 
              Fe = scale(Fe, center=T, scale=Fe.sd),
              lambda = best_lambda.norm)

save(res, file = out.path)
