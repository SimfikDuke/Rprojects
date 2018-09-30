colors <- c("setosa" = "red", "versicolor" = "green3", "virginica" = "blue")

plotIris <- function(ir=iris){
  plot(ir[, 3:4], pch = 21, bg = colors[ir$Species], col = colors[ir$Species],
       xlab="Длина лепестка",ylab="Ширина лепестка",main="Классификация 1NN")
}

eDist <- function(u, v) {
  sqrt(sum((u - v)^2))
}

FNN <- function(x,z){
  m <- dim(x)[1]
  n <- dim(x)[2] - 1
  dist <- matrix(NA, m, n)
  for (i in m:1)  dist[i,] <- c(i, eDist(x[i,1:n], z))
  return (x[order(dist[,2])[1],n+1]);
}
plotFNN <- function(z1,z2,x=iris[,3:5]){
  points(z1, z2, pch = 21, col = colors[FNN(x,c(z1,z2))])
}
  
classMap <- function(ir=iris[,3:5]){
  for (i in 1:70) {
    for (j in 1:25){
      plotFNN(i/10,j/10,ir)
    }
  }
}

#Чтобы отрисовать карту классификации раскоментируйте следующие пять строчек
numberOfIrises <- 150
listIndex <- sample(1:150,numberOfIrises)
listIrises <- iris[listIndex,]
plotIris(listIrises)
classMap(listIrises)
