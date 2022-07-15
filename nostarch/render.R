library(tidyverse)
library(rmarkdown)

source("_common.R")

render(
  input = "data-viz.Rmd",
  output_dir = "word",
  output_format = "word_document"
)

beepr::beep()
