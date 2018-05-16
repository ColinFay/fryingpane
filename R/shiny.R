# Shiny APP
rsApiUpdateDialog <- function(code) {
  if (exists(".rs.api.updateDialog")) {
    updateDialog <- get(".rs.api.updateDialog")
    updateDialog(code = code)
  }
}

#' @importFrom shiny tags div textInput

ui <- function(){
  tags$div(
    tags$head(
      tags$style(
        HTML(paste("
                   .shiny-input-container {
                   display: table-row;
                   height: 24px;
                   }
                   .shiny-input-container > label {
                   display: table-cell;
                   width: 145px;
                   }
                   .shiny-input-container > input {
                   display: table-cell;
                   width: 300px;
                   }
                   ", sep = ""))
      )
    ),
    div(style = "table-row",
        textInput(
          "package",
          "Package:",
          value = "dplyr"
        )
    )
  )

}

#' @importFrom glue glue

build_code <- function(package){
    glue('library(fryingpane)\ncook("{package}")')
}

#' @importFrom shiny shinyApp

server <- function(input, output, session) {
  observe({
    rsApiUpdateDialog(build_code(input$package))
  })
}

#' @keywords internal
#' @importFrom shiny shinyApp
#' @export

run_app <- function(){
  shinyApp(ui, server)
}

