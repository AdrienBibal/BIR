GetMSEPred <- function(Fe, X, transformation.matrix, W.est) {
  
  (1/(2*nrow(X)*ncol(X)))*sum((X%*%transformation.matrix - as.matrix(Fe)%*%W.est)^2)
  
}
 