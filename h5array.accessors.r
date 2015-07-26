# Quite some gymnastics to get the arguments right given the default signature of "["
# I would hope there is a more elegant way of replacing any missing argument with a NULL in the index and making sure that the dimensions fit :(
setMethod("[",
          signature(x = "h5array", i = "ANY", j = "ANY"),
          function(x, i = NULL, j = NULL, ..., drop = TRUE){
            symbols <- sapply(dots(...), deparse)
            if(length(symbols) + 2 != length(dim(x))){
              stop("incorrect number of dimensions")
            }
            theDots <- dots(...)
            idx <- c( list(i,j), lapply(seq_along(theDots), function(argPos){
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
          function(x, i = NULL, j = NULL, ..., value){
            symbols <- sapply(dots(...), deparse)
            if(length(symbols) + 2 != length(dim(x))){
              stop("incorrect number of dimensions")
            }
            theDots <- dots(...)
            idx <- c( list(i,j), lapply(seq_along(theDots), function(argPos){
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

setGeneric("getFileName", function(object){standardGeneric("getFileName")})
setMethod("getFileName",
          "h5arrayOrMatrix",
          function(object){return(object@file)}
          )

setGeneric("getLocation", function(object){standardGeneric("getLocation")})
setMethod("getLocation",
          "h5arrayOrMatrix",
          function(object){return(object@location)}
          )
setMethod("typeof",
          "h5arrayOrMatrix",
          function(x){
            return(typeof(h5read(getFileName(x), getLocation(x), index = lapply(dim(x), function(i) 1))))
          })
setMethod("dimnames<-",
          "h5arrayOrMatrix",
          function(x, value){
            if(any(sapply(value[!sapply(value, is.null)], length) != dim(x)[!sapply(value, is.null)])){
              stop("Dimnames must have the same shape as the array!")
            }
            x@dimnames <- value
            x
          })
setMethod("dimnames",
          "h5arrayOrMatrix",
          function(x){
            x@dimnames
          })
setMethod("print","h5arrayOrMatrix",function(x){
  show(x)
})

setMethod("show","h5array",function(object){
  lapply(list(
      paste("HDF5-backed Array\nType:", typeof(object)), "\n",
      paste("Dimensions:", paste(dim(object), collapse=", ")), "\n",
      paste("File:", getFileName(object)), "\nData:\n"
  ), cat)
  print(head(object))
})