require(GenomicRanges)

setMethod("assay<-", #For some reason this function needs to exists to prevent errors, but I don't do anything in it.
          signature("SummarizedExperiment", "ANY", "h5arrayOrMatrix"),
          function(x, i, value){
            #print("assay<- called")
            return(x)
          })

x <- h5matrixCreate(tempfile(), "Data", c(4,10), "double")
colnames(x) <- letters[1:10]

se <- SummarizedExperiment(list(x))
assay(se)
assay(se)[2,] <- rnorm(10)

assays(se)[[1]]
assays(se)[[1]][3,] <- rpois(10, 23)

x
apply(assay(se), 1, summary)
