server <- function(input, output) {
  reac <- reactiveValues()
  reac$blocks <- init_blocks(cards)
  
  
  
  output$defausse <- 
    renderTable({
      reac$blocks %>%
        filter(block==-1) %>%
        group_by(city) %>%
        summarise(count=n()) %>%
        arrange(desc(count))
    })
  output$deck  <- 
    renderTable({
      reac$blocks %>%
        filter(block>=0) %>%
        group_by(city, block) %>%
        summarise(count=n()) %>%
        arrange(desc(block), desc(count))
    })
  
  observeEvent(eventExpr = input$draw_card,{
    reac$blocks <- draw_card(blocks=reac$blocks, city=input$next_card)
  })
  
  observeEvent(eventExpr = input$epidemic,{
    reac$blocks <- epidemic(blocks=reac$blocks, bottom_city=input$next_card)
  })
  
  observeEvent(eventExpr = input$delete,{
    reac$blocks <- delete_card(blocks=reac$blocks, city=input$next_card)
  })
}