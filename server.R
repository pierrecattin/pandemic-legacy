server <- function(input, output) {
  reac <- reactiveValues()
  reac$blocks <- init_blocks(cards)
  
  
  output$blocks <- 
    renderTable({
      reac$blocks
    })
  
  
  observeEvent(eventExpr = input$draw_card,{
    reac$blocks <- draw_card(blocks=reac$blocks, city=input$next_card)
  })
  
  observeEvent(eventExpr = input$epidemic,{
    reac$blocks <- epidemic(blocks=reac$blocks, bottom_city=input$next_card)
  })
}