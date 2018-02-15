library(h5array)
context("Hashing Dimnames")

test_that("hashed and unhashed dimnames match", {
  #Test Data
  tmp <- h5matrixCreate(fn = tempfile(), location = "/Test", dim = c(1000, 1000), storage.mode = "double", chunk = c(10,1000))
  #Populate with some values
  for(i in seq(1, 1000, 10)){
    tmp[i:(i+9)] <- matrix(rnorm(10000), nrow = 10)
  }
  #Assign dimnames
  rownames(tmp) <- paste0("row_", 1:1000)
  colnames(tmp) <- paste0("col_", 1:1000)
  #Hash the dimnames
  tmpHashed <- hashDimnames(tmp)
  #Testing
  testRows = sample(rownames(tmp), 10)
  testCols = sample(colnames(tmp), 10)
  tmpRows = match(testRows, rownames(tmp))
  names(tmpRows) <- testRows
  tmpCols = match(testCols, colnames(tmp))
  names(tmpCols) <- testCols
  expect_equal(tmpRows, values(hashedRownames(tmpHashed)[testRows])[testRows])
  expect_equal(tmpCols, values(hashedColnames(tmpHashed)[testCols])[testCols])
})

test_that("making and index based on hashed dimnames works", {
  #Test Data
  tmp <- h5matrixCreate(fn = tempfile(), location = "/Test", dim = c(1000, 1000), storage.mode = "double", chunk = c(10,1000))
  #Populate with some values
  for(i in seq(1, 1000, 10)){
    tmp[i:(i+9)] <- matrix(rnorm(10000), nrow = 10)
  }
  #Assign dimnames
  rownames(tmp) <- paste0("row_", 1:1000)
  colnames(tmp) <- paste0("col_", 1:1000)
  #Hash the dimnames
  tmpHashed <- hashDimnames(tmp)
  #Testing
  testRows = sample(rownames(tmp), 10)
  testCols = sample(colnames(tmp), 10)
  tmpRows = match(testRows, rownames(tmp))
  names(tmpRows) <- testRows
  tmpCols = match(testCols, colnames(tmp))
  names(tmpCols) <- testCols
  expect_equal(makeIndex(tmp, i = names(tmpRows), j = names(tmpCols), theDots = NULL), makeIndex(tmpHashed, i = names(tmpRows), j = names(tmpCols), theDots = NULL))
  expect_equal(makeIndex(tmp, i = tmpRows, j = tmpCols, theDots = NULL), makeIndex(tmpHashed, i = tmpRows, j = tmpCols, theDots = NULL))
  expect_equal(makeIndex(tmp, i = tmpRows, j = tmpCols, theDots = NULL), makeIndex(tmp, i = names(tmpRows), j = names(tmpCols), theDots = NULL))
})