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
                selectInput(inputId = "next_card", label="Carte", choices = unique(cards$city)),
                uiOutput(outputId = "select_block"),
                actionButton("draw_card", label="Tirer une carte"),
                actionButton("epidemic", label="Epidemie"),
                actionButton("delete", label="Exclure une carte"),
                actionButton("move_top", label="Mettre en haut du deck"),
                actionButton("undo", label="Annuler"),
                h3("Défausse"),
                tableOutput(outputId = "defausse"),
                h3("Deck"),
                tableOutput(outputId = "deck")
              )
      )
    )
  )