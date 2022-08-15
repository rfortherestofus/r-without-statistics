
# Load Packages -----------------------------------------------------------

library(tidyverse)
library(janitor)
library(fs)
library(rmarkdown)
library(xfun)

# Copy source files -------------------------------------------------------

source_files <- dir_ls(regexp = "Rmd|yml|css|_common")

file_copy(path = source_files,
          new_path = "nostarch/source",
          overwrite = TRUE)


# Make figure numbers show ------------------------------------------------

# Fix stuff in _common.R

gsub_file(file = "nostarch/source/_common.R",
          "print_figure_number = FALSE",
          "print_figure_number = TRUE")

gsub_files(files = dir_ls(path = "nostarch/source", regexp = "Rmd"),
          "print_nostarch_file_name\\(\\)",
          "print_nostarch_file_name(actually_print = TRUE)")

gsub_files(files = dir_ls(path = "nostarch/source", regexp = "Rmd"),
          'print_nostarch_file_name\\(file_type_to_print = "png"\\)',
          'print_nostarch_file_name(file_type_to_print = "png", actually_print = TRUE)')



# Render ------------------------------------------------------------------

render_site(input = "nostarch/source",
            output_format = 'bookdown::word_document2', 
            encoding = 'UTF-8')


# Copy Word doc -----------------------------------------------------------

file_copy(path = "nostarch/source/_book/r-without-statistics.docx",
          new_path = "nostarch/word",
          overwrite = TRUE)

file_show("nostarch/word/r-without-statistics.docx")


# Manual Rendering --------------------------------------------------------

# Everything
# rmarkdown::render_site()

# Website only
# rmarkdown::render_site(output_format = 'bookdown::bs4_book', encoding = 'UTF-8')

# Just Word
# rmarkdown::render_site(output_format = 'bookdown::word_document2', encoding = 'UTF-8')