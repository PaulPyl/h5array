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