# Closing connection

on_connection_closed <- function(pkg_name) {
  observer <- getOption("connectionObserver")
  if (!is.null(observer))
    observer$connectionClosed(type = "Data sets", host = pkg_name)
}

close_connection <- function(pkg_name) {
  on_connection_closed(pkg_name)
  print("Connection closed")
}

# For connection open

list_objects <- function(includeType, data_names, data_type) {
  if (includeType) {
    data.frame(
      name = data_names,
      type = rep_len("table", length(data_names)),
      stringsAsFactors = FALSE
    )
  } else {
    tables
  }
}

tibble_res <- function(label, type){
  data.frame(
    name = label,
    type = type
  )
}

list_columns <- function(table, pkg_name) {
  #browser()
  res <- get(data(list = table, package = pkg_name))
  tibble_res(
    label = "class",
    type = paste(class(res), collapse = ", "))
}

preview_object <- function(pkg_name, table, limit) {
  #browser()
  res <- get(data(list = table, package = pkg_name))
  res
}

#' @importFrom utils browseURL

pkg_actions <- function(pkg_name){
  # list(
  #   help = list(
  #     icon = system.file("icons","github.png", package = "neo4r"),
  #     callback = function() {
  #       help(pkg_name, try.all.packages = TRUE, help_type = "text")
  #     }
  #   )
  # )
}

list_objects_types <- function() {
  return(
    list(
      table = list(contains = "data")
    )
  )
}

#' @keywords internal
#' @importFrom glue glue
#' @export

on_connection_opened <- function(pkg_name = "pkg") {
  data_list  <- data(package = pkg_name)
  data_results <- as.data.frame(data_list$results)
  observer <- getOption("connectionObserver")
  if(!is.null(observer)){
    observer$connectionOpened(type = "Data sets",
                              host = pkg_name,
                              displayName = pkg_name,
                              icon = system.file("img","package.png", package = "fryingpane"),
                              connectCode = glue('library(fryingpane)\nopen_{pkg_name} <- serve("{pkg_name}")\nopen_{pkg_name}()'),
                              disconnect = function() {
                                close_connection(pkg_name)
                              },
                              listObjectTypes = function () {
                                list_objects_types()
                              },
                              listObjects = function(type = "table") {
                                list_objects(includeType = TRUE,
                                             data_names = as.character(data_results$Item),
                                             data_type = "dataset")
                              },
                              listColumns = function(table) {
                                list_columns(table, pkg_name = pkg_name)
                              },
                              previewObject = function(rowLimit, table) {
                                preview_object(pkg_name = pkg_name, table, rowLimit)
                              },
                              actions = pkg_actions(pkg_name),
                              connectionObject = pkg_name )
  }
}


#' Create a Pane Connection Function
#'
#' @param pkg_name the name of the package
#'
#' @return a function for closing the connection
#' @export
#'
#' @examples
#' \dontrun{
#' open_connection <- pane_open("dplyr")
#' open_connection()
#' }

serve <- function(pkg_name){
  test_if_exists(pkg_name)
  function(...){
    on_connection_opened(pkg_name)
  }
}

#' @importFrom attempt stop_if
#' @importFrom glue glue

test_if_exists <- function(pkg_name){
  stop_if(find.package(pkg_name, quiet = TRUE),
          ~ length(.x) == 0,
          glue("{pkg_name} wasn't found on the machine."))
}

