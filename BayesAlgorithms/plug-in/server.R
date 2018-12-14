library(MASS)

# Восстановление центра нормального распределения
estimateMu = function(points) {
  cols = dim(points)[2]
  mu = matrix(NA, 1, cols)
  for (col in 1:cols) {
    mu[1, col] = mean(points[, col])
  }
  return(mu)
}

# Восстановление ковариационной матрицы нормального распределения
estimateCovarianceMatrix = function(points, mu) {
  rows = dim(points)[1]
  cols = dim(points)[2]
  covar = matrix(0, cols, cols)
  for (i in 1:rows) {
    covar = covar + (t(points[i,] - mu) %*% (points[i,] - mu)) / (rows - 1)
  }
  return(covar)
}

## Получение коэффициентов разделяющей поверхности
getPlugInDiskriminantCoeffs = function(mu1, sigma1, mu2, sigma2) {
  # Уравнение : a*x1^2 + b*x1*x2 + c*x2^2 + d*x1 + e*x2 + f = 0
  invSigma1 = solve(sigma1)
  invSigma2 = solve(sigma2)
  f = log(abs(det(sigma1))) - log(abs(det(sigma2))) + mu1 %*% invSigma1 %*% t(mu1) - mu2 %*% invSigma2 %*% t(mu2);
  alpha = invSigma1 - invSigma2
  a = alpha[1, 1]
  b = 2 * alpha[1, 2]
  c = alpha[2, 2]
  beta = invSigma1 %*% t(mu1) - invSigma2 %*% t(mu2)
  d = -2 * beta[1, 1]
  e = -2 * beta[2, 1]
  return(c("x^2" = a, "xy" = b, "y^2" = c, "x" = d, "y" = e, "1" = f))
}

getNewCoeffs = function(mu1, sigma1, mu2, sigma2) {
  # Уравнение : a*x1^2 + b*x1*x2 + c*x2^2 + d*x1 + e*x2 + f = 0
  a1 = sigma1[1,1]
  b1 = sigma1[1,2]
  c1 = sigma1[2,2]
  mu11 = mu1[1]
  mu12 = mu1[2] 
  a2 = sigma2[1,1]
  b2 = sigma2[1,2]
  c2 = sigma2[2,2]
  mu21 = mu2[1]
  mu22 = mu2[2]
  k1 = (2*a2*c2 - 2*b2^2)
  k2 = (2*a1*c1 - 2*b1^2)
  
  a = -k1*c1 + k2*c2
  c = -k1*a1 + k2*a2
  b = k1*(2*b1) -k2*2*b2
  d = -k1*(2*b1*mu12-2*c1*mu11) + k2*(2*b2*mu22-2*c2*mu21)
  e = -k1*(2*b1*mu11-2*a1*mu12) + k2*(2*b2*mu21-2*a2*mu22)
  f = (1/2)*(log(abs(a2*c2-b2^2))-log(abs(a1*c1-b1^2)))*k1*k2 - k1*(c1*mu11^2+a1*mu12^2-2*b1*mu11*mu12) + k2*(c2*mu21^2+a2*mu22^2-2*b2*mu21*mu22)
  return(c("x^2" = a, "xy" = b, "y^2" = c, "x" = d, "y" = e, "1" = f))
}

server = function(input, output) {
  generateData = function() {
    # nomber of instances
    n1 = input$n1
    n2 = input$n2
    
    covar1 = matrix(c(input$cov1InX, 0, 0, input$cov1InY), 2, 2)
    covar2 = matrix(c(input$cov2InX, 0, 0, input$cov2InY), 2, 2)
    
    mu1 = c(input$mu1InX, input$mu1InY)
    mu2 = c(input$mu2InX, input$mu2InY)
    output$im1X = render(mu1[1])
    output$im1Y = render(mu1[2])
    output$ic1X = render(covar1[1])
    output$ic1Y = render(covar1[4])
    output$im2X = render(mu2[1])
    output$im2Y = render(mu2[2])
    output$ic2X = render(covar2[1])
    output$ic2Y = render(covar2[4])
    
    xy1 = mvrnorm(n1, mu1, covar1)
    xy2 = mvrnorm(n2, mu2, covar2)
    
    list("xy1" = xy1, "xy2" = xy2)
  }
  
  drawPoints = function(xy1, xy2) {
    x = rbind(cbind(xy1, 1), cbind(xy2, 2))
    colors = c("gold", "blue")
    plot(x[, 1], x[, 2], pch = 21, col = "darkred", bg = colors[x[, 3]],
         main = "Plug-in", asp = 1, xlab = "X", ylab = "Y")
  }
  
  render = function(number, s=4) {
    number = round(number, s)
    renderText(number)
  }
  
  estimateCoeffs = function(xy1, xy2) {
    mu1 = estimateMu(xy1)
    mu2 = estimateMu(xy2)
    cov1 = estimateCovarianceMatrix(xy1, mu1)
    cov2 = estimateCovarianceMatrix(xy2, mu2)
    
    #выводим итоговые результаты
    
    output$m1X = render(mu1[1],2)
    output$m1Y = render(mu1[2],2)
    output$m2X = render(mu2[1],2)
    output$m2Y = render(mu2[2],2)
    
    output$c1X = render(cov1[1, 1],2)
    output$c1Y = render(cov1[2, 2],2)
    output$c2X = render(cov2[1, 1],2)
    output$c2Y = render(cov2[2, 2],2)
    
    #возвращаем разделяющую поверхность
    coeffs = getPlugInDiskriminantCoeffs(mu1, cov1, mu2, cov2)
    coeffs
  }  
  nCoeffs = function(xy1, xy2) {
    mu1 = estimateMu(xy1)
    mu2 = estimateMu(xy2)
    cov1 = estimateCovarianceMatrix(xy1, mu1)
    cov2 = estimateCovarianceMatrix(xy2, mu2)
    
    #выводим итоговые результаты
    
    output$m1X = render(mu1[1],2)
    output$m1Y = render(mu1[2],2)
    output$m2X = render(mu2[1],2)
    output$m2Y = render(mu2[2],2)
    
    output$c1X = render(cov1[1, 1],2)
    output$c1Y = render(cov1[2, 2],2)
    output$c2X = render(cov2[1, 1],2)
    output$c2Y = render(cov2[2, 2],2)
    
    #возвращаем разделяющую поверхность
    coeffs = getNewCoeffs(mu1, cov1, mu2, cov2)
    coeffs
  }
  
  output$plot = renderPlot({
    #Создаем тестовые данные
    data = generateData()
    xy1 = data$xy1
    xy2 = data$xy2
    
    #Рисуем точки
    drawPoints(xy1, xy2)
    
    # Поиск параметров
    coeffs = estimateCoeffs(xy1, xy2)
    nc = nCoeffs(xy1,xy2)
    
    # Рисуем дискриминантую функцию
    x = y = seq(-50, 50, len = 1000)
    z = outer(x, y, function(x, y) coeffs["x^2"] * x ^ 2 + coeffs["xy"] * x * y + coeffs["y^2"] * y ^ 2 + coeffs["x"] * x + coeffs["y"] * y + coeffs["1"])
    nz = outer(x, y, function(x, y) nc["x^2"] * x ^ 2 + nc["xy"] * x * y + nc["y^2"] * y ^ 2 + nc["x"] * x + nc["y"] * y + nc["1"])
    contour(x, y, z, levels = 0, lwd = 1, col = "black", add = TRUE)
    contour(x, y, nz, levels = 0, lwd = 4, col = "darkred", add = TRUE, method = "flattest")
  })
}