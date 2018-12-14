library(shiny)
source("mylib.R", encoding = "UTF-8")
server = function(input, output) {
  output$plot = renderPlot({
    mu = matrix(0, 1, 2)
    
    sigma = matrix(c(input$cov11, input$cov12, input$cov12, input$cov22), 2, 2)
    
    output$sigmaMess1 = renderText({
      paste(sigma[1,1],sigma[1,2],sep=" ")
    })
    output$sigmaMess2 = renderText({
      paste(sigma[2,1],sigma[2,2],sep=" ")
    })
    if (det(sigma) <= 0) {
      output$covMessage = renderText({
        "Определитель сигма < 0"
      })
      return()
    }
    output$covMessage = renderText({
      ""
    })
    zfunc <- function(x, y) {
      sapply(1:length(x), function(i) norm(x[i], y[i], mu, sigma))
    }
    # Рисуем дискриминантую функцию
    minX = -sigma[1, 1] - 2
    maxX = sigma[1, 1] + 2
    minY = -sigma[2, 2] - 2
    maxY = sigma[2, 2] + 2
    
    x = seq(minX, maxX, len=input$acc)
    y = seq(minY, maxY, len=input$acc)
    z = outer(x, y, zfunc)
    
    add = F
    for (level in seq(input$by, 0.2, input$by)) {
      col = rgb(level*3+0.4,1-(level*3)-0.2,0)
      contour(x, y, z, levels = level, drawlabels = T, lwd = 1, col = col, add = add, asp = 1)
      add = T
    }
  })
  
}