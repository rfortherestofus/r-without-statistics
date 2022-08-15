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

save_figure_for_nostarch <- function(figure_height = 4, chap_number = chapter_number, print_figure_number = TRUE) {
  
  chapter_number_two_digits <- stringr::str_pad(chap_number, 2, "left", "0")
  figure_number_three_digits <- stringr::str_pad(i, 3, "left", "0")
  
  file_name <- str_glue("F{chapter_number_two_digits}{ figure_number_three_digits }.pdf")
  save_directory <- here::here("nostarch/figures/")
  
  ggsave(plot = last_plot(),
         path = save_directory,
         filename = file_name,
         device = cairo_pdf,
         width = 4.675,
         height = figure_height)
  
  i <<- i + 1
  
  if (print_figure_number == TRUE) {
    
    file_name_with_brackets <- str_glue("[{file_name}]")
    
    cat(file_name_with_brackets, sep = "\n")
    
  }
  
}

save_image_for_nostarch <- function(image_file, chap_number = chapter_number, print_figure_number = TRUE) {
  
  chapter_number_two_digits <- stringr::str_pad(chap_number, 2, "left", "0")
  figure_number_three_digits <- stringr::str_pad(i, 3, "left", "0")
  
  file_name <- str_glue("F{chapter_number_two_digits}{ figure_number_three_digits }.png")
  save_directory <- here::here("nostarch/figures/")
  
  fs::file_copy(path = image_file,
                new_path = str_glue("{save_directory}/{file_name}"),
                overwrite = TRUE)
  
  knitr::include_graphics(image_file)
  
  i <<- i + 1
  
  if (print_figure_number == TRUE) {
    
    file_name_with_brackets <- str_glue("[{file_name}]")
    
    cat(file_name_with_brackets, sep = "\n")
    
  }
  
}
