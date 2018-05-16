
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

# fryingpane

Serve the datasets from a package inside the RStudio Connection Pane.

## Installation

You can install the dev version of {fryingpane} from
[Github](https://github.com/ColinFay/fryingpane) with:

``` r
# install.packages("remotes")
remotes::install_github("ColinFay/fryingpane")
```

## What is this about?

### In your package

Use this package to create functions for displaying your package data
inside the RStudio Connection Pane.

**Note that you’ll need both opening and closing functions, either in a
package or interactively**.

`{fryingpane}` should be listed as a dependency to your new package.

#### Function to launch connection

Create a function that launch the connection pane with the datasets from
your package. This function should have this form in the `.R` (change
`mypkg` to the name of your package):

``` r
#' Launch Connection Pane
#' @export
#' @importFrom fryingpane serve
#' @example 

open_connection <- fryingpane::serve("mypkg")
```

#### Function to close the connection

**Important: don’t change the name of close\_connection()**

``` r
#' Stop Connection Pane
#' @export
#' @importFrom fryingpane close
#' @example 

close_connection <- fryingpane::close("mypkg")
```

### View the data from another package

You can open the datasets from another package.

**Please note that you need to create BOTH functions when using
interactively.**

``` r
library(fryingpane)
open_dplyr <- serve("dplyr")
close_connection <- close("dplyr")
open_dplyr()
```

![](readme_fig/pane.png)

Close the connection with the ad hoc button.

You can find an history of your last connection in the Connections pane.

![](readme_fig/hist.png)

![](readme_fig/hist2.png)

## Contact

Questions and feedbacks [welcome](mailto:contact@colinfay.me)\!

You want to contribute ? Open a
[PR](https://github.com/ColinFay/fryingpane/pulls) :) If you encounter a
bug or want to suggest an enhancement, please [open an
issue](https://github.com/ColinFay/fryingpane/issues).

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
