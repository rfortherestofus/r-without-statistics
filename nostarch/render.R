
# Load Packages -----------------------------------------------------------

library(tidyverse)
library(janitor)
library(fs)
library(rmarkdown)
library(xfun)
library(officer)
library(zip)

# Copy source files -------------------------------------------------------

source_files <- dir_ls(regexp = "Rmd|yml|css|_common")

file_copy(path = source_files,
          new_path = "nostarch/source",
          overwrite = TRUE)

# Copy data

dir_copy(path = "data",
         new_path = "nostarch/source/data",
         overwrite = TRUE)

# Make figure numbers show ------------------------------------------------

# Fix stuff in _common.R

gsub_file(file = "nostarch/source/_common.R",
          'output_format = "html"',
          'output_format = "word"')

gsub_file(file = "nostarch/source/_bookdown.yml",
          '\\# fig: \\!expr function\\(i\\) paste\\(""\\)',
          'fig: !expr function(i) paste("")')

# Delete all existing figures ---------------------------------------------

file_delete(dir_ls("nostarch/figures/"))

# Render ------------------------------------------------------------------

render_site(input = "nostarch/source",
            output_format = 'bookdown::word_document2',
            encoding = 'UTF-8')


# Copy Word doc -----------------------------------------------------------

file_copy(path = "nostarch/source/_book/r-without-statistics.docx",
          new_path = "nostarch/word",
          overwrite = TRUE)

file_show("nostarch/word/r-without-statistics.docx")


# Zip all figures ---------------------------------------------------------

all_figures <- dir_ls("nostarch/figures/")

zip(zipfile = "nostarch/figures/figures.zip",
    files = all_figures)

# Beep --------------------------------------------------------------------

beepr::beep()

