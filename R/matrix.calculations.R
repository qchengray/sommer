matrix.trace <- function(x){
  if (!is.square.matrix(x)) 
    stop("argument x is not a square matrix")
  return(sum(diag(x)))
}

is.diagonal.matrix <- function (x, tol = 1e-08){
  y <- x
  diag(y) <- rep(0, nrow(y))
  return(all(abs(y) < tol))
}

is.square.matrix <-function(x){
  return(nrow(x) == ncol(x))
}

hadamard.prod <-function (x, y){
  if (!is.numeric(x)) {
    stop("argument x is not numeric")
  }
  if (!is.numeric(y)) {
    stop("argument y is not numeric")
  }
  if (is.matrix(x)) {
    Xmat <- x
  }
  else {
    if (is.vector(x)) {
      Xmat <- matrix(x, nrow = length(x), ncol = 1)
    }
    else {
      stop("argument x is neither a matrix or a vector")
    }
  }
  if (is.matrix(y)) {
    Ymat <- y
  }
  else {
    if (is.vector(y)) {
      Ymat <- matrix(y, nrow = length(x), ncol = 1)
    }
    else {
      stop("argument x is neither a matrix or a vector")
    }
  }
  if (nrow(Xmat) != nrow(Ymat)) 
    stop("argumentx x and y do not have the same row order")
  if (ncol(Xmat) != ncol(Ymat)) 
    stop("arguments x and y do not have the same column order")
  return(Xmat * Ymat)
}


adiag1 <- function (..., pad = as.integer(0), do.dimnames = TRUE){
  args <- list(...)
  if (length(args) == 1) {
    return(args[[1]])
  }
  if (length(args) > 2) {
    jj <- do.call("Recall", c(args[-1], list(pad = pad)))
    return(do.call("Recall", c(list(args[[1]]), list(jj), 
                               list(pad = pad))))
  }
  a <- args[[1]]
  b <- args[[2]]
  if (is.null(b)) {
    return(a)
  }
  if (is.null(dim(a)) & is.null(dim(b))) {
    dim(a) <- rep(1, 2)
    dim(b) <- rep(1, 2)
  }
  if (is.null(dim(a)) & length(a) == 1) {
    dim(a) <- rep(1, length(dim(b)))
  }
  if (is.null(dim(b)) & length(b) == 1) {
    dim(b) <- rep(1, length(dim(a)))
  }
  if (length(dim.a <- dim(a)) != length(dim.b <- dim(b))) {
    stop("a and b must have identical number of dimensions")
  }
  s <- array(pad, dim.a + dim.b)
  s <- do.call("[<-", c(list(s), lapply(dim.a, seq_len), list(a)))
  ind <- lapply(seq(dim.b), function(i) seq_len(dim.b[[i]]) + 
                  dim.a[[i]])
  out <- do.call("[<-", c(list(s), ind, list(b)))
  n.a <- dimnames(a)
  n.b <- dimnames(b)
  if (do.dimnames & !is.null(n.a) & !is.null(n.b)) {
    dimnames(out) <- mapply(c, n.a, n.b, SIMPLIFY = FALSE)
    names(dimnames(out)) <- names(n.a)
  }
  return(out)
}