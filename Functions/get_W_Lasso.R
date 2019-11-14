GetWLasso = function(X, Y, theta = 0, lambda){
  require(glmnet)
  
  W <- sapply(1:(ncol(Y)), function(k) {
    glmnet(x = as.matrix(X), y = Y[, k], intercept = F, lambda = c(100,lambda), family = "gaussian", standardize = F)$beta[, 2]})
  
  R_squared <- sapply(1:(ncol(Y)), function(i){ 
    pred <- sum((as.matrix(X)%*%W[,i] - Y[,i])^2)
    var.y <- sum((Y[,i] - mean(Y[,i]))^2)
    
    return(1 - (pred/var.y))
    })
    
  return(list(W=W, R_squared=R_squared))
}