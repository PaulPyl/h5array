require(rhdf5)
require(pryr)
setClassUnion(name = "listOrNULL", members = c("list", "NULL"))

setClass("h5array", representation(
  file = "character",
  location = "character",
  dimnames = "listOrNULL"
  ),
  prototype(
  file = tempfile(),
  location = "Data",
  dimnames = NULL
  ))

h5array <- function( fn, location ){
  stopifnot(file.exists(fn)) # Need more sanity checks here
  new("h5array", file = fn, location = location)
}

h5arrayCreate <- function( fn, location, dim, storage.mode, ... ){
  if(!file.exists(fn)){
    h5createFile(fn)
  }
  h5createDataset(fn, location, dims = dim, storage.mode = storage.mode, ...)
  new("h5array", file = fn, location = location)
}

source("h5matrix.r")
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

setMethod("apply",
          signature(X = "h5arrayOrMatrix", MARGIN = "numeric", FUN = "function"),
          function(X, MARGIN, FUN, ...){
            accessor <- vector(mode = "list", length = length(dim(X)))
            lapply(seq(dim(X)[MARGIN]), function(idx){
              idxList <- accessor
              idxList[[MARGIN]] <- idx
              tmp <- h5read(X@file, X@location, index = idxList)
              FUN(tmp, ...)
            })
          })