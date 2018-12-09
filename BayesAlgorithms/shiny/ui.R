library(shiny)
source("mylib.R", encoding = "UTF-8")
source("server.R", encoding = "UTF-8")

ui <- fluidPage(
  
  sidebarLayout(
    
    sidebarPanel(
      titlePanel("Задание матрицы",windowTitle="Линии уровня"),
      matrixPanel(),
      printSigma(),
      errorMess(),
      titlePanel("Настройка графика"),
      setingsPanel()
    ),
    
    mainPanel(
      HTML("<center><h1><b>График линий уровня нормального распределения</b></h1>"),
      HTML("<img src=\"http://simfik.ru/i/f.png\"></center>"),
      plotOutput(outputId = "plot", height = "600px")
    )
  )
  
)
