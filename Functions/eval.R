Eval <- function(R, W, Fe.test, X.test){
  
  # Find an optimal R and W
  MSE <- GetMSEPred(Fe = Fe.test, 
                        X = X.test,
                        transformation.matrix = R, 
                        W.est = W)
  
  perc.nonzero <- GetL0(W = W)/prod(dim(W))
  
  return(cbind.data.frame(MSE = MSE, perc.nonzero = perc.nonzero))
}