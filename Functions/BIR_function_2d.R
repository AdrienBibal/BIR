BIRFunction2d <- function(X, Y, lambda){
  
  Get2dBIRObjTheta <- function(theta){
    W.est <- GetWLasso(X, Y, theta, lambda)$W
    Get2dBIRObj(X, Y, theta, W.est, lambda)
  }
  
  Get2dBIRObjTheta
}
