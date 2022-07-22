# Load Packages -----------------------------------------------------------

library(tidyverse)
library(rmarkdown)
library(knitr)
library(fs)

source("_common.R")


# Chapter to Render --------------------------------------------------------

chapter_to_render <- "data-viz.Rmd"



# Render data viz file ----------------------------------------------------

render_chapter <- function(chapter_rmd) {
  
  
  save_figure_for_nostarch <- function(figure_height = 4) {
    
    figure_number_three_digits <- stringr::str_pad(i, 3, "left", "0")
    
    ggsave(plot = last_plot(),
           filename = str_glue("nostarch/figures/fCHAPTERNUMBER{ figure_number_three_digits }.pdf"),
           device = cairo_pdf,
           width = 4.675,
           height = figure_height)
    
    i <<- i + 1
    
  }
  
  save_image_for_nostarch <- function(image_file) {
    
    figure_number_three_digits <- stringr::str_pad(i, 3, "left", "0")
    
    fs::file_copy(path = image_file,
                  new_path = str_glue("nostarch/figures/fCHAPTERNUMBER{ figure_number_three_digits }.png"),
                  overwrite = TRUE)
    
    knitr::include_graphics(image_file)
    
    i <<- i + 1
    
  }
  
  render(
    input = chapter_rmd,
    output_dir = "nostarch/chapters",
    output_format = "bookdown::word_document2"
  )
  
}

render_chapter(chapter_to_render)


# Rename figures ----------------------------------------------------------


chapters <- tibble(
  rmd = c("introduction.Rmd",
          
          # "illuminate.Rmd",
          
          "data-viz.Rmd",
          "custom-theme.Rmd",
          "maps.Rmd",
          "tables.Rmd",
          
          "rmarkdown.Rmd",
          "parameterized-reports.Rmd",
          "presentations.Rmd",
          "websites.Rmd",
          
          "tidycensus.Rmd",
          "qualtrics.Rmd",
          "functions.Rmd",
          "custom-packages.Rmd",
          
          "conclusion.Rmd")) %>% 
  mutate(chapter_number = row_number())


rename_single_figure <- function(incorrectly_named_file, chapter_to_render_filter = chapter_to_render) {
  
  chapter_number <- chapters %>% 
    filter(rmd == chapter_to_render_filter) %>% 
    pull(chapter_number)
  
  correctly_named_file <- chapters %>%
    filter(rmd == chapter_to_render) %>% 
    mutate(chapter_number_two_digits = str_pad(chapter_number, 2, "left", "0")) %>% 
    mutate(correctly_named_file = str_replace(incorrectly_named_file, "CHAPTERNUMBER", chapter_number_two_digits)) %>% 
    pull(correctly_named_file)
  
  file_move(path = incorrectly_named_file,
            new_path = correctly_named_file)
  
}


all_figures <- dir_ls("nostarch/figures",
                      regex = "CHAPTERNUMBER")

walk(all_figures, rename_single_figure)

