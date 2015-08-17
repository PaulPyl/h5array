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