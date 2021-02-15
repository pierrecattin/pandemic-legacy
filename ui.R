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
                box(
                  width = 12,
                  selectInput(inputId = "next_card", label="Carte", choices = unique(cards$city), width="200px"),
                  actionButton("draw_card", label="Tirer une carte"),
                  actionButton("epidemic", label="Epidemie"),
                  actionButton("delete", label="Exclure une carte"),
                  actionButton("undo", label="Annuler")
                ),
                box(
                  width = 12,
                  title="Réorganiser le deck",
                  collapsible = TRUE,
                  collapsed=TRUE,
                  uiOutput(outputId = "select_block"),
                  actionButton("move_top", label="Mettre en haut du deck"),
                ),
                box(
                  width = 12,
                  h3("Défausse"),
                  tableOutput(outputId = "defausse"),
                  h3("Deck"),
                  tableOutput(outputId = "deck")
                )
              )
      )
    )
  )