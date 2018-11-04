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

results <- cluster(mywine) 
plotcluster(mywine, results[[2]][,2]) #plots clusters

require(data.table)
type_1 <-setkey(data.table((wine_cluster[wine_cluster$Type == 1,2:14])))
type_2 <-setkey(data.table((wine_cluster[wine_cluster$Type == 2,2:14])))
type_3 <-setkey(data.table((wine_cluster[wine_cluster$Type == 3,2:14])))
cluster_1 <-setkey(data.table((wine_cluster[wine_cluster$clusters == 1,2:14])))
cluster_2 <-setkey(data.table((wine_cluster[wine_cluster$clusters == 2,2:14])))
cluster_3 <-setkey(data.table((wine_cluster[wine_cluster$clusters == 3,2:14])))
cluster1_type1<-na.omit(cluster_1[type_1,which=TRUE])
cluster1_type2<-na.omit(cluster_1[type_2,which=TRUE])
cluster1_type3<-na.omit(cluster_1[type_3,which=TRUE])
cluster2_type1<-na.omit(cluster_2[type_1,which=TRUE])
cluster2_type2<-na.omit(cluster_2[type_2,which=TRUE])
cluster2_type3<-na.omit(cluster_2[type_3,which=TRUE])
cluster3_type1<-na.omit(cluster_3[type_1,which=TRUE])
cluster3_type2<-na.omit(cluster_3[type_2,which=TRUE])
cluster3_type3<-na.omit(cluster_3[type_3,which=TRUE])

method<-c(length(cluster1_type1),length(cluster1_type2),length(cluster1_type3),length(cluster2_type1),length(cluster2_type2),length(cluster2_type3),length(cluster3_type1),length(cluster3_type2),length(cluster3_type3))
matrix<-matrix(method,nrow = 3,ncol = 3, byrow=TRUE)
colnames(matrix) <- c("Type 1","Type 2","Type 3")
rownames(matrix) <- c("Cluster 1","Cluster 2","Cluster 3")
matrix