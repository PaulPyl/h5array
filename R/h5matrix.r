setClassUnion(name = "listOrNULL", members = c("list", "NULL"))
setClass("h5matrix", representation(
  file = "character",
  location = "character",
  dimnames = "listOrNULL",
  hashedDimnames = "listOrNULL"
),
prototype(
  file = tempfile(),
  location = "Data",
  dimnames = NULL,
  hashedDimnames = NULL
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
  loc <- strsplit(x = location, split = "/")[[1]]
  if(length(loc) > 1){
    current = ""
    for(subloc in loc[1:(length(loc)-1)]){
      current = paste0( current, subloc, sep = "/")
      h5createGroup(fn, current)
    }
  }
  h5createDataset(fn, location, dims = dim, storage.mode = storage.mode, ...)
  new("h5matrix", file = fn, location = location)
}