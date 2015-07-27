# h5array
HDF5 back-end for array and matrix datastructures in R

This package desfines two datastructures with a HDF5 backend for use within R.

The `h5matrix` class defines objects that behave like 2D matrices and can be used in normal R code.
The data itself is stored in an HDF5 file on disk and retrieved when requested.

The `h5array` class defines an array like object with the same properties, the main difference is that `h5array`s can have 
arbitrary dimensions, while `h5matrix` objects neccessarily have exactly two dimensions. The `h5array` is therefore more flexible but requires a bit more boilerplate code in the accessors (e.g. the `"["`-operator) to work.
If you know that your data is twodimensional, use the `h5matrix` class.

Example of usage
```{r}
y <- h5arrayCreate(tempfile(), "StringData", c(10,3,2), "character", size = 10)
dimnames(y) <- list(letters[1:10], letters[1:3], c("First", "Second"))

y[,,] <- "SomeText"

head(y)

z <- h5matrixCreate(tempfile(), "Matrix", c(1000, 120), "double")
dimnames(z) <- list(paste0("Row", 1:1000), paste0("Column", 1:120))

z[,] <- matrix(rnorm(1000*120), ncol = 120)

head(z)
```
