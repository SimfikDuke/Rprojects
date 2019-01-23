require("plotrix")
library(MASS)

normalize = function(xl) {
  for (i in 1:dim(xl)[2]) {
    xl[, i] = (xl[, i] - min(xl[, i])) / (max(xl[, i]) - min(xl[, i]))
  }
  return(xl)
}

sigmoid = function(z) 1 / (1 + exp(-z))

ada_L = function(m) (1 - m) ^ 2

heb_L = function(m) max(-m, 0)

reg_L = function(m) log2(1 + exp(-m))

ada_upd = function(w, eta, xi, yi) w - eta * (sum(w * xi) - yi) * xi

heb_upd = function(w, eta, xi, yi) w + eta * yi * xi

reg_upd = function(w, eta, xi, yi) w + eta * xi * yi * sigmoid(-sum(w * xi) * yi)

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
    
    classes = c(rep(-1, n1), rep(1, n2))
    normdata = normalize(rbind(xy1,xy2))
    normdata = cbind(normdata,classes)
    colnames(normdata) = c("x","y","class")
    return(normdata)
  }
  drawLine = function(w, color, lwd=2) {
    x = y = seq(-2, 2, len = 100)
    z = outer(x, y, function(x,y) w[1]*x + w[2]*y + w[3])
    contour(x, y, z, levels = FALSE, drawlabels = FALSE, lwd = lwd, col = color,
            add = TRUE)
  }
  
  # Стохастический градиент
  sgd = function(xl, classes, L, updateRule, drawIters=FALSE, ost=FALSE,
                 eps=1e-5, eta=1/6) {
    rows = dim(xl)[1]
    xl = cbind(xl,seq(from=-1,to=-1,length.out=rows))
    cols = dim(xl)[2]
    w = runif(cols, -1 / (2 * cols), 1 / (2 * cols))
    lambda = 1 / rows
    
    Q = 0
    for (i in 1:rows) Q = Q + L(sum(w * xl[i,]) * classes[i])
    Q0 = Q
    
    iter = 0
    repeat {
      iter = iter + 1
      
      margins = rep(0, rows)
      for (i in 1:rows) {
        xi = xl[i,]
        yi = classes[i]
        margins[i] = sum(w * xi) * yi
      }
      errors = which(margins <= 0)
      
      
      if (length(errors) == 0 && ost == TRUE) {
        return(w)
      }
      
      if(length(errors) != 0){
        rnd_err = sample(errors, 1)
      } 
      else{ 
        rnd_err = sample(1:rows, 1)
      }
      
      xi = xl[rnd_err,]
      yi = classes[rnd_err]
      
      margin = sum(w * xi) * yi
      error = L(margin)
      
      w = updateRule(w, eta, xi, yi)
      
      Q = (1 - lambda) * Q + lambda * error
      if (abs(Q0 - Q) / abs(max(Q0, Q)) < eps) break;
      Q0 = Q
      if (iter == 30000)  break;
      if(drawIters) drawLine1(w, "black")
    }
    
    return(w)
  }
  drawPoints = function(x) {
    colors = c("gold", "red", "blue")
    for(i in 1:dim(x)[1]) x[i,3] = x[i,3] + 2
    lab = "Logistic regression"
    plot(x[, 1], x[, 2], pch = 21, col = "darkred", bg = colors[x[,3]],
         main = lab, asp = 1, xlab = "X", ylab = "Y")
  }
  drawLine1 = function(w, color) {
    abline(a = w[3] / w[2], b = -w[1] / w[2], lwd = 2, col = color)
  }
  drawGrad = function(data, reg){
    p = function(x,y,w) sigmoid(x*w[1]+y*w[2]-w[3])-sigmoid(-x*w[1]-y*w[2]+w[3])
    P = matrix(0, 100, 100)
    for(i in seq(from=0, to=1, by=0.1)){
      for(j in seq(from=0, to=1, by=0.1)){
        P[i*10+1,j*10+1] = p(i,j,reg)
      }
    }
    k = 1/max(max(P), -min(P))
    for(i in seq(from=0, to=1, by=0.05)){
      for(j in seq(from=0, to=1, by=0.05)){
        pp = p(i,j,reg)
        if(pp>0){
          color = adjustcolor("blue",pp*k)
          draw.circle(i, j, 0.035, 5, border = color, col = color)
        }
        if(pp<0){
          color = adjustcolor("gold",-pp*k)
          draw.circle(i, j, 0.035, 5, border = color, col = color)
        } 
      }
    }
    
  }
  output$plot = renderPlot({
    data = generateData()
    drawPoints(data)
    ada = sgd(data[,1:2], data[,3], ada_L, ada_upd)
    heb = sgd(data[,1:2], data[,3], heb_L, heb_upd, ost=TRUE)
    reg = sgd(data[,1:2], data[,3], reg_L, reg_upd, drawIters=input$iter)
    if(input$drawAda) drawLine1(ada, "darkred")
    if(input$drawHeb) drawLine1(heb, "darkgreen")
    drawLine1(reg, "red")
    if(input$grad)drawGrad(data, reg)
  })
}