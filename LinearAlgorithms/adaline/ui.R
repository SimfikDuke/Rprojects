nameWidth = 3
inputWidth = 9

makeSlider = function(id, min, max, value) {
  sliderInput(
    inputId = id,
    label = NULL,
    min = min,
    max = max,
    value = value
  )
}

makeCountRow = function(id, min, max, value) {
  fluidRow(
    column(3, h5("Количество")),
    column(9, makeSlider(id, min, max, value))
  )
}

makeCovMatrixRow = function(idIn, min, max, values) {
  fluidRow(
    fluidRow(
      column(4, h5("Ков. м-ца X")),
      column(8, makeSlider(paste0(idIn, "X"), min, max, values[1]))
    ),
    fluidRow(
      column(4, h5("Ков. м-ца Y")),
      column(8, makeSlider(paste0(idIn, "Y"), min, max, values[2]))
    )
  )
}

makeExpectedRow = function(idIn, min, max, values) {
  fluidRow(
    fluidRow(
      column(4, h5("Mu X")),
      column(8, makeSlider(paste0(idIn, "X"), min, max, values[1]))
    ),
    fluidRow(
      column(4, h5("Mu Y")),
      column(8, makeSlider(paste0(idIn, "Y"), min, max, values[2]))
    )
  )
}
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      fluidRow(
        column(6, checkboxInput("drawAda", "Adaline", TRUE)),
        column(6, checkboxInput("drawHeb", "Kheb", TRUE))
      ),
      fluidRow(
        column(6, checkboxInput("iterAda", "iterations")),
        column(6, checkboxInput("iterHeb", "iterations"))
      ),
      fluidRow(
        column(6, h3("Класс 1", style = "color: gold; text-align: center")),
        column(6, makeSlider("n1", 10, 100, 20))
      ),
      makeCovMatrixRow("cov1In", 1, 20, c(2, 3)),
      makeExpectedRow("mu1In", -10, 10, c(0, 0)),
      fluidRow(
        column(6, h3("Класс 2", style = "color: blue; text-align: center")),
        column(6, makeSlider("n2", 10, 100, 20))
      ),
      makeCovMatrixRow("cov2In", 1, 20, c(2, 3)),
      makeExpectedRow("mu2In", -10, 10, c(10, 0))
      
    ),
    
    mainPanel(
      
      plotOutput(outputId = "plot", height = "600px"),
      
      fluidRow(
        column(2, h4("Входные")),
        column(2,tableOutput("imu1")),
        column(2,tableOutput("imu2")),
        column(3,tableOutput("icov1")),
        column(2,tableOutput("icov2"))
      )
    )
  )
  
)

