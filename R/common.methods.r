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
setGeneric("getDatasetName", function(object){standardGeneric("getDatasetName")})
setMethod("getDatasetName",
          "h5arrayOrMatrix",
          function(object){
            tmp <- strsplit(object@location, split = "/")[[1]]
            tmp[length(tmp)]
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
            #accessor <- array(vector(mode="list", length = 1L), c(3, prod(dim(X)[MARGIN]))) # number of elements in the return value
            accessor <- vector(mode="list", length = length(dim(X)))
            accessor[MARGIN] <- 1
            #res <- array(FUN(h5read(X@file, X@location, index = accessor)), dim = dim(X)[MARGIN])
            res <- vector(mode = class(FUN(h5read(X@file, X@location, index = accessor))), length = prod(dim(X)[MARGIN]))
            accessor <- vector(mode="list", length = length(dim(X)))
            resDim <- dim(X)[MARGIN]
            #BEGIN: slow looping implementation of apply ... move to chunks?
            i = 1
            while(i <= length(res)){
              idxList <- accessor
              idxList[MARGIN] <- as.vector(arrayInd(i, resDim))
              tmp <- h5read(X@file, X@location, index = idxList)
              dim(tmp) <- dim(tmp)[dim(tmp) != 1] #dropping dims of length 1, this should be controllable by an argument
              res[i] <- FUN(tmp, ...)
              i <- i + 1
            }
            array(res, dim = resDim)
          })

setMethod("typeof",
          "h5arrayOrMatrix",
          function(x){
            return(typeof(h5read(getFileName(x), getLocation(x), index = lapply(dim(x), function(i) 1))))
          })
setMethod("dimnames<-",
          "h5arrayOrMatrix",
          function(x, value){
            x@dimnames <- value
            x
          })
setMethod("dimnames",
          "h5arrayOrMatrix",
          function(x){
            x@dimnames
          })
setGeneric("loadDimnamesFromFile", function(x){standardGeneric("loadDimnamesFromFile")})
setMethod("loadDimnamesFromFile",
          "h5arrayOrMatrix",
          function(x){
            f <- H5Fopen(getFileName(x), flags = "H5F_ACC_RDONLY")
            if(getGroup(x) != ""){
              l <- H5Gopen(getGroup(x))
            }else{
              l <- f
            }
            dn <- lapply(seq(length(dim(x))), function(i){
              if(H5Lexists(l, paste(getDatasetName(x), paste0("dim", i), sep = "."))){
                suppressWarnings(h5read(file = getFileName(x), name = paste(getLocation(x), paste0("dim", i), sep = "."))) #Quick-fix since we know that f is read-only and wont mess up things here
              }else{
                NULL
              }
            })
            H5close()
            x@dimnames <- dn
            x
          })
setGeneric("writeDimnamesToFile", function(x){standardGeneric("writeDimnamesToFile")})
setMethod("writeDimnamesToFile",
          "h5arrayOrMatrix",
          function(x){
            f <- H5Fopen(getFileName(x))
            if(getGroup(x) != ""){
              l <- H5Gopen(getGroup(x))
            }else{
              l <- f
            }
            for(i in seq(length(dim(x)))){
              if(!is.null(x@dimnames[[i]])){
                if(!H5Lexists(l, paste(getDatasetName(x), paste0("dim", i), sep = "."))){
                  suppressWarnings( #Ugly hack until I can migrate to internal H5-function calls :)
                    h5createDataset(
                      file = getFileName(x),
                      dataset = paste(getLocation(x), paste0("dim", i), sep = "."),
                      dims = c(length(x@dimnames[[i]])),
                      storage.mode = "character",
                      size = 100
                    )
                  )
                }
                suppressWarnings(h5write(x@dimnames[[i]], file = getFileName(x), name = paste(getLocation(x), paste0("dim", i), sep = ".")))
              }
            }
            H5close()
          })
setMethod("print","h5arrayOrMatrix",function(x){
  show(x)
})