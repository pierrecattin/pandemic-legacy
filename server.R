server <- function(input, output) {
  reac <- reactiveValues()
  reac$blocks <- init_blocks(cards)
  reac$previous_blocks <- list()
  
  output$defausse <- 
    renderTable({
      reac$blocks %>%
        filter(block==-1) %>%
        group_by(city) %>%
        summarise(count=n(), .groups="drop") %>%
        arrange(desc(count))
    })
  
  output$deck  <- 
    renderTable({
      reac$blocks %>%
        filter(block>=0) %>%
        group_by(city, block) %>%
        summarise(count=n(), .groups="drop") %>%
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
    block_from_card <- 
      if_else(input$source_epidemic_card=="deck",
              min(reac$blocks$block[reac$blocks$block>=0]),
              -2L)

      choices <- reac$blocks %>%
        filter(block == block_from_card) %>%
        pull(city) %>%
        unique()

    selectInput(inputId = "bottom_card", 
                label="Carte d'épidémie", 
                choices = choices, 
                width="200px")
  })
  
  output$select_block_from_card_to_move <- renderUI({
    choices <- reac$blocks %>%
      filter(city==input$card_to_move) %>%
      pull(block) %>%
      unique()
    selectInput(inputId="block_from_card_to_move",
                choices=choices, 
                label="Bloc de la carte à bouger", 
                width="200px")
  })
  
  observeEvent(eventExpr = input$draw_card,{
    reac$previous_blocks[[length(reac$previous_blocks)+1]] <- reac$blocks
    reac$blocks <- draw_card(blocks=reac$blocks, city=input$drawn_card)
  })
  
  observeEvent(eventExpr = input$epidemic,{
    reac$previous_blocks[[length(reac$previous_blocks)+1]] <- reac$blocks
    reac$blocks <- epidemic(blocks=reac$blocks, 
                            bottom_city=input$bottom_card, 
                            from_reserve=input$source_epidemic_card=="reserve")
  })
  
  observeEvent(eventExpr = input$change_bloc,{
    reac$previous_blocks[[length(reac$previous_blocks)+1]] <- reac$blocks
    reac$blocks <- move_card(blocks=reac$blocks, 
                             city=input$card_to_move,
                             original_block=as.integer(input$block_from_card_to_move), 
                             target_block=as.integer(input$block_to_move_card_to))
  })
  
  observeEvent(eventExpr = input$undo,{
    if(length(reac$previous_blocks)>0){
      reac$blocks <- reac$previous_blocks[[length(reac$previous_blocks)]] 
      reac$previous_blocks <- reac$previous_blocks[-length(reac$previous_blocks)] 
    }
  })
}