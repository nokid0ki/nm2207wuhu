library(shiny)

generate_star_emojis <- function(rating) {
  stars <- paste0(rep("⭐️", rating), collapse = "")
  return(stars)
}

ui <- fluidPage(
  titlePanel("Here is a funny cat photo"),
  sidebarLayout(
    position = "left",
    sidebarPanel("Please rate this photo"),
    mainPanel(
      img(src = "huh.jpeg", height = 200, width = 400)
    )
  ),
  sidebarPanel(
    sliderInput("integer", "Rating for ket",
                min = 0, max = 10,
                value = 5),
    sliderInput("animation", "Your reading (press to start and stop)",
                min = 1, max = 10,
                value = 1, step = 1,
                animate = animationOptions(interval = 3, loop = TRUE))
  ),
  mainPanel(
    em("Catto"),
    br(),
    tableOutput("values"),
    h3("Read your fortune below"),
    "If you got 1-3: You will eat good food for dinner",
    br(),
    "If you got 4-6: You will eat airplane food for dinner",
    br(),
    "If you got 7-10: You will not eat"
  )
)

server <- function(input, output) {
  sliderValues <- reactive({
    data.frame(
      Name = c("Rating for ket", "Read below for your fortune"),
      Value = c(generate_star_emojis(input$integer),
                input$animation), 
      stringsAsFactors = FALSE
    )
  })
  
  output$values <- renderTable({
    sliderValues()
  })
}

shinyApp(ui, server)
