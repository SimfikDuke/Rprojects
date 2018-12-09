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
      titlePanel("Подстановочный алгоритм"),
  
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
        column(2, h4("   ")),
        column(5, h4("Входные")),
        column(5, h4("Восстановленные"))
      ),
      fluidRow(
        column(2, h3("Класс")),
        column(1, h3("Мю")),
        column(1, h3("   ")),
        column(1, h3("Ков")),
        column(2, h3("м-ца")),
        column(1, h3("Мю")),
        column(1, h3("   ")),
        column(1, h3("Ков")),
        column(2, h3("м-ца"))
      ),
      fluidRow(
        column(2, h3("Кл.1", style = "color: gold")),
        column(1, textOutput("im1X"), textOutput("im1Y")),
        column(1, "   "),
        column(1,textOutput("ic1X"),"0"),
        column(2,"0", textOutput("ic1Y")),
        
        column(1, textOutput("m1X"), textOutput("m1Y")),
        column(1, "   "),
        column(1,textOutput("c1X"),"0"),
        column(2,"0", textOutput("c1Y"))
      ),
      fluidRow(
        column(2, h3("Кл.2", style = "color: blue")),
        column(1, textOutput("im2X"), textOutput("im2Y")),
        column(1, "   "),
        column(1,textOutput("ic2X"),"0"),
        column(2,"0", textOutput("ic2Y")),
        
        column(1, textOutput("m2X"), textOutput("m2Y")),
        column(1, "   "),
        column(1,textOutput("c2X"),"0"),
        column(2,"0", textOutput("c2Y"))
      )
      
    )
    
  )
  
)

