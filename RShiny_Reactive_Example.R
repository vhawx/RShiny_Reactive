#dir.create("04PokemonAppReactive")

library(shiny)

#poke <-readWorksheetFromFile
#pokePts <- poke[,4:10]

ui <- fluidPage("Reactive Example App",
                selectInput(inputId = 'xData', label = "Select x-axis data:", 
                            choices = names(pokePts)),
                selectInput(inputId = 'yData', label = "Select y-axis data:", 
                            choices = names(pokePts),
                            selected = names(pokePts)[[2]]),
                textInput(inputId = 'addText', label = "Enter text here:"),
                textOutput(outputId = 'showText'),
                plotOutput(outputId = 'scatterPlot', width = "100%", height = "600px")
)
server <- function(input, output) {
  textData <- reactive(input$addText)
  plotData <- reactive(data.frame(pokePts[,input$xData], pokePts[,input$yData]))
  output$showText <- renderText(textData())
  output$scatterPlot <- renderPlot({
    title = "Pokemon data comparion"
    plot(plotData(), main = title)
  })
}

shinyApp(ui = ui, server = server) 