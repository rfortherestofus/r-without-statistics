library(tidyverse)
library(here)

state <- tibble(state.name) %>%
  rbind("District of Columbia") %>% 
  pull(state.name)

reports <- tibble(
  input = here("interviews/urban-covid-budget-report.Rmd"),
  output_file = stringr::str_glue(here("interviews/reports/{state}.html")),
  params = map(state, ~list(state = .))
)

reports %>%
  pwalk(rmarkdown::render)
