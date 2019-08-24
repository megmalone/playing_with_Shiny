library(tidyverse)
library(ggplot2)
library(ggthemes)
projects <- read.csv("~/Documents/R/summer_fun/ks-projects-201612.csv")
USD_projects <- projects %>% filter(projects$currency == 'USD')
#categories <- tibble(
  #'categories' = unique(USD_projects$main_category, incomparables = FALSE)
#)
USD_projects$goal <- as.numeric(USD_projects$goal)
USD_projects$pledged <- as.numeric(USD_projects$pledged)

#plot_this <- USD_projects %>% filter(USD_projects$main_category == 'Food')
#plot_this <- head(plot_this, 100)
#as.data.frame(plot_this)
#ggplot(plot_this, aes(plot_this$goal, plot_this$pledged, shape = plot_this$state, main("Kickstarter Campaigns"))) + geom_point() + theme_classic()

# shiny ---
library(shiny)
ui <- fluidPage(
  selectInput(inputId = "main", label = "Choose a category", 
              list('Film & Video', 'Music', 'Food', 'Design', 'Crafts', 'Games', 'Comics', 'Publishing', 'Fashion', 'Theater', 'Art', 'Photography', 'Technology', 'Dance', 'Journalism'),
              multiple = FALSE, selectize = FALSE, width = 500),
  plotOutput('point')
)

server <- function(input, output){
  output$point <- renderPlot({
    plot_this <- USD_projects %>% filter(USD_projects$main_category == input$main)
    plot_this <- head(plot_this, 100)
    as.data.frame(plot_this)
    ggplot(plot_this, aes(plot_this$goal, plot_this$pledged,
                          shape = plot_this$state, color=plot_this$state, main = "Kickstarter Campaigns")) + 
      geom_point() + 
      theme_classic() +
      xlab("Goal") +
      ylab("Pledged") +
      scale_fill_discrete(name = "Status", labels = c("Canceled","Failed","Live","Successful","Suspended"))
  }
  )
}

shinyApp(ui = ui, server = server)

#rsconnect ----
install.packages("rsconnect")
library(rsconnect)
rsconnect::setAccountInfo(name='margaretjeane',
                          token='A0364D2A23D443727D1AC4319A6DBC39',
                          secret='wM89gticT1J8dTYUaIbvzJBMjtLTiHjkeqojtkNZ')
