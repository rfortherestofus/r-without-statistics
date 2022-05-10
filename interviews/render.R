library(tidyverse)

state <- tibble(state.name) %>%
  rbind("District of Columbia") %>% 
  pull(state.name)

reports <- tibble(
  output_file = stringr::str_c(here("interviews/reports/"), state, ".html"),
  params = map(state, ~list(state = .))
)

reports %>%
  pwalk(rmarkdown::render, input = here("interviews/urban-covid-budget-report.Rmd"))
