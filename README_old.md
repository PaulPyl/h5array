# h5array
HDF5 back-end for array and matrix datastructures in R

This package desfines two datastructures with a HDF5 backend for use within R.

The `h5matrix` class defines objects that behave like 2D matrices and can be used in normal R code.
The data itself is stored in an HDF5 file on disk and retrieved when requested.

The `h5array` class defines an array like object with the same properties, the main difference is that `h5array`s can have 
arbitrary dimensions, while `h5matrix` objects neccessarily have exactly two dimensions. The `h5array` is therefore more flexible but requires a bit more boilerplate code in the accessors (e.g. the `"["`-operator) to work.
If you know that your data is twodimensional, use the `h5matrix` class.

## Installation

Installation from github is easiest using devtools.
```{r}
install.packages("devtools") # If you do not have it yet
require(devtools)
install_github("PaulPyl/h5array")
```

##Example of usage
```{r}
require(h5array)

y <- h5arrayCreate(tempfile(), "StringData", c(10,3,2), "character", size = 10)
dimnames(y) <- list(letters[1:10], letters[1:3], c("First", "Second"))

y[,,] <- "SomeText"

y

# HDF5-backed Array
# Type: character
# Dimensions: 10, 3, 2
# File: /var/folders/sh/nzrnpqxj3ndg9fh2qcvzzpfn62qz2p/T//Rtmpq9Px1t/file48da90f2224
# Head of Data:
# , , First
# 
#   a          b          c         
# a "SomeText" "SomeText" "SomeText"
# b "SomeText" "SomeText" "SomeText"
# c "SomeText" "SomeText" "SomeText"
# d "SomeText" "SomeText" "SomeText"
# e "SomeText" "SomeText" "SomeText"
# f "SomeText" "SomeText" "SomeText"
# 
# z <- h5matrixCreate(tempfile(), "Matrix", c(1000, 120), "double")
# dimnames(z) <- list(paste0("Row", 1:1000), paste0("Column", 1:120))

z[,] <- matrix(rnorm(1000*120), ncol = 120)

z

# HDF5-backed Matrix
# Type: double
# Dimensions: 1000, 120
# File: /var/folders/sh/nzrnpqxj3ndg9fh2qcvzzpfn62qz2p/T//Rtmpq9Px1t/file48da408a6e21
# Data:
#          Column1     Column2     Column3    Column4    Column5    Column6
# Row1 -0.56270685 -1.01663856  1.82527961  1.1461153  0.7306316  0.3961885
# Row2 -0.03695803  0.91514655 -0.03043276  0.5974649  0.6352517  0.1771278
# Row3  0.31497679 -1.44066819 -2.03284089 -1.4673467 -0.7354956 -0.4922019
# Row4  1.22607774 -0.06873158  0.16690851  1.5619424 -0.3662646 -1.5805695
# Row5 -1.90615942  0.78360002  0.14870436  1.5693273  0.5804664  0.1465883
# Row6 -2.24570981  0.64120473  1.40108435 -1.6828315  0.5747368 -0.3300932
```
