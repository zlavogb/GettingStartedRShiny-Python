library(shiny)
library(data.table)
library(reticulate)

imdb_data = fread("imdb_df_subset.csv")

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Movie selector"),
 
  
  fluidRow(
    tabsetPanel(
      type = "tabs",
      # summary tab
      tabPanel("Select Genre", uiOutput("genres"), htmlOutput("one")),
      tabPanel("Select Year", uiOutput("years"), htmlOutput("two"))
    )
  )
)

source_python('python_ref.py')

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  output$genres<-renderUI({
    selectInput("genre", label = h4("Choose genre"),
                choices = sort(unique(imdb_data$genres)),selected = 1
    )
  })
  
  output$years<-renderUI({
    selectInput("yr", label = h4("Choose year"), 
                choices = sort(unique(imdb_data$startYear)),
                multiple = F)
  })
  
  output$one <- renderUI({
    
    value = input$genre
    returnedText = matchGenre(value)
    ls=""
    for(i in returnedText){
      ls = HTML(paste(ls, i, sep="<br/>"))
    }
    print(ls)
  })
  
  output$two <- renderUI({
    
    value2 = input$yr
    returnedText2 = matchYear(as.integer(value2))
    ls2=""
    for(i in returnedText2){
      ls2 = HTML(paste(ls2, i, sep="<br/>"))
    }
    print(ls2)
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)

