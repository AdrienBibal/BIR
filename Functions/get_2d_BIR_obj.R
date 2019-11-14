Get2dBIRObj <- function(X, Y, theta, W.est, lambda){
  W.est <- as.matrix(W.est)
  
  LS <- (1/(2*nrow(X)))*sum((Y%*%Rot(theta) - as.matrix(X)%*%W.est)^2)
  L0 <- (sum(sign(abs(W.est[,1])))+sum(sign(abs(W.est[,2]))))
  LS + lambda*L0
}