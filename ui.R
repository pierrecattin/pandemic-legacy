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
                selectInput(inputId = "next_card", label="Carte tirée", choices = unique(cards$city)),
                actionButton("draw_card", label="Tirer une carte"),
                actionButton("epidemic", label="Epidemie"),
                tableOutput(outputId = "blocks")
              )
      )
    )
  )