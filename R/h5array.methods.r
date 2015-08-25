# Quite some gymnastics to get the arguments right given the default signature of "["
# I would hope there is a more elegant way of replacing any missing argument with a NULL in the index and making sure that the dimensions fit :(
setMethod("[",
          signature(x = "h5array", i = "ANY", j = "ANY"),
          function(x, i, j, ..., drop = TRUE){
            symbols <- sapply(dots(...), deparse)
            if(length(symbols) + 2 != length(dim(x))){
              stop("incorrect number of dimensions")
            }
            theDots <- dots(...)
            idx <- vector("list", 2)
            if(!missing(i)){
              idx[[1]] <- i
            }else{
              i <- NULL
            }
            if(!missing(j)){
              idx[[2]] <- j
            }else{
              j <- NULL
            }
            idx <- c( idx, lapply(seq_along(theDots), function(argPos){
              if(symbols[argPos] != character(1L)){
                eval(theDots[[argPos]])
              }else{
                NULL
              }
            }) )[seq(length(dim(x)))]
            ret <- h5read(x@file, x@location, index = idx)
            dimnames(ret) <- lapply(seq_along(dim(x)), function(theDim){
              tmp <- dimnames(x)[[theDim]]
              if(is.null(idx[[theDim]])){
                tmp
              }else{
                tmp[idx[[theDim]]]
              }})
            ret
          })

setGeneric("getData",
           function(x, ...)
             standardGeneric("getData")
)
setMethod("getData",
          signature(x = "h5array"),
          function(x, ...){
            idx <- list(...)
            if(length(idx) != length(dim(x))){
              stop("incorrect number of dimensions")
            }
            ret <- h5read(x@file, x@location, index = idx)
            dimnames(ret) <- lapply(seq_along(dim(x)), function(theDim){
              dimnames(x)[[theDim]][idx[[theDim]]]
              })
            ret
          })

setMethod("[<-",
          signature(x = "h5array", i = "ANY", j = "ANY"),
          function(x, i, j, ..., value){
            symbols <- sapply(dots(...), deparse)
            if(length(symbols) + 2 != length(dim(x))){
              stop("incorrect number of dimensions")
            }
            theDots <- dots(...)
            idx <- vector("list", 2)
            if(!missing(i)){
              idx[[1]] <- i
            }else{
              i <- NULL
            }
            if(!missing(j)){
              idx[[2]] <- j
            }else{
              j <- NULL
            }
            idx <- c( idx, lapply(seq_along(theDots), function(argPos){
              if(symbols[argPos] != character(1L)){
                eval(theDots[[argPos]])
              }else{
                NULL
              }
            }) )[seq(length(dim(x)))]
            if(is.null(dim(value))){ #Only one value was specified
              vdim <- dim(x)
              vdim[!sapply(idx, is.null)] <- sapply(idx[!sapply(idx, is.null)], length)
              vsize <- Reduce(function(a,b) a*b, vdim)
              if(vsize > 1e4){
                message(paste(
                  "Single value assignment used on a large slice (",
                  vsize,
                  " elements), this might be memory intensive and take a long time. Consider writing in chunks instead.", sep = ""))
              }
              value <- array(value, vdim)
            }
            h5write(value, file = x@file, name = x@location, index = idx)
            return(x)
          })

setMethod("show","h5array",function(object){
  lapply(list(
      paste("HDF5-backed Array\nType:", typeof(object)), "\n",
      paste("Dimensions:", paste(dim(object), collapse=", ")), "\n",
      paste("File:", getFileName(object)), "\nHead of Data:\n"
  ), cat)
  print(head(object))
})

setMethod("head","h5array",function(x){
  nrow = dim(x)[[1]]
  ncol = dim(x)[[2]]
  if(nrow > 6){
    rows <- 1:6
  }else{
    rows <- seq(nrow)
  }
  if(ncol > 6){
    cols <- 1:6
  }else{
    cols <- seq(ncol)
  }
  arglist <- c( list(getData, x, rows, cols), as.list(rep(1, length(dim(x)) - 2)) )
  eval(as.call(arglist))
})