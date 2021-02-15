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
                    selectInput(inputId = "drawn_card", label="Carte tirée", choices = unique(cards$city), width="200px"),
                    actionButton("draw_card", label="Tirer une carte"),
                    actionButton("delete", label="Exclure"),
                  ),
                  box(
                    width = 12,
                    title="Epidémie",
                    selectInput(inputId = "bottom_card", label="Carte du dessous", choices = unique(cards$city), width="200px"),
                    actionButton("epidemic", label="Epidemie"),
                  ),
                  box(
                    width = 12,
                    title="Réorganiser le deck",
                    selectInput(inputId = "card_to_top", label="Carte à mettre en haut", choices = unique(cards$city), width="200px"),
                    uiOutput(outputId = "select_block"),
                    actionButton("move_top", label="Mettre en haut du deck"),
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