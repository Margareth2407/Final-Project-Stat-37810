library(rattle) #import data
library(fpc) #import plot
data(wine)

mywine <- as.matrix(wine[,-1]) # remove the existing clustering

cluster <- function(data){ #declare function
  nrows <- length(data[,1]) #create variable with number of rows of data
  ncols <- length(data[1,]) #create variable with number of columns of data
  iterations <- 20
  
  means <- data[sample(1:nrows,3),] #select rows from the original data set to serve as the initial means/centers
  for(i in 1:iterations){ #for loop for each of the iterations of reassigning the means
    distances <- matrix(rep(0,3*nrows),nrow = nrows) #distances matrix initialized
    mindistances <- matrix(rep(0, 2*nrows), nrow = nrows) #mindistances matrix initialized
    for(j in 1:nrows){ #for each row
      for(k in 1:3){ #for each cluster
        distances[j,k] <- sum((data[j,]-means[k,])^2) 
        #finds the difference between the row j and the mean ascribed to cluster K
      }
      mindistances[j,] <- c(min(distances[j,]), which.min(distances[j,])) 
      #finds the minimum distance for each row amongst the three clusters and assigns it to mindistances
      # in the first column and the second column has the cluster
    }
    for(l in 1:3){ #for each cluster
      datarows <- data[mindistances[,2]==l,] #selects the data corresponding to each of the clusters
      means[l,] <- colMeans(data[mindistances[,2]==l,])
      #the above line takes the mean of each column and stores them as the new means vector
    }
  }
  return(list(means, mindistances)) #returns means and mindistances
}

sort_cluster <- function(datums){

results <- cluster(datums) #runs function defined above



a <- results[[2]][1,2] #creates a dummy variable "a" to first type of cluster
b <- results[[2]][min(which(results[[2]][,2] != a)),2]
#creates a dummy variable "b" to second type of cluster
c <- 6 - a - b 
#creates a dummy variable "c" to third type of cluster

#the below block reassings the 1s and 2s to -1s and -2s in order to 
#better compare with the established clustering that was removed from the data set
results[[2]][results[[2]][,2] == a,2] <- -1
results[[2]][results[[2]][,2] == b,2] <- -2
results[[2]][results[[2]][,2] == c,2] <- 3
results[[2]][results[[2]][,2] == -1,2] <- 1
results[[2]][results[[2]][,2] == -2,2] <- 2

return(results) #returns results

}

results <- sort_cluster(mywine) 
plotcluster(mywine, results[[2]][,2]) #plots clusters
sum(wine[,1] == results[[2]][,2]) #checks to what degree our code and the
#previous clustering actually agree