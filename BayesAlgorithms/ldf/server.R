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
estimateLDFCovarianceMatrix = function(points1, mu1, points2, mu2) {
  rows1 = dim(points1)[1]
  cols = dim(points1)[2]  
  rows2 = dim(points2)[1]
  
  covar = matrix(0, cols, cols)
  
  for (i in 1:rows1) {
    covar = covar + (t(points1[i,] - mu1) %*% (points1[i,] - mu1))
  }
  for (i in 1:rows2) {
    covar = covar + (t(points2[i,] - mu2) %*% (points2[i,] - mu2))
  }
  return(covar/(rows1+rows2+2))
}

# Восстановление ковариационной матрицы нормального распределения
estimatePluginCovarianceMatrix = function(points, mu) {
  rows = dim(points)[1]
  cols = dim(points)[2]
  covar = matrix(0, cols, cols)
  for (i in 1:rows) {
    covar = covar + (t(points[i,] - mu) %*% (points[i,] - mu)) / (rows - 1)
  }
  return(covar)
}

## Получение коэффициентов разделяющей поверхности PLug-in
getPluginCoeffs = function(mu1, sigma1, mu2, sigma2) {
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

## Получение коэффициентов разделяющей поверхности LDF
getLDFCoeffs = function(mu1, mu2, sigma) {
  # Уравнение : a*x1^2 + b*x1*x2 + c*x2^2 + d*x1 + e*x2 + f = 0
  a = sigma[1,1]
  b = sigma[1,2]
  c = sigma[2,2]
  mu11 = mu1[1]
  mu12 = mu1[2]
  mu21 = mu2[1]
  mu22 = mu2[2]
  x = 2*(mu11*c - mu12*b + mu21*c - mu22*b)
  y = 2*(mu12*a - mu11*b + mu22*a - mu21*b)
  a <- a - b
  c <- c - b
  f = c*(mu21^2+mu21*mu22-mu11^2-mu11*mu21)+a*(mu22*mu21+mu22^2-mu12*mu11-mu12^2)
  return(c("x" = x, "y" = y, "1" = f))
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
    ind <- round(cbind(mu1,mu2,covar1[,1],covar1[,2],covar2[,1],covar2[,2]),1)
    imu1 <- matrix(mu1,2,1)
    imu2 <- matrix(mu2,2,1)
    icov1 <- cbind(covar1[,1],covar1[,2])
    icov2 <- cbind(covar2[,1],covar2[,2])
    colnames(imu1) <- c("mu1")
    colnames(imu2) <- c("mu2")
    colnames(icov1) <- c("Sig","ma1")
    colnames(icov2) <- c("Sig","ma2")
    output$imu1 <- renderTable(imu1, digits = 0
                               ,spacing="xs",bordered = TRUE)
    output$imu2 <- renderTable(imu2, digits = 0
                               ,spacing="xs",bordered = TRUE)
    output$icov1 <- renderTable(icov1, digits = 0
                                ,spacing="xs",bordered = TRUE)
    output$icov2 <- renderTable(icov2, digits = 0
                                ,spacing="xs",bordered = TRUE)
    
    xy1 = mvrnorm(n1, mu1, covar1)
    xy2 = mvrnorm(n2, mu2, covar2)
    
    list("xy1" = xy1, "xy2" = xy2)
  }
  
  drawPoints = function(xy1, xy2) {
    x = rbind(cbind(xy1, 1), cbind(xy2, 2))
    colors = c("gold", "blue")
    lab = ""
    if(input$ldf) lab = paste(lab, " LDF ")
    if(input$plug) lab = paste(lab, " Plug-in ")
    plot(x[, 1], x[, 2], pch = 21, col = "darkred", bg = colors[x[, 3]],
         main = lab, asp = 1, xlab = "X", ylab = "Y")
  }
  
  sh  <- function(num, s=2) round(num,s)
  render = function(number, s=4) renderText(sh(number, s))
  
  LDFCoeffs = function(xy1, xy2) {
    mu1 = estimateMu(xy1)
    mu2 = estimateMu(xy2)
    cov = estimateLDFCovarianceMatrix(xy1, mu1, xy2, mu2)
    
    #coeffs = getLDFCoeffs(mu1, mu2, cov)
    coeffs = getPluginCoeffs(mu1,cov,mu2, cov)
    ldf <- cov
    colnames(ldf) <- c("Sig","ma")
    emu <- cbind(t(mu1), t(mu2))
    colnames(emu) <- c("mu1","mu2")
    output$ldf <- renderTable(ldf, spacing = "xs", bordered = TRUE)
    output$emu <- renderTable(emu, spacing = "xs", bordered = TRUE)
    coeffs
  }
  pluginCoeffs = function(xy1, xy2) {
    mu1 = estimateMu(xy1)
    mu2 = estimateMu(xy2)
    cov1 = estimatePluginCovarianceMatrix(xy1, mu1)
    cov2 = estimatePluginCovarianceMatrix(xy2, mu2)
    
    #возвращаем разделяющую поверхность
    coeffs = getPluginCoeffs(mu1, cov1, mu2, cov2)
    colnames(cov1) <- c("Sig","ma1")
    colnames(cov2) <- c("Sig","ma2")
    output$plug1 <- renderTable(cov1, spacing = "xs", bordered = TRUE)
    output$plug2 <- renderTable(cov2, spacing = "xs", bordered = TRUE)
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
    plug = pluginCoeffs(xy1,xy2)
    ldf = LDFCoeffs(xy1,xy2)
    # Рисуем дискриминантую функцию
    x = y = seq(-50, 50, len = 1000)
    plugz = outer(x, y, function(x, y) plug["x^2"] * x ^ 2 + plug["xy"] * x * y + plug["y^2"] * y ^ 2 + plug["x"] * x + plug["y"] * y + plug["1"])
    ldfz = outer(x, y, function(x, y) ldf["x"] * x + ldf["y"] * y + ldf["1"])
    if(input$plug){ 
        contour(x, y, plugz, levels = FALSE, drawlabels = FALSE, lwd = 2, col = "darkred",
                add = TRUE, method = "flattest")
    }
    if(input$ldf){
        contour(x, y, ldfz, levels = FALSE, drawlabels = FALSE, lwd = 4, col = "green",
                add = TRUE, method = "flattest")
     }
  })
}