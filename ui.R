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
                    actionButton("draw_card", label="Tirer une carte"),
                    actionButton("delete", label="Exclure"),
                  ),
                  box(
                    width = 12,
                    title="Epidémie",
                    uiOutput(outputId = "select_bottom_card"),
                    actionButton("epidemic", label="Epidemie"),
                  ),
                  box(
                    width = 12,
                    title="Réorganiser le deck",
                    uiOutput(outputId = "select_card_to_top"),
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