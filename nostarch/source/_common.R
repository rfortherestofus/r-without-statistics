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

i <- 1

create_nostarch_file_name <- function(file_type = "pdf", chap_number = chapter_number, print_figure_number = TRUE) {
  
  chapter_number_two_digits <- stringr::str_pad(chap_number, 2, "left", "0")
  figure_number_three_digits <- stringr::str_pad(i, 3, "left", "0")
  
  file_name <- stringr::str_glue("F{chapter_number_two_digits}{ figure_number_three_digits }.{file_type}")
  
  i <<- i + 1
  
  file_name
  
}

print_nostarch_file_name <- function(file_type_to_print = "pdf") {
  
  file_name_with_brackets <- stringr::str_glue("[{create_nostarch_file_name(file_type = file_type_to_print)}]")
  
  cat(file_name_with_brackets)
  
}


create_nostarch_file_name(chap_number = 2)

save_figure_for_nostarch <- function(figure_height = 4) {
  
  save_directory <- here::here("nostarch/figures/")
  file_name <- create_nostarch_file_name()
  
  ggsave(plot = last_plot(),
         path = save_directory,
         filename = file_name,
         device = cairo_pdf,
         width = 4.675,
         height = figure_height)

  
}

save_image_for_nostarch <- function(image_file, chap_number = chapter_number) {
  
  chapter_number_two_digits <- stringr::str_pad(chap_number, 2, "left", "0")
  figure_number_three_digits <- stringr::str_pad(i, 3, "left", "0")
  
  file_name <- create_nostarch_file_name(file_type = "png")
  save_directory <- here::here("nostarch/figures/")
  
  fs::file_copy(path = image_file,
                new_path = str_glue("{save_directory}/{file_name}"),
                overwrite = TRUE)
  
}
