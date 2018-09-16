print("Hello world!")
colors <- c("setosa" = "red", "versicolor" = "green3", "virginica" = "blue")
plot(iris[, 3:4], pch = 21, bg = colors[iris$Species], col=colors[iris$Species],"Длина","Ширина")
points(2.5,1)

summa <- (function(a,b) a+b)
summa(3,4)

dist <- (function(a,b) sqrt(((a[1]-b[1])^2)+((a[2]-b[2])^2)))



newPoints <- rbin(iris[3:4], c())
  