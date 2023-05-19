# Crash Course

Statistical Inference via Data Science: A ModernDive into R and the Tidyverse by Chester Ismay and Albert Y. Kim (CRC Press, 2020). https://moderndive.com/

Getting Started with R course. https://rfortherestofus.com/courses/getting-started/

# Data Viz

Data Visualization: A Practical Introduction by Kieran Healy (Princeton University Press, 2018). https://socviz.co

Fundamentals of Data Visualization by Claus Wilke (O'Reilly Media, 2019). https://clauswilke.com/dataviz/

ggplot2: Elegant Graphics for Data Analysis by Hadley Wickham, Danielle Navarro, and Thomas Lin Pedersen (Springer, Forthcoming). https://ggplot2-book.org

Graphic Design with ggplot2 by Cédric Scherer (CRC Press, Forthcoming)

The Glamour of Graphics course by Will Chase. https://rfortherestofus.com/courses/glamour/

# Custom Themes

BBC Visual and Data Journalism cookbook for R graphics (2019). https://bbc.github.io/rcookbook/

How the BBC Visual and Data Journalism team works with graphics in R by BBC Visual and Data Journalism team (2019). https://medium.com/bbc-visual-and-data-journalism/how-the-bbc-visual-and-data-journalism-team-works-with-graphics-in-r-ed0b35693535

# Maps

Geocomputation with R by Robin Lovelace, Jakub Nowosad, and Jannes Muenchow (CRC Press, 2019). https://r.geocompx.org/

Chapter 7 (Draw Maps) of Data Visualization: A Practical Introduction by Kieran Healy (Princeton University Press, 2018). https://socviz.co

Lessons on Space from Data Visualization: Use R, ggplot2, and the principles of graphic design to create beautiful and truthful visualizations of data course by Andrew Weiss (2022). https://datavizs22.classes.andrewheiss.com/content/12-content/

# Tables

Ten Guidelines for Better Tables by Jon Schwabish (Journal of Benefit-Cost Analysis, 2020). https://doi.org/10.1017/bca.2020.11

10+ Guidelines for Better Tables in R by Tom Mock (2020). https://themockup.blog/posts/2020-09-04-10-table-rules-in-r/

Creating beautiful tables in R with {gt} by Albert Rapp (2022). https://gt.albert-rapp.de/

# R Markdown

R Markdown: The Definitive Guide by Yihui Xie, J. J. Allaire, and Garrett Grolemund (CRC Press, 2019). https://bookdown.org/yihui/rmarkdown/

R Markdown Cookbook by Yihui Xie, Christophe Dervieux, Emily Riederer (CRC Press, 2021). https://bookdown.org/yihui/rmarkdown-cookbook/

# Parameterized Reporting

Using R Markdown to Track and Publish State Data by Data@Urban team (2021). https://urban-institute.medium.com/using-r-markdown-to-track-and-publish-state-data-d1291bfa1ec0 

Iterated fact sheets with R Markdown by Data@Urban team (2018). https://urban-institute.medium.com/iterated-fact-sheets-with-r-markdown-d685eb4eafce

# xaringan

Sharing Your Work with `xaringan`: An Introduction to `xaringan` for Presentations: The Basics and Beyond by Silvia Canelón (2020). https://spcanelon.github.io/xaringan-basics-and-beyond/index.html

Professional, Polished, Presentable: Making Great Slides with `xaringan` workshop materials by Garrick Aden-Buie, Silvia Canelón, and Shannon Pileggi (2021). https://presentable-user2021.netlify.app/

Meet `xaringan`: Making slides in R Markdown by Alison Hill (2019). https://arm.rbind.io/slides/xaringan.html

Chapter 7 (`xaringan` Presentations) of R Markdown: The Definitive Guide by Yihui Xie, J. J. Allaire, and Garrett Grolemund (CRC Press, 2019). https://bookdown.org/yihui/rmarkdown/

# Websites

Building a blog with `distill` by Tom Mock (2020). https://themockup.blog/posts/2020-08-01-building-a-blog-with-distill/

The Distillery website showcasing websites made with `distill`. https://distillery.rbind.io/

# Quarto

Get Started with Quarto workshop materials by Tom Mock (2022). https://jthomasmock.github.io/quarto-in-two-hours/

From R Markdown to Quarto workshop materials by Andrew Bray, Rebecca Barter, Silvia Canelón, Christophe Dervieu, Devin Pastor, and Tatsu Shigeta (2022). https://rstudio-conf-2022.github.io/rmd-to-quarto/

# Accessing Online Data

Automated survey reporting with googlesheets4, pins, and R Markdown by Isabella Velásquez and Curtis Kephart (2022). https://posit.co/blog/automated-survey-reporting/

Analyzing US Census Data: Methods, Maps, and Models in R by Kyle Walker (CRC Press, 2023). https://walker-data.com/census-r/

# Packages

R Packages, Second Edition by Hadley Wickham and Jennifer Bryan (O'Reilly Media, Forthcoming). https://r-pkgs.org/

Package Development with R course by Malcolm Barrett. https://rfortherestofus.com/courses/package-development-course/

Learn-more-content


---



# Overview of Exercises

- Make data viz, theme, map, and table
- Add data viz, theme, map, and table to Rmd
- Turn Rmd into parameterized report
- Make slides from Rmd
- Make website from Rmd with page for 5 states
- Convert code to import data to use `tidycensus`
- Make your own package with theme

# Crash Course

## Exercises

- Install R + RStudio
- Create project
- Download data file
- Install tidyverse
- Import data file with `read_csv()`
- Calculate summary stat with `summarize()` function

## Learn More

- Getting Started course
- Modern Dive chapter 1



# Data Viz

## Exercises

- Give half started data viz and ask them to make it nice

## Learn More

- Kieran Healy's [Data Visualization: A Practical Introduction](https://socviz.co)
- Claus Wilke's [Fundamentals of Data Visualization](https://clauswilke.com/dataviz/)
- The upcoming third edition of [ggplot2: Elegant Graphics for Data Analysis by Hadley Wickham, Danielle Navarro, and Thomas Lin Pedersen](https://ggplot2-book.org)
- Cédric Scherer's upcoming book on ggplot
- [Cedric blog post](https://cedricscherer.netlify.app/2019/08/05/a-ggplot2-tutorial-for-beautiful-plotting-in-r/)
- [Will Chase Glamour talk](https://www.youtube.com/watch?v=h5cTacaWE6I&ab_channel=PositPBC)

# Theme

## Exercises

- Make your own theme

## Learn More

- [`bbplot` package](https://github.com/bbc/bbplot)
- [BBC R Cookbook](https://bbc.github.io/rcookbook/)
- [Medium article about `bbplot`](https://medium.com/bbc-visual-and-data-journalism/how-the-bbc-visual-and-data-journalism-team-works-with-graphics-in-r-ed0b35693535)
- [Chapter 18 of ggplot book](https://ggplot2-book.org/polishing.html)

# Maps

## Exercises

- Give data and half started code to have people make nice map

## Learn More

- [Geocomputation with R](https://r.geocompx.org/) by Robin Lovelace, Jakub Nowosad, and Jannes Muenchow
- [Chapter 7 of Kieran Healy book](https://socviz.co/maps.html)
- [Andrew Heiss lessons](https://datavizs22.classes.andrewheiss.com/content/12-content/)

# Tables

## Exercises

- Give data and half started code to have people make nice table

## Learn More

[Ten Guidelines for Better Tables $](https://doi.org/10.1017/bca.2020.11)
	- [Twitter thread summarizing paper](https://twitter.com/jschwabish/status/1290323581881266177?lang=en)
	- [Tom Mock article](https://themockup.blog/posts/2020-09-04-10-table-rules-in-r/)
- [Albert Rapp Creating beautiful tables in R with {gt}](https://gt.albert-rapp.de/)

# R Markdown

## Exercises

## Learn More

- [R Markdown: The Definitive Guide](https://bookdown.org/yihui/rmarkdown/) by Yihui Xie, J. J. Allaire, and Garrett Grolemund
- [R Markdown Cookbook](https://bookdown.org/yihui/rmarkdown-cookbook/) by Yihui Xie, Christophe Dervieux, Emily Riederer
- Add Quarto stuff?

# Parameterized Reports



## Exercises

## Learn More

- [Iterated fact sheets with R Markdown](https://urban-institute.medium.com/iterated-fact-sheets-with-r-markdown-d685eb4eafce)
- [Chapter 15 of R Markdown: The Definitive Guide](https://bookdown.org/yihui/rmarkdown/parameterized-reports.html)

# xaringan

## Exercises

## Learn More

- [Presentation](https://spcanelon.github.io/xaringan-basics-and-beyond/index.html) 
- [Basics slides](https://spcanelon.github.io/xaringan-basics-and-beyond/slides/day-01-basics.html#1) 
- [Basics slides code](https://github.com/spcanelon/xaringan-basics-and-beyond/blob/main/slides/day-01-basics.Rmd) 
- [Professional, Polished, Presentable: MAKING GREAT SLIDES WITH XARINGAN](https://presentable-user2021.netlify.app/) and [video](https://www.youtube.com/watch?v=RPFh3y9UAX4)
- [Alison Hill slides](https://arm.rbind.io/slides/xaringan.html)
- [Chapter 7 of R Markdown Definitive Guide](https://bookdown.org/yihui/rmarkdown/xaringan.html)

# Websites

## Exercises

## Learn More

- [The Distillery](https://distillery.rbind.io/)
- [Tom Mock article](https://themockup.blog/posts/2020-08-01-building-a-blog-with-distill/)

# Accessing Online Data

## Exercises

## Learn More

- [Automated survey reporting with googlesheets4, pins, and R Markdown](https://posit.co/blog/automated-survey-reporting/)
- [Analyzing US Census Data: Methods, Maps, and Models in R](https://walker-data.com/census-r/)
- [Accessing and Analyzing US Census Data in R - Hour 1 - Getting Started with tidycensus](https://www.youtube.com/watch?v=Lk60xLfT6Dg&ab_channel=JohnDeWitt)

# Packages

## Exercises

## Learn More

- [R Packages, Second Edition](https://r-pkgs.org/)
- [Malcolm Barrett | You're Already Ready: Zen and the Art of R Package Development](https://www.youtube.com/watch?v=Mb7wZZ6nPLA&ab_channel=PositPBC)


