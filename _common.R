# example R options set globally
options(width = 60)

# example chunk options set globally
knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  warning = FALSE,
  message = FALSE,
  echo = FALSE,
  dpi = 150,
  out.width = "100%",
  dev = "ragg_png"
)


# Functions ---------------------------------------------------------------

create_nostarch_file_name <- function(file_type = "pdf", chap_number = chapter_number, print_figure_number = FALSE) {
  
  chapter_number_two_digits <- stringr::str_pad(chap_number, 2, "left", "0")
  figure_number_three_digits <- stringr::str_pad(i, 3, "left", "0")
  
  file_name <- stringr::str_glue("F{chapter_number_two_digits}{ figure_number_three_digits }.{file_type}")
  
  file_name
  
}

print_nostarch_file_name <- function(file_type_to_print = "pdf", actually_print = FALSE) {
  
  file_name_with_brackets <- stringr::str_glue("[{create_nostarch_file_name(file_type = file_type_to_print)}]")
  
  if (actually_print == TRUE) {
    
    cat(file_name_with_brackets)
    
  }
  
}


save_figure_for_nostarch <- function(figure_height = 4) {
  
  save_directory <- here::here("nostarch/figures/")
  file_name <- create_nostarch_file_name()
  
  ggsave(plot = last_plot(),
         path = save_directory,
         filename = file_name,
         device = cairo_pdf,
         width = 4.675,
         height = figure_height)
  
  i <<- i + 1
  
  
}

library(tidyverse)
pixel / dpi = inches



save_image_for_nostarch <- function(image_file, chap_number = chapter_number) {
  
  image_info <- magick::image_read(image_file) %>%
    magick::image_info() 
  
  image_width_pixels <- image_info %>% 
    pull(width)
  
  image_dpi <- image_info %>%
    separate(density, sep = "x", into = c("dpi", NA)) %>% 
    mutate(dpi = as.numeric(dpi)) %>% 
    pull(dpi)
  
  image_width_inches <- image_width_pixels / image_dpi
  
  image_width_scale_down_factor <- image_width_inches / 4.675
  
  image_new_width <- image_width_pixels / image_width_scale_down_factor
  
  resized_image <- magick::image_read(image_file) %>% 
    magick::image_resize(image_new_width)
  
  chapter_number_two_digits <- stringr::str_pad(chap_number, 2, "left", "0")
  figure_number_three_digits <- stringr::str_pad(i, 3, "left", "0")
  
  file_name <- create_nostarch_file_name(file_type = "png")
  save_directory <- here::here("nostarch/figures/")
  image_full_path <- stringr::str_glue("{save_directory}/{file_name}")
  
  magick::image_write(resized_image,
                      path = image_full_path)

  i <<- i + 1
  
}
