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
  fig.width = 4.675,
  dev = "ragg_png"
)


# Functions ---------------------------------------------------------------

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
