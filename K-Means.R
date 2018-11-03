library(rattle)
library(fpc)
data(wine)

mywine <- as.matrix(wine[,-1])

cluster <- function(data){
  nrows <- length(data[,1])
  ncols <- length(data[1,])
  iterations <- 20
  
  means <- data[sample(1:nrows,3),]
  for(i in 1:iterations){
    distances <- matrix(rep(0,3*nrows),nrow = nrows)
    mindistances <- matrix(rep(0, 2*nrows), nrow = nrows)
    for(j in 1:nrows){
      for(k in 1:3){
        distances[j,k] <- sum((data[j,]-means[k,])^2)
      }
      mindistances[j,] <- c(min(distances[j,]), which.min(distances[j,]))
    }
    for(l in 1:3){
      datarows <- data[mindistances[,2]==l,]
      means[l,] <- (1/length(mindistances[mindistances[,2] == l,1]))*colSums(data[mindistances[,2]==l,])
    }
  }
  return(list(means, mindistances))
}

results <- cluster(mywine)

plotcluster(mywine, results[[2]][,2])

a <- results[[2]][1,2]
b <- results[[2]][min(which(results[[2]][,2] != a)),2]
c <- 6 - a - b

results[[2]][results[[2]][,2] == a,2] <- -1
results[[2]][results[[2]][,2] == b,2] <- -2
results[[2]][results[[2]][,2] == c,2] <- 3
results[[2]][results[[2]][,2] == -1,2] <- 1
results[[2]][results[[2]][,2] == -2,2] <- 2

sum(wine[,1] == results[[2]][,2])


