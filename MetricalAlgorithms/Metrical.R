colors <- c("setosa" = "red", "versicolor" = "green3", "virginica" = "blue")

#Функция отрисовки набора
plotIris <- function(ir=iris,label="Классификация"){
  plot(ir[, 3:4], pch = 21, bg = colors[ir$Species], col = colors[ir$Species],
       xlab="Длина лепестка",ylab="Ширина лепестка",main=label)
}

#Функция метрики
eDist <- function(u, v) {
  sqrt(sum((u - v)^2))
}

#Функция определения класса при помощи алгоритма 1NN
FNN <- function(x,z){
  m <- dim(x)[1]
  n <- dim(x)[2] - 1
  print(m)
  print(n)
  dist <- matrix(NA, m, n)
  for (i in m:1)  dist[i,] <- c(i, eDist(x[i,1:n], z))
  return (x[order(dist[,2])[1],n+1]);
}

#Функция определения класса при помощи алгоритма KNN
KNN <- function(x,z,k=6){
  m <- dim(x)[1]
  n <- dim(x)[2] - 1
  dist <- matrix(NA, m, n)
  for (i in m:1)  dist[i,] <- c(i, eDist(x[i,1:n], z))
  classes <- x[order(dist[,2])[1:k],n+1]
  class <- names(which.max(table(classes)))
  return(class)
}

#Функция определения класса при помощи алгоритма KWNN
KWNN <- function(x,z,k=6,w=0.5){
  m <- dim(x)[1]
  n <- dim(x)[2] - 1
  dist <- matrix(NA, m, n)
  for (i in m:1)  dist[i,] <- c(i, eDist(x[i,1:n], z))
  ordered <- x[order(dist[,2])[1:k],]
  classes <- names(table(ordered[,n+1]))
  rang <- rep(0,length(classes))
  for(i in 1:k) rang[ordered[i,3]] <- rang[ordered[i,n+1]] + w^i
  class <- classes[which.max(rang)]
  return(class)
}

#Функция отрисовки объекта, классифицированного при помощи алгоритма 1NN
plotFNN <- function(z1,z2,x=iris){
  points(z1, z2, pch = 21, col = colors[FNN(x[,3:5],c(z1,z2))])
}

#Функция отрисовки объекта, классифицированного при помощи алгоритма KNN
plotKNN <- function(z1,z2,x=iris,k=6){
  points(z1, z2, pch = 21, col = colors[KNN(x[,3:5],c(z1,z2),k)])
}


#Функция отрисовки объекта, классифицированного при помощи алгоритма KWNN
plotKWNN <- function(z1,z2,x=iris,k=6,w=0.5){
  points(z1, z2, pch = 21, col = colors[KWNN(x[,3:5],c(z1,z2),k,w)])
}

#Функция возвращает случайный набор ирисов Фишера заданной длины
sampleIris <- function(count=15){
  t <- intersect(iris[,3:5],iris[3:5])
  listIndex <- sample(rownames(t),count)
  return(iris[listIndex,])
}

#Функция отрисовки карты классификации алгоритма 1NN
classMapFNN <- function(ir=iris){
  for (i in seq(0,7,0.1)) {
    for (j in seq(0,2.5,0.1)){
      plotFNN(i,j,ir)
    }
  }
}

#Функция отрисовки карты классификации алгоритма KNN
classMapKNN <- function(ir=iris,k=6){
  for (i in seq(0,7,0.1)) {
    for (j in seq(0,2.5,0.1)){
      plotKNN(i,j,ir,k)
    }
  }
}

