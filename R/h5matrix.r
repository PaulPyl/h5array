setClass("h5matrix", representation(
  file = "character",
  location = "character",
  dimnames = "listOrNULL"
),
prototype(
  file = tempfile(),
  location = "Data",
  dimnames = NULL
))

h5matrix <- function( fn, location ){
  stopifnot(file.exists(fn)) # Need more sanity checks here
  ret = new("h5matrix", file = fn, location = location)
  stopifnot(length(dim(ret)) == 2) #Matrix has exactly two dimensions
  return(ret)
}

h5matrixCreate <- function( fn, location, dim, storage.mode, ... ){
  stopifnot(length(dim) == 2) #Matrix has exactly two dimensions
  if(!file.exists(fn)){
    h5createFile(fn)
  }
  h5createDataset(fn, location, dims = dim, storage.mode = storage.mode, ...)
  new("h5matrix", file = fn, location = location)
}