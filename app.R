library(shiny)
library(readxl)
DD=data.frame(read_xlsx("D:/My Report/4-Projects/6-Nargesi/Drilling Data set-Nargesi project.xlsx"))
ui <- fluidPage(

    titlePanel("Drilling Data analysing by DrillGraph"),
    sidebarLayout(position = "left",
                  sidebarPanel(selectInput(inputId="par",
                                           label="Choose a Drilling Parameter",
                                           choices=c("ROP"=7,"WOB"=9,"RPM"=11,"GPM"=19)),
                               sliderInput(inputId="bin",
                                           label="select numbers of bins in histogram",
                                           min=5,max=25,value=10)
                               ),
                  mainPanel(
                            plotOutput("myhist")
                            )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$myhist <- renderPlot({
    colm=as.numeric(input$par)
    hist(DD[,colm],
         breaks = seq(0,max(DD[,colm]),l=input$bin+1),
         main="histogram of Drilling parameters",
         xlab=names(DD[colm]))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
