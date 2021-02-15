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
  output$select_drawn_card <- renderUI({
    choices <- reac$blocks %>%
      filter(block==max(reac$blocks$block)) %>%
      pull(city) %>%
      unique()
    selectInput(inputId = "drawn_card", 
                label="Carte tirée", 
                choices = choices, 
                width="200px")
  })
  
  output$select_bottom_card <- renderUI({
    choices <- reac$blocks %>%
      filter(block==0) %>%
      pull(city) %>%
      unique()
    selectInput(inputId = "bottom_card", 
                label="Carte du dessous", 
                choices = choices, 
                width="200px")
  })
  
  output$select_card_to_top <- renderUI({
    choices <- reac$blocks %>%
      filter(block>=0) %>%
      pull(city) %>%
      unique()
    
    selectInput(inputId = "card_to_top", 
                label="Carte à mettre en haut", 
                choices = choices, 
                width="200px")
  })
  
  output$select_block <- renderUI({
    choices <- reac$blocks %>%
      filter(city==input$card_to_top,
             block>=0) %>%
      pull(block) %>%
      unique()
    selectInput(inputId="block",
                choices=choices, 
                label="Bloc de la carte à mettre en haut", 
                width="200px")
  })
  
  observeEvent(eventExpr = input$draw_card,{
    
    reac$previous_blocks[[length(reac$previous_blocks)+1]] <- reac$blocks
    reac$blocks <- draw_card(blocks=reac$blocks, city=input$drawn_card)
  })
  
  observeEvent(eventExpr = input$epidemic,{
    reac$previous_blocks[[length(reac$previous_blocks)+1]] <- reac$blocks
    reac$blocks <- epidemic(blocks=reac$blocks, bottom_city=input$bottom_card)
  })
  
  observeEvent(eventExpr = input$delete,{
    reac$previous_blocks[[length(reac$previous_blocks)+1]] <- reac$blocks
    reac$blocks <- delete_card(blocks=reac$blocks, city=input$drawn_card)
  })
  
  observeEvent(eventExpr = input$move_top,{
    reac$previous_blocks[[length(reac$previous_blocks)+1]] <- reac$blocks
    reac$blocks <- move_top(blocks=reac$blocks, city=input$card_to_top, block=as.integer(input$block))
  })
  
  observeEvent(eventExpr = input$undo,{
    if(length(reac$previous_blocks)>0){
      reac$blocks <- reac$previous_blocks[[length(reac$previous_blocks)]] 
      reac$previous_blocks <- reac$previous_blocks[-length(reac$previous_blocks)] 
    }
  })
}