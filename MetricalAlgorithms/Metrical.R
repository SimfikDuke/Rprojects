#install.packages("plotrix")
require("plotrix")
colors <- c("setosa" = "red", "versicolor" = "green3", "virginica" = "blue", "unknown"="white")

#Функция отрисовки набора
plotIris <- function(ir=iris,label="Классификация"){
  plot(ir[, 3:4], pch = 21, bg = colors[ir$Species], col = colors[ir$Species],
       xlab="Длина лепестка",ylab="Ширина лепестка",main=label,asp = 1)
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
#Функция отрисовки объекта, классифицированного при помощи алгоритма parsen
plotParsen <- function(z1,z2,x=iris,h=0.35,K=kE){
  points(z1, z2, pch = 21, col = colors[parsen(x[,3:5],c(z1,z2),h,K)])
}

#Функция отрисовки объекта, классифицированного при помощи алгоритма потенциальных функций
plotPotentials <- function(z1,z2,x=iris,g,K=kQ,h=c()){
  col <- potentials(x[,3:5],c(z1,z2),g,K,h)
  if (col != "unknown"){
    points(z1, z2, pch = 21, col = colors[col])
  }
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

#Функция отрисовки карты классификации алгоритма parsen
classMapParsen <- function(ir=iris,h=2,K=kE){
  for (i in seq(0,7,0.1)) {
    for (j in seq(0,2.5,0.1)){
      plotParsen(i,j,ir,h,K)
    }
  }
}

#Функция отрисовки карты классификации алгоритма потенциальных функций
classMapPotentials <- function(ir=iris,g,h=c(),K=kQ){
  for (i in seq(0,7,0.1)) {
    for (j in seq(0,2.5,0.1)){
      plotPotentials(i,j,ir,g,K,h)
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
####################################################### 
# Функции ядер
kR <- function(z) 0.5 * (abs(z)<=1) # Прямоугольное
kT <- function(z) (1 - abs(z))*(abs(z)<=1) #  Треугольное
kQ <- function(z) (15/16)*(1 - z^2)^2 * (abs(z)<=1) # Квартическое
kE <- function(z) (3/4)*(1-z^2) * (abs(z)<=1) # Епанечникова
kG <- function(z) dnorm(z) # Гауссовское

#Парзеновское окно #h_opt: kR - 0.35; kT - 0.35, kQ - 0.35; kE - 0.35; kG - 0.1
parsen <- function(x, z, h, K){
  m <- dim(x)[1]
  n <- dim(x)[2]-1
  count_classes <- length(names(table(x[,n+1])))
  classes <- rep(0,count_classes)
  names(classes) <- names(table(x[,n+1]))
  for(i in 1:m){
    y <- x[i,n+1]
    dist <- eDist(x[i,1:n],z)
    w <- K(dist/h)
    classes[y] <- classes[y] + w
  }
  if(sum(classes) > 0) class <- names(which.max(classes))
  else class <- "unknown"
  return(class)
}
LOO_parsen <- function(x,K,labels="LOO для парзеновского окна"){
  m <- dim(x)[1]
  n <- dim(x)[2] - 1
  params <- seq(0.1,2,0.05)
  mark <- rep(0,length(params))
  for (h in 1:length(params)){
    for (i in 1:m){
      x1 <- x[-i,]
      class1 <- parsen(x1,x[i,1:n],params[h],K)
      class2 <- x[i,n+1]
      if (class1 != class2) mark[h] <- mark[h] + 1/m
    }
  }
  plot(params, mark, type="l",xlab="Ширина окна", ylab="Оценка", main=labels)
  min_point <- c(params[which.min(mark)], round(min(mark),4))
  text <- paste(" h=",min_point[1],"\nLOO=",min_point[2],sep="")
  points(min_point[1], min_point[2], pch=19, col="blue", bg="black")
  text(min_point[1]+0.05,min_point[2]+0.043,labels=text, col="blue")
}
#######################################################

#Демонстрация преимущества алгоритма взвешенных соседей
demonstration <- function(){
  demo_iris <- read.table("/users/Duke/AnotherProjects/R/MetricalAlgorithms/iris_demo")
  plotIris(demo_iris)
  demo_plot <- par(mfrow=c(1,2))
  demo_point <- c(1.8,0.4)
  plotIris(demo_iris, "Классификация точки с помощью kNN, k=7")
  plotKNN(demo_point[1],demo_point[2],demo_iris,k=7)
  text(demo_point[1]+0.58,demo_point[2], paste("class =",KNN(demo_iris[,3:5],demo_point,7)))
  plotIris(demo_iris, "Классификация точки с помощью kwNN, k=7, q=0.5")
  plotKWNN(demo_point[1],demo_point[2],demo_iris,k=7,w=0.5)
  text(demo_point[1]+0.48,demo_point[2], paste("class =",KWNN(demo_iris[,3:5],demo_point,7)))
  par(demo_plot)
}
# Оценка LOO и карты классификации для различных ядер
test_parsen_kernels <- function(){
  loo <- par(mfrow=c(1,2))
  LOO_parsen(iris[,3:5],kR)
  plotIris(iris,"Прямоугольное ядро h=0.35")
  classMapParsen(iris, 0.35, kR)
  par(loo)
  
  loo <- par(mfrow=c(1,2))
  LOO_parsen(iris[,3:5],kT)
  plotIris(iris,"Треугольное ядро h=0.35")
  classMapParsen(iris, 0.35, kT)
  par(loo)
  
  loo <- par(mfrow=c(1,2))
  LOO_parsen(iris[,3:5],kQ)
  plotIris(iris,"Квартическое ядро ядро h=0.35")
  classMapParsen(iris, 0.35, kQ)
  par(loo)
  
  loo <- par(mfrow=c(1,2))
  LOO_parsen(iris[,3:5],kE)
  plotIris(iris,"Ядро Епонечникова h=0.35")
  classMapParsen(iris, 0.35, kE)
  par(loo)
  
  loo <- par(mfrow=c(1,2))
  LOO_parsen(iris[,3:5],kG)
  plotIris(iris,"Ядро Гаусса h=0.1")
  classMapParsen(iris, 0.1, kG)
  par(loo)
}
####################################################### 
potentials <- function(x, z, g, K, h=c()){
  m <- dim(x)[1]
  n <- dim(x)[2]-1
  if (sum(h) == 0) h <- c(rep(1, m/3), rep(0.25, (m-m/3)))
  count_classes <- length(names(table(x[,n+1])))
  classes <- rep(0,count_classes)
  names(classes) <- names(table(x[,n+1]))
  for(i in 1:m){
    y <- x[i,n+1]
    dist <- eDist(x[i,1:n],z)
    w <- K(dist/h[i]) * g[i]
    classes[y] <- classes[y] + w
  }
  if(sum(classes) > 0) class <- names(which.max(classes))
  else class <- "unknown"
  return(class)
}

set_error <- function(x,g,K,h){
  err <- 0
  m <- dim(x)[1]
  n <- dim(x)[2]-1
  for(i in 1:m){
    class1 <- potentials(x,x[i,1:n],g,K,h)
    class2 <- x[i,n+1]
    if(class1!=class2){
      err <- err + 1
    } 
  }
  print(err)
  return(err)
}

find_gamma <- function(x,K=kE,h=c(),delta=10){
  m <- dim(x)[1]
  n <- dim(x)[2]-1
  if (sum(h) == 0) h <- c(rep(1, m/3), rep(0.25, (m-m/3)))
  g <- rep(0,m)
  i <- 1
  while(set_error(x,g,K,h)>delta){
    class1 <- potentials(x,x[i,1:n],g,K,h)
    class2 <- x[i,n+1]
    if(class1 != class2) g[i] <- g[i] + 1
    i <- ((40+sample(1:110,1)[1])%%m)+1
  }
  return(g)
}
####################################################### 
#listIrises <- read.table("/users/Duke/AnotherProjects/R/MetricalAlgorithms/iris_1")
#plotIris(iris, "Карта классификации 1NN")
#classMapFNN(iris)
#loo <- par(mfrow=c(1,2))
#plotIris(iris, "Карта классификации KWNN, k=6, q=0.5")
#classMapKWNN(iris)
#plotIris(iris,"Карта классификации парзеновского окна. Ядро Гаусса, h=0.1")
#classMapParsen(iris, 0.1, kG)
#par(loo)
#plotIris(iris, "Карта классификации KNN, k=6")
#classMapKNN(iris)
#knn <- par(mfrow=c(1,2))
#LOOKNN(iris[,3:5])
#LOOKWNN(iris[,3:5],k=19)
#plotIris(iris, "Карта классификации KWNN, k=6, q=0.5")
#classMapKWNN(iris)
#par(knn)
#demonstration()
####################################################### 
demo_potentials <- function(){
  plt <- par(mfrow=c(1,2))
  listIrises <- iris#rbind(iris[6:10,],iris[61:65,],iris[146:150,])#read.table("E:/R/MetricalAlgorithms/iris_1")
  plotIris(listIrises,"Распределение потенциалов,\n ядро Епанечникова")
  m <- dim(listIrises)[1]
  h <- c(rep(1, m/3), rep(0.5, (m-m/3)))
  kernel = kE
  print(h)
  gamma <- find_gamma(listIrises[,3:5],kernel,h,8)
  for(i in 1:m){
    opaq <- gamma/max(gamma)
    if(gamma[i]>0){ 
      color = adjustcolor(colors[listIrises[i,5]], opaq[i] / 2)
      draw.circle(listIrises[i,3], listIrises[i,4], h[i], 40, border = color, col = color)
      points(listIrises[i,3],listIrises[i,4],col="yellow",pch=24)
      points(listIrises[i,3],listIrises[i,4],col="yellow",pch=25)
      points(listIrises[i,3],listIrises[i,4],col="black",bg=color,pch=21)
    }
    else {
      if(listIrises[i,5] != potentials(listIrises[,3:5],listIrises[i,3:4],gamma,kernel,h)){
        points(listIrises[i,3],listIrises[i,4],col="black",pch=22)
      }
    }
  }
  print(gamma)
  print(h)
  plotIris(listIrises,"Карта классификации,\n ядро Епанечникова")
  classMapPotentials(listIrises,gamma,h,kernel)
  for(i in 1:m){
      if(listIrises[i,5] != potentials(listIrises[,3:5],listIrises[i,3:4],gamma,kernel,h)){
        points(listIrises[i,3],listIrises[i,4],col="black",pch=22)
      }
    }
  par(plt)
}
demo_potentials()