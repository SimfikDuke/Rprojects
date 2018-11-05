library(shiny)

slider = function(id, min, max, value, step = 1, label = NULL) {
  sliderInput(
    inputId = id,
    label = label,
    min = min,
    max = max,
    value = value,
    step = step
  )
}

matrixPanel = function() {
  fluidRow(
    column(2, HTML("<img src=\"http://simfik.ru/i/r11.png\">")),
    column(10, slider("cov11", 0, 10, 1)),
    column(2, HTML("<img src=\"http://simfik.ru/i/r12.png\">")),
    column(10, slider("cov12", 0, 10, 0)),
    column(2, HTML("<img src=\"http://simfik.ru/i/r22.png\">")),
    column(10, slider("cov22", 0, 10, 1))
  )
}

errorMess = function() {
  fluidRow(
    column(2, NULL),
    column(10, textOutput("covMessage"), style = "color: red; text-align: center")
  )
}
printSigma = function() {
  fluidRow(
    column(12, h3("Ковариационная матрица:"), style = "color: green; text-align: center"),
    column(12, h3(textOutput("sigmaMess1")), style = "color: green; text-align: center"),
    column(12, h3(textOutput("sigmaMess2")), style = "color: green; text-align: center")
  )
}
setingsPanel = function(){
   fluidRow(
    column(2, "Шаг плотности"),
    column(10,fluidRow(column(12, slider("by", 0.001, 0.01, 0.005, 0.001)))),
    column(2, "Точность прорисовки"),
    column(10,fluidRow(column(12, slider("acc", 10, 500, 100, 10))))
  )
}

norm = function(x, y, mu, sigma) {
  x = matrix(c(x, y), 1, 2)
  n = 2
  k = 1 / sqrt((2 * pi) ^ n * det(sigma))
  e = exp(-0.5 * (x - mu) %*% solve(sigma) %*% t(x - mu))
  k * e
}

