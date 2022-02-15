ui <- 
  dashboardPage(
    dashboardHeader(
      title="Pandémie"
    ),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Jouer", tabName = "jouer", icon = icon("gamepad"))
      )
    ),
    dashboardBody(
      tabItem(tabName = "jouer",
              fluidRow(
                column(
                  width=6,
                  box(
                    width = 12,
                    title="Tirer une carte",
                    uiOutput(outputId = "select_drawn_card"),
                    actionButton("draw_card", label="Tirer une carte")
                  ),
                  box(
                    width = 12,
                    title="Epidémie",
                    radioButtons(inputId="source_epidemic_card", 
                                 label="Source de la carte d'épidémie",
                                 choices=c("Deck"="deck", "Reserve"="reserve"),
                                 selected="reserve"),
                    uiOutput(outputId = "select_bottom_card"),
                    actionButton("epidemic", label="Epidemie"),
                  ),
                  box(
                    width = 12,
                    title="Changement manuel",
                    selectInput(inputId="card_to_move",
                                choices=unique(cards$city), 
                                label="Carte à changer de bloc", 
                                width="200px"),
                    uiOutput(outputId = "select_block_from_card_to_move"),
                    numericInput(inputId = "block_to_move_card_to", label="Nouveau bloc",value=-2L, min=-2L, step=1L, width="200px"),
                    actionButton("change_bloc", label="Changer le bloc")
                  )
                ),
                column(
                  width=6,
                  box(
                    width = 12,
                    column(
                      width=6,
                      h4("Deck"),
                      tableOutput(outputId = "deck")
                    ), 
                    column(
                      width=6,
                      h4("Défausse"),
                      tableOutput(outputId = "defausse")
                    )
                  ),
                  box(width=12,
                      actionButton("undo", label="Annuler une action")
                  )
                )
              )
      )
    )
  )