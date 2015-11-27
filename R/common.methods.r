setClassUnion(name = "h5arrayOrMatrix", members = c("h5array", "h5matrix"))
setMethod("dim",
          signature(x = "h5arrayOrMatrix"),
          function(x){
            f <- H5Fopen(x@file, flags = "H5F_ACC_RDONLY")
            d <- H5Dopen(f, x@location)
            s <- H5Dget_space(d)
            dims <- H5Sget_simple_extent_dims(s)$size
            H5Sclose(s)
            H5Dclose(d)
            H5Fclose(f)
            dims
          }
)

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
setGeneric("getGroup", function(object){standardGeneric("getGroup")})
setMethod("getGroup",
          "h5arrayOrMatrix",
          function(object){
            tmp <- strsplit(object@location, split = "/")[[1]]
            if(tmp[1] != ""){
              tmp <- c("", tmp)
            }
            paste(tmp[1:(length(tmp)-1)], collapse = "/")
          }
)
setMethod("apply",
          signature(X = "h5arrayOrMatrix", MARGIN = "numeric", FUN = "function"),
          function(X, MARGIN, FUN, ...){
            #Code for MARGIN names taken from default apply function
            dn <- dimnames(X)
            if (is.character(MARGIN)) {
              if (is.null(dnn <- names(dn))) 
                stop("'X' must have named dimnames")
              MARGIN <- match(MARGIN, dnn)
              if (anyNA(MARGIN)) 
                stop("not all elements of 'MARGIN' are names of dimensions")
            }
            accessor <- array(vector(mode="list", length = 1L), c(3, prod(dim(X)[MARGIN]))) # number of elements in the return value
            sapply(MARGIN, function(margin){
              sapply(seq(dim(X)[margin]), function(idx){
                idxList <- accessor
                idxList[[margin]] <- idx
                tmp <- h5read(X@file, X@location, index = idxList)
                dim(tmp) <- dim(tmp)[dim(tmp) != 1] #dropping dims of length 1, this should be controllable by an argument
                FUN(tmp, ...)
              })
            })
          })

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
# setGeneric("loadDimnamesFromFile", function(object){standardGeneric("loadDimnamesFromFile")})
# setMethod("loadDimnamesFromFile",
#           "h5arrayOrMatrix",
#           function(x){
#             dn <- lapply(seq(length(dim(x))), function(i){
#               h5read(file = getFileName(x), name = paste( getGroup(x), paste0("dim", i), sep = "/"))
#             }
#             x@dimnames <- dn
#           })
# setGeneric("writeDimnamesToFile", function(object){standardGeneric("writeDimnamesToFile")})
# setMethod("writeDimnamesToFile",
#           "h5arrayOrMatrix",
#           function(x){
#             for(i in seq(length(dim(x)))){
#               h5write(x@dimnames[[i]], file = getFileName(x), name = paste( getGroup(x), paste0("dim", i), sep = "/"))
#             }
#           })
setMethod("print","h5arrayOrMatrix",function(x){
  show(x)
})