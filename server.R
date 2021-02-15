server <- function(input, output) {
  reac <- reactiveValues()
  reac$blocks <- init_blocks(cards)
  reac$previous_blocks <- list()
  
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
    
    reac$previous_blocks[[length(reac$previous_blocks)+1]] <- reac$blocks
    reac$blocks <- draw_card(blocks=reac$blocks, city=input$next_card)
  })
  
  observeEvent(eventExpr = input$epidemic,{
    reac$previous_blocks[[length(reac$previous_blocks)+1]] <- reac$blocks
    reac$blocks <- epidemic(blocks=reac$blocks, bottom_city=input$next_card)
  })
  
  observeEvent(eventExpr = input$delete,{
    reac$previous_blocks[[length(reac$previous_blocks)+1]] <- reac$blocks
    reac$blocks <- delete_card(blocks=reac$blocks, city=input$next_card)
  })
  
  observeEvent(eventExpr = input$undo,{
    if(length(reac$previous_blocks)>0){
      reac$blocks <- reac$previous_blocks[[length(reac$previous_blocks)]] 
      reac$previous_blocks <- reac$previous_blocks[-length(reac$previous_blocks)] 
    }
  })
}