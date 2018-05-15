colin::fill_desc("fryingpane", "Serve Datasets in RStudio Connection Pane",
                 "Use the RStudio Connection Pane to serve the data from a package.", repo = "fryingpane")

colin::init_docs()

usethis::use_code_of_conduct()

usethis::use_package("attempt")
usethis::use_package("glue")
usethis::use_build_ignore("readme_fig/")