#Функция отрисовки карты классификации алгоритма KWNN
classMapKWNN <- function(ir=iris,k=6,w=0.5){
  for (i in seq(0,7,0.1)) {
    for (j in seq(0,2.5,0.1)){
      plotKWNN(i,j,ir,k)
    }
  }
}
#Функция отрисовка графика оценки точности алгоритма KNN при помощи скользящего контроля
LOOKNN <- function(x){
  len <- dim(x)[1]
  n <- dim(x)[2]-1
  mark <- rep(0,len)
  for(i in 1:len){
    x1 <- x[-i,]
    x1_m <- dim(x1)[1]
    dist <- matrix(NA, x1_m, n)
    for (j in x1_m:1){
      dist[j,] <- c(j, eDist(x1[j,1:n], x[i,1:n]))
    }  
    ordered <- order(dist[,2])
    for(k in 1:len){
      classes <- x[ordered[1:k],n+1]
      class <- names(which.max(table(classes)))
      if(class != x[i,n+1]) {
        mark[k] <- mark[k] + 1/len
      }
    }
  }
  print(mark)
  print(which.min(mark))
  min_point <- c(which.min(mark), round(min(mark),4))
  text <- paste("k=",min_point[1],"\nLOO=",min_point[2],sep="")
  plot(mark,type = "l",main = "LOO(k) алгоритма KNN",xlab = "k", ylab="оценка")
  points(min_point[1], min_point[2]+0.01, pch=19, col="black", bg="black")
  text(min_point[1]+5,min_point[2]+0.1,labels=text)
}
#Функция отрисовка графика оценки точности алгоритма KWNN при помощи скользящего контроля
LOOKWNN <- function(x, k=6){
  m <- dim(x)[1]
  n <- dim(x)[2]-1
  q <- seq(0.05,0.95,0.05)
  len <- length(q)
  mark <- rep(0,len)
  for(i in 1:m){
    x1 <- x[-i,]
    x1_m <- dim(x1)[1]
    dist <- matrix(NA, x1_m, n)
    for (j in x1_m:1){
      dist[j,] <- c(j, eDist(x1[j,1:n], x[i,1:n]))
    }  
    ordered <- x1[order(dist[,2])[1:k],]
    classes <- names(table(ordered[,n+1]))
    for(w in 1:len){
      rang <- rep(0,length(classes))
      for(j in 1:k) rang[ordered[j,n+1]] <- rang[ordered[j,n+1]] + w^q[j]
      class <- classes[which.max(rang)]
      if(class != x[i,n+1]) {
        mark[w] <- mark[w] + 1/m
      }
    }
  }
  min_point <- c(q[which.min(mark)], round(min(mark),4))
  text <- paste("k=",k," q=",min_point[1],"\nLOO=",min_point[2],sep="")
  print(mark)
  print(which.min(mark))
  plot(q,mark,type = "l",main = "LOO(k,q) алгоритма KWNN",xlab = "q", ylab="оценка")
  points(min_point[1], min_point[2], pch=19, col="black", bg="black")
  text(min_point[1]+0.06,min_point[2]+0.0026,labels=text)
}

#Функция возвращает отступы выборки, используя алгоритм KWNN
marginKWNN <- function(x,k=6,w=0.5){
  m <- dim(x)[1]
  n <- dim(x)[2]-1
  margin <- rep(NA,m)
  for(j in 1:m){
    x1 <- x[-j,]
    m1 <- dim(x1)[1]
    dist <- matrix(NA, m1, n)
    for (i in m1:1)  dist[i,] <- c(i, eDist(x1[i,1:n], x[j,1:n]))
    ordered <- x1[order(dist[,2])[1:k],]
    classes <- names(table(ordered[,n+1]))
    rang <- rep(0,length(classes))
    for(i in 1:k) rang[ordered[i,n+1]] <- rang[ordered[i,n+1]] + w^i
    class1 <- x[j,n+1]
    margin[j] <- rang[class1] - max(rang[which(classes != class1)])
  }
  return(margin)
}

#listIrises <- read.table("/users/Duke/AnotherProjects/R/MetricalAlgorithms/iris_1")
#plotIris(iris, "Карта классификации 1NN")
#classMapFNN(iris)

#LOOKNN(iris[,3:5])
#plotIris(iris, "Карта классификации KNN, k=6")
#classMapKNN(iris)
knn <- par(mfrow=c(1,2))
LOOKWNN(iris[,3:5])
plotIris(iris, "Карта классификации KWNN, k=6, q=0.5")
classMapKWNN(iris)
par(knn)
