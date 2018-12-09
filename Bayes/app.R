library(shiny)

fruits <- read.csv("fruits.csv")
ui <- fluidPage(
   
   titlePanel("Naive Bayes"),
   sidebarLayout(
      sidebarPanel(
        checkboxInput("long","Long", TRUE),
        checkboxInput("sweet","Sweet", FALSE),
        checkboxInput("yellow","Yellow", FALSE),
        tableOutput("inpdata"),
        width = 5
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        tableOutput("renTable"),
        h3(textOutput("label")),
        plotOutput("img"),
        width = 7
      )
   )
)
bayes <- function(x, xl){
  m <- dim(xl)[1]     # number of elements
  n <- dim(xl)[2]-1   # number of columns
  result <- rep(1,m-1)
  for(i in 1:length(x)){
    if(x[i] == TRUE){
      numerator <- xl[1:m-1,i] / xl[1:m-1,n+1]
      denominator <- xl[m,i] / xl[m,n+1]
    }
    else {
      numerator <- (xl[1:m-1,n+1] - xl[1:m-1,i]) / xl[1:m-1,n+1]
      denominator <- (xl[m,n+1] - xl[m,i]) / xl[m,n+1]
    }
      result <- result * numerator
      result <- result / denominator
      #print(numerator, digits = 2)
      #print(denominator, digits = 2)
      #print(result, digits = 2)
  }
  pclasses <- xl[1:m-1,n+1] / xl[m,n+1]
  result <- result * pclasses
  result <- result / sum(result)
  #print(result, digits = 2)
  return(result)
}
# Define server logic required to draw a histogram
server <- function(input, output) {

   output$renTable <- renderTable(
     {
       x <- c(input$long,input$sweet,input$yellow)
       y <- bayes(x, fruits)
       classes <- rownames(fruits)
       m <- length(classes)
       names(y) <- classes[1:m-1]
       
        myTable <- do.call(rbind, list(y))
          output$img <- renderImage({
            filename <- normalizePath(file.path('img',
              paste(which.max(y), '.png', sep='')))
            list(src = filename)
          }, deleteFile = FALSE)
          output$label <- renderText({
            paste("\nResult:\n",classes[which.max(y)])})
      myTable
     }
   )
   output$inpdata <- renderTable(
     {
       d <- cbind(rownames(fruits), fruits)
       colnames(d) <- c("class",colnames(fruits))
       d
     }
   )
}

# Run the application 
shinyApp(ui = ui, server = server)
