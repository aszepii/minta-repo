library(shiny)
library(tidyverse)
ui <- fluidPage(shiny::sidebarPanel(
  h1("szájdbár"),
  shiny::sliderInput("m", "várható érték", min = -10, max = 10,
                     step = 1, value = 0)
),
shiny::numericInput("sd","Szórás", value = 1, min = 1, max = 100),
shiny::actionButton("ned_data", "Véletlen generálás!"),
shiny::plotOutput("dplt")
  
)

server <- function(input, output, session) {
  output$dplt <- shiny::renderPlot({
    m2<- input$m*10
    
    ggplot(data=data.frame(x= seq(-10, 10)))+
      aes(x=x)+
      stat_function(geom = "area", fun = dnorm,
                    args=list(mean=m2),
                    sd=input$m2)
    
})
  
  observeEvent(eventExpr = input$new_data, handlerExpr = {
    data.frame(x=rnorm(1000, mean = input$m, sd=input$sd))
    write.csv(x=out, file = "random_numbers.csv")
  })
}

shinyApp(ui, server)

