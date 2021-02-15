server <- function(input, output) {
  output$blocks <- 
    renderTable({
      input$epidemic
      input$draw_card
      blocks
    })
  
  observeEvent(eventExpr = input$draw_card,{
    blocks <<- draw_card(blocks=blocks, city=input$next_card)
  })
  
  observeEvent(eventExpr = input$epidemic,{
    blocks <<- epidemic(blocks=blocks, bottom_city=input$next_card)
  })
}