# Everything
rmarkdown::render_site()

# Website only
rmarkdown::render_site(output_format = 'bookdown::bs4_book', encoding = 'UTF-8')

# Just Word
rmarkdown::render_site(output_format = 'bookdown::word_document2', encoding = 'UTF-8')