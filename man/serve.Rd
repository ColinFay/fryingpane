% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pane.R
\name{serve}
\alias{serve}
\title{Create a Pane Connection Function}
\usage{
serve(pkg_name)
}
\arguments{
\item{pkg_name}{the name of the package}
}
\value{
a function for closing the connection
}
\description{
Create a Pane Connection Function
}
\examples{
\dontrun{
open_connection <- pane_open("dplyr")
open_connection()
}
}
