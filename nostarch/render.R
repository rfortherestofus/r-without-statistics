# Load Packages -----------------------------------------------------------

library(tidyverse)
library(rmarkdown)
library(knitr)
library(namer)


# Render data viz file ----------------------------------------------------

source("_common.R")

render(
  input = "data-viz.Rmd",
  output_dir = "nostarch/data-viz",
  output_format = "word_document"
)

beepr::beep()
