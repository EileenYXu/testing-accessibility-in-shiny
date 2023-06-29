#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(bslib)

light <- bs_theme(version = 4, bootswatch = "cerulean")
dark <- bs_theme(version = 4, bootswatch = "darkly")
contrast <- bs_theme(version = 4,
                            bg = "#000000",
                            fg = "#FFFFFF",
                            primary = "#FFFF00",
                            secondary = "#EA80FC",
                            success = "#00FF00",
                            info = "#00ffff",
                            warning = "#FFCF00",
                            danger = "#FFFF00")
large <- bs_theme(version = 4, bootswatch = "cerulean", font_scale = 3)
largecontrast <- bs_theme(version = 4,
                          bg = "#000000",
                          fg = "#FFFFFF",
                          primary = "#FFFF00",
                          secondary = "#EA80FC",
                          success = "#00FF00",
                          info = "#00ffff",
                          warning = "#FFCF00",
                          danger = "#FFFF00",
                          font_scale = 3)

# Define UI for application that draws a histogram
ui <- navbarPage("Navbar",
                 theme = light, 
                 selectInput("Theme", label = "Display Theme",
                             choices = c("Default", "Dark mode", "High contrast",
                                         "Large font", "High contrast large font")),
    # Application title
    tabPanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
    observe(session$setCurrentTheme(
      if (input$Theme == "Dark mode") {dark} else 
        if (input$Theme == "High contrast"){contrast} else 
          if (input$Theme == "Large font"){large} else
            if (input$Theme == "High contrast large font"){largecontrast} else 
      {light}
    ))
}


# Run the application 
shinyApp(ui = ui, server = server)
