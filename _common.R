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

save_figure_for_nostarch <- function(figure_height = 4, chap_number = chapter_number) {
  
  chapter_number_two_digits <- stringr::str_pad(chap_number, 2, "left", "0")
  figure_number_three_digits <- stringr::str_pad(i, 3, "left", "0")
  
  file_name <- str_glue("nostarch/figures/F{chapter_number_two_digits}{ figure_number_three_digits }.pdf")
  
  ggsave(plot = last_plot(),
         filename = file_name,
         device = cairo_pdf,
         width = 4.675,
         height = figure_height)
  
  i <<- i + 1
  
  # file_name_without_path <- str_remove(file_name, "nostarch/figures/")
  # file_name_without_path <- str_glue("[{file_name_without_path}]")
  # 
  # cat(file_name_without_path)
  
}

save_image_for_nostarch <- function(image_file, chap_number = chapter_number) {
  
  chapter_number_two_digits <- stringr::str_pad(chap_number, 2, "left", "0")
  figure_number_three_digits <- stringr::str_pad(i, 3, "left", "0")
  
  fs::file_copy(path = image_file,
                new_path = str_glue("nostarch/figures/F{chapter_number_two_digits}{ figure_number_three_digits }.png"),
                overwrite = TRUE)
  
  knitr::include_graphics(image_file)
  
  i <<- i + 1
  
}
