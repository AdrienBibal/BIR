RunBIR <- function(X, Fe, lambda, n.sec = 2){
  set.seed(8222)
  BIR.sol <- GenSA(par = 0, 
                   fn = BIRFunction2d(X = Fe,
                                      Y = X,
                                      lambda = lambda), 
                   lower = c(0), 
                   upper = c(pi), 
                   control = list(max.time = n.sec))
  
  BIR.angle <- BIR.sol$par
  BIR.obj <- BIR.sol$value
  
  Lasso.sol <- GetWLasso(X = Fe, Y = X, theta = BIR.angle, lambda = lambda)
  
  return(list(R = Rot(BIR.angle), W = Lasso.sol$W, R_squared = Lasso.sol$R_squared))
  
}