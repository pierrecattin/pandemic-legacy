ui <- 
  dashboardPage(
    dashboardHeader(
      title="Pandemic"
    ),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Jouer", tabName = "jouer", icon = icon("gamepad"))
      )
    ),
    dashboardBody(
      tabItem(tabName = "jouer",
              fluidRow(
                
              )
      )
    )
  )