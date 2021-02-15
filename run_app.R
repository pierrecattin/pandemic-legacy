rm(list=ls())

#### Packages & functions ####
deps <- c("openxlsx",
          "dplyr",
          "shiny", 
          "shinydashboard")
lapply(X=deps, FUN=library, character.only=T)

lapply(X=list.files("functions/",full.names = T), FUN = source)

#### Data ####
cards <- read.xlsx("data/all_cards.xlsx")
blocks <- init_blocks(cards) 
rm(cards)
#### App ####
source("ui.R")
source("server.R")


runApp(appDir=list(ui=ui, server=server))
