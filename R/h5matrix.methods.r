
setMethod("[",
          signature(x = "h5matrix", i = "ANY", j = "ANY"),
          function(x, i, j, ..., drop = TRUE){
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
            ret <- h5read(x@file, x@location, index = idx)
            if(is.null(i)){
              rownames(ret) <- dimnames(x)[[1]]
            }else{
              rownames(ret) <- dimnames(x)[[1]][idx[[1]]]
            }
            if(is.null(j)){
              colnames(ret) <- dimnames(x)[[2]]
            }else{
              colnames(ret) <- dimnames(x)[[2]][idx[[2]]]
            }
            ret
          })

setMethod("[<-",
          signature(x = "h5matrix", i = "ANY", j = "ANY"),
          function(x, i, j, ..., value){
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
            if(is.null(dim(value))){ #Only one value was specified
              vdim <- dim(x)
              vdim[!sapply(idx, is.null)] <- sapply(idx[!sapply(idx, is.null)], length)
              vsize <- vdim[[1]] * vdim[[2]]
              if(vsize > 1e6){
                message(paste(
                  "Single value assignment used on a large slice (",
                  vsize,
                  " elements), this might be memory intensive and take a long time.", sep = ""))
              }
              value <- array(value, vdim)
            }
            h5write(value, file = x@file, name = x@location, index = idx)
            return(x)
          })

setMethod("show","h5matrix",function(object){
  lapply(list(
    paste("HDF5-backed Matrix\nType:", typeof(object)), "\n",
    paste("Dimensions:", paste(dim(object), collapse=", ")), "\n",
    paste("File:", getFileName(object)), "\n"
  ), cat)
  cat("Data:\n")
  print(head(object))
})

setMethod("head","h5matrix",function(x){
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
  x[rows,cols]
})