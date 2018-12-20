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
      column(4, h5("Откл. по X")),
      column(8, makeSlider(paste0(idIn, "X"), min, max, values[1]))
    ),
    fluidRow(
      column(4, h5("Откл. по Y")),
      column(8, makeSlider(paste0(idIn, "Y"), min, max, values[2]))
    )
  )
}
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      fluidRow(
        column(1,checkboxInput("ldf",label = "", value=TRUE)),
        column(3, h4("ЛДФ", style = "color: green; text-align: left")),
        column(1),
        column(1,checkboxInput("plug",label = "", value=TRUE)),
        column(4, h4("Plug-in", style = "color: darkred; text-align: left"))
      ),
      fluidRow(
        column(4, h2("Класс 1", style = "color: gold; text-align: center")),
        column(8, makeSlider("n1", 100, 5000, 500))
      ),
      makeCovMatrixRow("cov1In", 1, 20, c(5, 5)),
      makeExpectedRow("mu1In", -10, 10, c(0, 0)),
      fluidRow(
        column(4, h2("Класс 2", style = "color: blue; text-align: center")),
        column(8, makeSlider("n2", 100, 5000, 500))
      ),
      makeCovMatrixRow("cov2In", 1, 20, c(5, 5)),
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
      ),
      fluidRow(
        column(3, h4("Восстановленные")),
        column(2, h4("ЛДФ", style = "color: green; text-align: center")),
        column(1),
        column(3, h4("Plug-in", style = "color: darkred"))
      ),
      fluidRow(
        column(2,tableOutput("emu")),
        column(1),
        column(2,tableOutput("ldf")),
        column(1),
        column(3,tableOutput("plug1")),
        column(2,tableOutput("plug2"))
      )
    )
    
  )
  
)

