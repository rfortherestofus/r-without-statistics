# example R options set globally
options(width = 60)

# example chunk options set globally
knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  warning = FALSE,
  message = FALSE,
  echo = FALSE,
  dpi = 300,
  fig.width = 4.675
)


# Functions ---------------------------------------------------------------

save_figure_for_nostarch <- function(chapter_number = 1, figure_height = 7) {

  chapter_number_two_digits <- stringr::str_pad(chapter_number, 2, "left", "0")
  figure_number_three_digits <- stringr::str_pad(i, 3, "left", "0")
  
  ggsave(plot = last_plot(),
         filename = str_glue("nostarch/figures/f{ chapter_number_two_digits }{ figure_number_three_digits }.pdf"),
         device = cairo_pdf,
         width = 4.675,
         height = figure_height)
  
  i <<- i + 1
  
}

save_image_for_nostarch <- function(image_file, chapter_number = 1) {
  
  chapter_number_two_digits <- stringr::str_pad(chapter_number, 2, "left", "0")
  figure_number_three_digits <- stringr::str_pad(i, 3, "left", "0")
  
  fs::file_copy(path = image_file,
                new_path = str_glue("nostarch/figures/f{ chapter_number_two_digits }{ figure_number_three_digits }.png"),
                overwrite = TRUE)
  
  knitr::include_graphics(image_file)
  
  i <<- i + 1
  
}
