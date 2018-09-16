colors <- c("setosa" = "red", "versicolor" = "green3", "virginica" = "blue")
plotIris <- function(d1=3, d2=4)plot(iris[, d1:d2], pch = 21, bg = colors[iris$Species])
eDist <- function(u, v) sqrt(sum((u - v)^2))

FNN <- function(x,z){
  m <- dim(x)[1]
  d <- matrix(NA, m, 2)
  for (i in m:1)  d[i,] <- c(i, eDist(x[i,1:2], z))
  return (x[order(d[,2])[1],3]);
}
plotFNN <- function(z1,z2,x=iris[,3:5])
  points(z1, z2, pch = 23, bg = colors[FNN(x,c(z1,z2))], asp = 6)

plotIris(); plotFNN(3.5,2); plotFNN(2.5,0.6); plotFNN(6,1)