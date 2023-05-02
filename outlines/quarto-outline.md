# References 

- [Tom Mock Quarto in Two Hours](https://jthomasmock.github.io/quarto-in-two-hours/)
- [From R Markdown to Quarto](https://rstudio-conf-2022.github.io/rmd-to-quarto/)
- [FAQ for R Markdown users](https://quarto.org/docs/faq/rmarkdown.html)

# Intro

- https://app.convertkit.com/campaigns/9478464/report/content
- https://posit.co/blog/announcing-quarto-a-new-scientific-and-technical-publishing-system/

- Why Quarto
	- Not R specific
	- Multiple languages
	- Works in multiple IDEs
	- More consistent syntax

- Benefits of Quarto
	- "RMarkdown grew into a large ecosystem, with varying syntax." - [Source](https://jthomasmock.github.io/quarto-in-two-hours/materials/01-intro-quarto.html#/one-install-batteries-included)
	- Better accessibility
	- faster live preview
	- Where new changes will live

- Drawbacks of Quarto
	- Doesn't support all formats yet (pagedown)

# Setup

- Installation
	- comes bundled with RStudio

# Differences with Rmd

- Make Urban COVID report

Things that are same (all general concepts)
- YAML
- Code chunks
- Markdown text
- Inline R code

Differences
- YAML
	- format not output etc
	- https://jthomasmock.github.io/quarto-in-two-hours/materials/04-static-documents.html#/quarto-and-rmarkdown
- Code chunks
	- [Setup code chunk is now in YAML](https://rstudio-conf-2022.github.io/rmd-to-quarto/materials/3-computation/slides/computation.html#/from-cell-option-to-yaml-1) 
		- [All options](https://quarto.org/docs/reference/cells/cells-knitr.html)
	- [Hash pipe](https://rstudio-conf-2022.github.io/rmd-to-quarto/materials/3-computation/slides/computation.html#/generalizing-the-code-chunk-2)
	- one-two vs one.two ([source](https://jthomasmock.github.io/quarto-in-two-hours/materials/03-computation-editors.html#/rmarkdown-vs-quarto))


New features
- [Multicolumn layouts](https://quarto.org/docs/authoring/article-layout.html)
- Easily publish to Quarto Pub

# How to make different things with Quarto

## Parameterized Reports

- https://quarto-dev.github.io/quarto-r/reference/quarto_render.html

## Presentations

- reveal.js slides
- Breaking content across slides
	- H1 or ---
- Incremental reveal
	- ::: {.incremental} or . . .
- Aligning content
	- [Columns](https://quarto.org/docs/presentations/revealjs/#multiple-columns)
- [Background images](https://quarto.org/docs/presentations/revealjs/#slide-backgrounds)
- [Themes](https://quarto.org/docs/presentations/revealjs/themes.html)


## Websites

- Use Quarto projects to create site
- Render
- _quarto.yml vs _site.yml
- Customize with themes or CSS/SCSS/SASS (https://quarto.org/docs/output-formats/html-themes.html)
- Wider layouts
	- https://quarto.org/docs/authoring/article-layout.html
	- https://quarto.org/docs/output-formats/page-layout.html

# Conclusion

- Should you use Quarto or R Markdown? Either is fine.
- The switch from multitool to Quarto/Rmd is bigger than switch from Rmd to Quarto.
- https://yihui.org/en/2022/04/quarto-r-markdown/