--- 
title: "R Without Statistics"
author: "David Keyes"
# date: "2022-10-06"
site: bookdown::bookdown_site
documentclass: book
url: https://book.rwithoutstatistics.com
cover-image: mock-cover.png
description: |
  Since R was invented in 1993, it has become a widely used programming language for statistical analysis. From academia to the tech world and beyond, R is used for a wide range of statistical analysis. R Without Statistics will show ways that R can be used beyond complex statistical analysis. Readers will learn about a range of uses for R, many of which they have likely never even considered.
biblio-style: apalike
---

# date: "2022-10-06"

Placeholder



<!--chapter:end:index.Rmd-->

# (PART\*) Introduction {-}

<!--chapter:end:part-introduction.Rmd-->


# Why R Without Statistics?

Placeholder


## How I Came to Use R {-}
## Code is Just a Written Record of Your Work {-}
## R Can Do Much More Than Just Statistics {-}
## How This Book Works {-}
## A Favor to Ask {-}

<!--chapter:end:introduction.Rmd-->

---
output: html_document
editor_options: 
  chunk_output_type: inline
---

# (PART\*) Illuminate {-}

<!--chapter:end:part-illuminate.Rmd-->


# Principles of Data Visualization {#data-viz-chapter}

Placeholder


## The Drought Visualization {-}
## The Grammar of Graphics {-}
## Working With ggplot2 {-}
### The First Layer: Mapping Data to Aesthetic Properties {-}
### The Second Layer: Choosing the geoms {-}
### The Third Layer: Altering Aesthetic Properties {-}
### The Fourth Layer: Setting a Theme {-}
## Recreating the Drought Visualization with ggplot {-}
## ggplot is Your Data Viz Secret Weapon {-}

<!--chapter:end:data-viz.Rmd-->


# Develop a Custom Theme to Keep Your Data Viz Consistent 

Placeholder


## Enter bbplot {-}
## Code is the Catalyst for Culture Change {-}

<!--chapter:end:custom-theme.Rmd-->

# R is a Full-Fledged Map-Making Tool 


<!--chapter:end:maps.Rmd-->

---
output: html_document
editor_options: 
  chunk_output_type: console
---
# Make High-Quality Tables

In his book *Fundamentals of Data Visualization*, Claus Wilke writes that "tables are an important tool for visualizing data." This statement might seem might odd. Tables are often seen as the opposite of data visualization: plots are (or should be) highly-designed tools of communication; tables are where we dump numbers for the few nerds who care to read them. But Wilke sees things differently. Tables should not be data dumps devoid of design. He writes: "because of their apparent simplicity, they may not always receive the attention they need." 

Tables should be treated as data visualization because *that is exactly what they are*. As the term data visualization has become codified, it has become a synonym for graphs. But think about what the phrase data visualization really means. Don't overthink it. It simply means to visualize data. And while bars, lines, and points in graphs are visualizations, so too are numbers in a table. When we make tables, we visualize our data. 

And since we're visualizing data, we should care about design. Need proof that good design matters when it comes to making tables? Look at tables made by reputable news organizations.

TODO: Add some kind of table here? But permissions ugh.

Data dumps these are not. News organizations, whose job is to communicate clearly and effectively, pay a lot of attention to table design. 

We saw in Chapter \@ref(data-viz-chapter) that a few simple but significant tweaks can drastically improve the quality of our graphs. In this chapter, we'll see that a little bit of work can go a long way toward improving our tables. 

The good news for you is that R is a great tool for making high-quality tables. If you are writing reports in RMarkdown (which you can learn about in \@ref(rmarkdown-chapter)), you can write code that will generate a table when you export your document. Working with the same tool to generate tables alongside your text and data visualization means you don't have to copy and paste your data, running the risk of human error. 

Generating tables in Microsoft Word, the tool that many use to make tables, has other potential pitfalls. Claus Wilke found that his version of Word had 105 built-in table styles. Of those, around 80 percent violated some key principles of table design. Wilke writes: 

> So if you pick a Microsoft Word table layout at random, you have an 80% chance of picking one that has issues. And if you pick the default, you will end up with a poorly formatted table every time.

In R, there are a number of packages to make a wide range of tables. And within these packages, there are a number of functions designed to make sure your tables follow important design principles. 

The rest of this chapter will examine what these design principles are and show how to apply them in your tables made in R. We'll begin by with a brief trip into the world of table design. After examining the principles that Claus Wilke and other experts recommend, we'll learn how to apply these principles. 

For this chapter, I spoke with Tom Mock of Posit (the company that makes RStudio), who has become something of an R table connoisseur. His 2020 blog post "10+ Guidelines for Better Tables in R" takes table design principles and shows how to implement them using the `gt` package. We'll walk through examples of Tom's code to show how small tweaks can make a big difference in improving your tables.

## Table Design Principles {-}

Advice on data visualization has become ubiquitous in the last few years. Books, articles, blog posts, and more talk about how to make your graphs communicate effectively. Table design advice is less common, but it is out there. In addition to Claus Wilke, others including Jon Schwabish and Stephen Few have written about table design. All three of these experts come to discussing tables after having written about making effective graphs. The principles they discuss, not surprisingly, will sound similar to data visualization advice. The principles of effective communication apply no matter the form in which data is ultimately presented. 

The principles below are adapted primarily from a conversation I had with Tom Mock, which focuses on his tables blog post. That blog post shows how to implement in R the ten table design principles that Jon Schwabish discusses in his article "Ten Guidelines for Better Tables." Schwabish cites Stephen Few's work on table design. As you can see, the world of table design is closely connected. Rather than trying to and show every single principle that Schwabish discusses and Mock implements in R, I've selected what I think are six of the most important. 

In this chapter, I use the `gt` package. This is one of the most popular table-making packages and, as we'll see below, it uses good design principles by default. The code below is a lightly adapted version of the code in Mock's blog post. 

### Principle One: Minimize Clutter {-}

As with data visualization, one of the most important principles of table design is to minimize clutter. One of the most important ways we can do this is by removing unnecessary elements. One of the most common unnecessary elements that clutter tables is gridlines. To show you how we can make more effective tables by removing gridlines, let's first load the packages we need. We're relying on the `tidyverse` package for general data manipulation functions, `gapminder` for the data we'll use, and `gt` to make the tables.


```r
library(tidyverse)
library(gapminder)
library(gt)
library(gtExtras)
```

As we saw in \@ref(data-viz-chapter), the `gapminder` package provides data on country-level demographic statistics. To make a data frame we'll use for our table, let's use just a few countries (the first four in alphabetical order: Afghanistan, Albania, Algeria, and Angola) and a few years (1952, 1972, and 1992). The `gapminder` data has many years but we only need a few to demonstrate table-making principles. 



I've created a data frame called `gdp`. We can see what it looks like.


```
#> # A tibble: 4 × 4
#>   Country     `1952` `1972` `1992`
#>   <chr>        <dbl>  <dbl>  <dbl>
#> 1 Afghanistan   779.   740.   649.
#> 2 Albania      1601.  3313.  2497.
#> 3 Algeria      2449.  4183.  5023.
#> 4 Angola       3521.  5473.  2628.
```

Now that we've created the data frame we can work with, it's time to talk about reducing clutter by getting rid of gridlines. Often, you see tables that look like this:


```{=html}
<div id="pemkgpnabg" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#pemkgpnabg .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#pemkgpnabg .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#pemkgpnabg .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#pemkgpnabg .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#pemkgpnabg .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pemkgpnabg .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#pemkgpnabg .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#pemkgpnabg .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#pemkgpnabg .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#pemkgpnabg .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#pemkgpnabg .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#pemkgpnabg .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#pemkgpnabg .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#pemkgpnabg .gt_from_md > :first-child {
  margin-top: 0;
}

#pemkgpnabg .gt_from_md > :last-child {
  margin-bottom: 0;
}

#pemkgpnabg .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#pemkgpnabg .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#pemkgpnabg .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#pemkgpnabg .gt_row_group_first td {
  border-top-width: 2px;
}

#pemkgpnabg .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pemkgpnabg .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#pemkgpnabg .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#pemkgpnabg .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pemkgpnabg .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pemkgpnabg .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#pemkgpnabg .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#pemkgpnabg .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pemkgpnabg .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#pemkgpnabg .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#pemkgpnabg .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#pemkgpnabg .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#pemkgpnabg .gt_left {
  text-align: left;
}

#pemkgpnabg .gt_center {
  text-align: center;
}

#pemkgpnabg .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#pemkgpnabg .gt_font_normal {
  font-weight: normal;
}

#pemkgpnabg .gt_font_bold {
  font-weight: bold;
}

#pemkgpnabg .gt_font_italic {
  font-style: italic;
}

#pemkgpnabg .gt_super {
  font-size: 65%;
}

#pemkgpnabg .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#pemkgpnabg .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#pemkgpnabg .gt_indent_1 {
  text-indent: 5px;
}

#pemkgpnabg .gt_indent_2 {
  text-indent: 10px;
}

#pemkgpnabg .gt_indent_3 {
  text-indent: 15px;
}

#pemkgpnabg .gt_indent_4 {
  text-indent: 20px;
}

#pemkgpnabg .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;" scope="col">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;" scope="col">1952</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;" scope="col">1972</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;" scope="col">1992</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">Afghanistan</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">779.4453</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">739.9811</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">649.3414</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">Albania</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">1601.0561</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">3313.4222</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">2497.4379</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">Algeria</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">2449.0082</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">4182.6638</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">5023.2166</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">Angola</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">3520.6103</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">5473.2880</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">2627.8457</td></tr>
  </tbody>
  
  
</table>
</div>
```

Having gridlines around every single cell in our table is unnecessary and creates visual clutter that distracts from the goal of communicating clearly. A table with minimal or even no gridlines is a much more effective communication tool. 


```{=html}
<div id="ejjlkuypue" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#ejjlkuypue .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#ejjlkuypue .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#ejjlkuypue .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#ejjlkuypue .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#ejjlkuypue .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ejjlkuypue .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#ejjlkuypue .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#ejjlkuypue .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#ejjlkuypue .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ejjlkuypue .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ejjlkuypue .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#ejjlkuypue .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#ejjlkuypue .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#ejjlkuypue .gt_from_md > :first-child {
  margin-top: 0;
}

#ejjlkuypue .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ejjlkuypue .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#ejjlkuypue .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#ejjlkuypue .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#ejjlkuypue .gt_row_group_first td {
  border-top-width: 2px;
}

#ejjlkuypue .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ejjlkuypue .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ejjlkuypue .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ejjlkuypue .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ejjlkuypue .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ejjlkuypue .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ejjlkuypue .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ejjlkuypue .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ejjlkuypue .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#ejjlkuypue .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ejjlkuypue .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#ejjlkuypue .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ejjlkuypue .gt_left {
  text-align: left;
}

#ejjlkuypue .gt_center {
  text-align: center;
}

#ejjlkuypue .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ejjlkuypue .gt_font_normal {
  font-weight: normal;
}

#ejjlkuypue .gt_font_bold {
  font-weight: bold;
}

#ejjlkuypue .gt_font_italic {
  font-style: italic;
}

#ejjlkuypue .gt_super {
  font-size: 65%;
}

#ejjlkuypue .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#ejjlkuypue .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ejjlkuypue .gt_indent_1 {
  text-indent: 5px;
}

#ejjlkuypue .gt_indent_2 {
  text-indent: 10px;
}

#ejjlkuypue .gt_indent_3 {
  text-indent: 15px;
}

#ejjlkuypue .gt_indent_4 {
  text-indent: 20px;
}

#ejjlkuypue .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">1952</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">1972</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">1992</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left">Afghanistan</td>
<td class="gt_row gt_right">779.4453</td>
<td class="gt_row gt_right">739.9811</td>
<td class="gt_row gt_right">649.3414</td></tr>
    <tr><td class="gt_row gt_left">Albania</td>
<td class="gt_row gt_right">1601.0561</td>
<td class="gt_row gt_right">3313.4222</td>
<td class="gt_row gt_right">2497.4379</td></tr>
    <tr><td class="gt_row gt_left">Algeria</td>
<td class="gt_row gt_right">2449.0082</td>
<td class="gt_row gt_right">4182.6638</td>
<td class="gt_row gt_right">5023.2166</td></tr>
    <tr><td class="gt_row gt_left">Angola</td>
<td class="gt_row gt_right">3520.6103</td>
<td class="gt_row gt_right">5473.2880</td>
<td class="gt_row gt_right">2627.8457</td></tr>
  </tbody>
  
  
</table>
</div>
```

You know how I mentioned before that `gt` uses good table design principles by default? This is a great example of it. The second table, with minimal gridlines, requires just two lines. We pipe our `gdp` data into the `gt()` function, which creates a table. 


```r
gdp %>% 
  gt()
```

```{=html}
<div id="uoegnfnadm" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#uoegnfnadm .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#uoegnfnadm .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#uoegnfnadm .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#uoegnfnadm .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#uoegnfnadm .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#uoegnfnadm .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#uoegnfnadm .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#uoegnfnadm .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#uoegnfnadm .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#uoegnfnadm .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#uoegnfnadm .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#uoegnfnadm .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#uoegnfnadm .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#uoegnfnadm .gt_from_md > :first-child {
  margin-top: 0;
}

#uoegnfnadm .gt_from_md > :last-child {
  margin-bottom: 0;
}

#uoegnfnadm .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#uoegnfnadm .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#uoegnfnadm .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#uoegnfnadm .gt_row_group_first td {
  border-top-width: 2px;
}

#uoegnfnadm .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#uoegnfnadm .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#uoegnfnadm .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#uoegnfnadm .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#uoegnfnadm .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#uoegnfnadm .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#uoegnfnadm .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#uoegnfnadm .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#uoegnfnadm .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#uoegnfnadm .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#uoegnfnadm .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#uoegnfnadm .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#uoegnfnadm .gt_left {
  text-align: left;
}

#uoegnfnadm .gt_center {
  text-align: center;
}

#uoegnfnadm .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#uoegnfnadm .gt_font_normal {
  font-weight: normal;
}

#uoegnfnadm .gt_font_bold {
  font-weight: bold;
}

#uoegnfnadm .gt_font_italic {
  font-style: italic;
}

#uoegnfnadm .gt_super {
  font-size: 65%;
}

#uoegnfnadm .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#uoegnfnadm .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#uoegnfnadm .gt_indent_1 {
  text-indent: 5px;
}

#uoegnfnadm .gt_indent_2 {
  text-indent: 10px;
}

#uoegnfnadm .gt_indent_3 {
  text-indent: 15px;
}

#uoegnfnadm .gt_indent_4 {
  text-indent: 20px;
}

#uoegnfnadm .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">1952</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">1972</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">1992</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left">Afghanistan</td>
<td class="gt_row gt_right">779.4453</td>
<td class="gt_row gt_right">739.9811</td>
<td class="gt_row gt_right">649.3414</td></tr>
    <tr><td class="gt_row gt_left">Albania</td>
<td class="gt_row gt_right">1601.0561</td>
<td class="gt_row gt_right">3313.4222</td>
<td class="gt_row gt_right">2497.4379</td></tr>
    <tr><td class="gt_row gt_left">Algeria</td>
<td class="gt_row gt_right">2449.0082</td>
<td class="gt_row gt_right">4182.6638</td>
<td class="gt_row gt_right">5023.2166</td></tr>
    <tr><td class="gt_row gt_left">Angola</td>
<td class="gt_row gt_right">3520.6103</td>
<td class="gt_row gt_right">5473.2880</td>
<td class="gt_row gt_right">2627.8457</td></tr>
  </tbody>
  
  
</table>
</div>
```

To make the example with gridlines everywhere, we would have to add additional code. The code that follows `gt()` here adds gridlines. 



And we end up with a table that looks like this.


```{=html}
<div id="yfsfxxroxz" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#yfsfxxroxz .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#yfsfxxroxz .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#yfsfxxroxz .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#yfsfxxroxz .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#yfsfxxroxz .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yfsfxxroxz .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#yfsfxxroxz .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#yfsfxxroxz .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#yfsfxxroxz .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#yfsfxxroxz .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#yfsfxxroxz .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#yfsfxxroxz .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#yfsfxxroxz .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#yfsfxxroxz .gt_from_md > :first-child {
  margin-top: 0;
}

#yfsfxxroxz .gt_from_md > :last-child {
  margin-bottom: 0;
}

#yfsfxxroxz .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#yfsfxxroxz .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#yfsfxxroxz .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#yfsfxxroxz .gt_row_group_first td {
  border-top-width: 2px;
}

#yfsfxxroxz .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#yfsfxxroxz .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#yfsfxxroxz .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#yfsfxxroxz .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yfsfxxroxz .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#yfsfxxroxz .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#yfsfxxroxz .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#yfsfxxroxz .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yfsfxxroxz .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#yfsfxxroxz .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#yfsfxxroxz .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#yfsfxxroxz .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#yfsfxxroxz .gt_left {
  text-align: left;
}

#yfsfxxroxz .gt_center {
  text-align: center;
}

#yfsfxxroxz .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#yfsfxxroxz .gt_font_normal {
  font-weight: normal;
}

#yfsfxxroxz .gt_font_bold {
  font-weight: bold;
}

#yfsfxxroxz .gt_font_italic {
  font-style: italic;
}

#yfsfxxroxz .gt_super {
  font-size: 65%;
}

#yfsfxxroxz .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#yfsfxxroxz .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#yfsfxxroxz .gt_indent_1 {
  text-indent: 5px;
}

#yfsfxxroxz .gt_indent_2 {
  text-indent: 10px;
}

#yfsfxxroxz .gt_indent_3 {
  text-indent: 15px;
}

#yfsfxxroxz .gt_indent_4 {
  text-indent: 20px;
}

#yfsfxxroxz .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;" scope="col">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;" scope="col">1952</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;" scope="col">1972</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;" scope="col">1992</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">Afghanistan</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">779.4453</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">739.9811</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">649.3414</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">Albania</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">1601.0561</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">3313.4222</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">2497.4379</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">Algeria</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">2449.0082</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">4182.6638</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">5023.2166</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">Angola</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">3520.6103</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">5473.2880</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: grey; border-right-width: 1px; border-right-style: solid; border-right-color: grey; border-top-width: 1px; border-top-style: solid; border-top-color: grey; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: grey;">2627.8457</td></tr>
  </tbody>
  
  
</table>
</div>
```

Since I don't recommend doing this, I won't walk through the code. The important thing to remember is that you get good defaults using `gt()`. Take advantage of them!

If we wanted to remove additional gridlines, we could use the following code. The `tab_style()` function uses a two-step approach:

1. Identify the style we want to modify (in this case the borders).
1. Tell the function where to apply these styles.

Here, we tell `tab_style()` that we want to modify the borders using the `cell_borders()` function, making our borders transparent. Then, we say that we want this to apply to the `cells_body()` location (other options include `cells_column_labels()` for the row with country, 1952, 1972, and 1992). 


```r
gdp %>% 
  gt() %>% 
  tab_style(
    style = cell_borders(color = "transparent"),
    locations = cells_body()
  )
```

```{=html}
<div id="tgamteiqmd" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#tgamteiqmd .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#tgamteiqmd .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#tgamteiqmd .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#tgamteiqmd .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#tgamteiqmd .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tgamteiqmd .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#tgamteiqmd .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#tgamteiqmd .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#tgamteiqmd .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#tgamteiqmd .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#tgamteiqmd .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#tgamteiqmd .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#tgamteiqmd .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#tgamteiqmd .gt_from_md > :first-child {
  margin-top: 0;
}

#tgamteiqmd .gt_from_md > :last-child {
  margin-bottom: 0;
}

#tgamteiqmd .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#tgamteiqmd .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#tgamteiqmd .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#tgamteiqmd .gt_row_group_first td {
  border-top-width: 2px;
}

#tgamteiqmd .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#tgamteiqmd .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#tgamteiqmd .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#tgamteiqmd .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tgamteiqmd .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#tgamteiqmd .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#tgamteiqmd .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#tgamteiqmd .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tgamteiqmd .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#tgamteiqmd .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#tgamteiqmd .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#tgamteiqmd .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#tgamteiqmd .gt_left {
  text-align: left;
}

#tgamteiqmd .gt_center {
  text-align: center;
}

#tgamteiqmd .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#tgamteiqmd .gt_font_normal {
  font-weight: normal;
}

#tgamteiqmd .gt_font_bold {
  font-weight: bold;
}

#tgamteiqmd .gt_font_italic {
  font-style: italic;
}

#tgamteiqmd .gt_super {
  font-size: 65%;
}

#tgamteiqmd .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#tgamteiqmd .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#tgamteiqmd .gt_indent_1 {
  text-indent: 5px;
}

#tgamteiqmd .gt_indent_2 {
  text-indent: 10px;
}

#tgamteiqmd .gt_indent_3 {
  text-indent: 15px;
}

#tgamteiqmd .gt_indent_4 {
  text-indent: 20px;
}

#tgamteiqmd .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">1952</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">1972</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">1992</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Afghanistan</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">779.4453</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">739.9811</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">649.3414</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Albania</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">1601.0561</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">3313.4222</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2497.4379</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Algeria</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2449.0082</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">4182.6638</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">5023.2166</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Angola</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">3520.6103</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">5473.2880</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2627.8457</td></tr>
  </tbody>
  
  
</table>
</div>
```

Doing this gives us a table with no gridlines at all in the body.


```{=html}
<div id="pxgttvstev" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#pxgttvstev .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#pxgttvstev .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#pxgttvstev .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#pxgttvstev .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#pxgttvstev .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pxgttvstev .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#pxgttvstev .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#pxgttvstev .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#pxgttvstev .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#pxgttvstev .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#pxgttvstev .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#pxgttvstev .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#pxgttvstev .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#pxgttvstev .gt_from_md > :first-child {
  margin-top: 0;
}

#pxgttvstev .gt_from_md > :last-child {
  margin-bottom: 0;
}

#pxgttvstev .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#pxgttvstev .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#pxgttvstev .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#pxgttvstev .gt_row_group_first td {
  border-top-width: 2px;
}

#pxgttvstev .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pxgttvstev .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#pxgttvstev .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#pxgttvstev .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pxgttvstev .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#pxgttvstev .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#pxgttvstev .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#pxgttvstev .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#pxgttvstev .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#pxgttvstev .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#pxgttvstev .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#pxgttvstev .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#pxgttvstev .gt_left {
  text-align: left;
}

#pxgttvstev .gt_center {
  text-align: center;
}

#pxgttvstev .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#pxgttvstev .gt_font_normal {
  font-weight: normal;
}

#pxgttvstev .gt_font_bold {
  font-weight: bold;
}

#pxgttvstev .gt_font_italic {
  font-style: italic;
}

#pxgttvstev .gt_super {
  font-size: 65%;
}

#pxgttvstev .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#pxgttvstev .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#pxgttvstev .gt_indent_1 {
  text-indent: 5px;
}

#pxgttvstev .gt_indent_2 {
  text-indent: 10px;
}

#pxgttvstev .gt_indent_3 {
  text-indent: 15px;
}

#pxgttvstev .gt_indent_4 {
  text-indent: 20px;
}

#pxgttvstev .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">1952</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">1972</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">1992</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Afghanistan</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">779.4453</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">739.9811</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">649.3414</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Albania</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">1601.0561</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">3313.4222</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2497.4379</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Algeria</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2449.0082</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">4182.6638</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">5023.2166</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Angola</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">3520.6103</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">5473.2880</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2627.8457</td></tr>
  </tbody>
  
  
</table>
</div>
```

### Principle Two: Differentiate the Header from the Body {-}

While reducing clutter is an important goal, going too far can have negative consequences. A table with no gridlines at all can make it hard to differentiate between the header row and the table body. 


```{=html}
<div id="qkjedojvty" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#qkjedojvty .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: none;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: none;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#qkjedojvty .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#qkjedojvty .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#qkjedojvty .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#qkjedojvty .gt_bottom_border {
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qkjedojvty .gt_col_headings {
  border-top-style: none;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#qkjedojvty .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#qkjedojvty .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#qkjedojvty .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#qkjedojvty .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#qkjedojvty .gt_column_spanner {
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#qkjedojvty .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: none;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#qkjedojvty .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: none;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#qkjedojvty .gt_from_md > :first-child {
  margin-top: 0;
}

#qkjedojvty .gt_from_md > :last-child {
  margin-bottom: 0;
}

#qkjedojvty .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: none;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#qkjedojvty .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#qkjedojvty .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#qkjedojvty .gt_row_group_first td {
  border-top-width: 2px;
}

#qkjedojvty .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qkjedojvty .gt_first_summary_row {
  border-top-style: none;
  border-top-color: #D3D3D3;
}

#qkjedojvty .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#qkjedojvty .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qkjedojvty .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qkjedojvty .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: none;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#qkjedojvty .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#qkjedojvty .gt_table_body {
  border-top-style: none;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qkjedojvty .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#qkjedojvty .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#qkjedojvty .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#qkjedojvty .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#qkjedojvty .gt_left {
  text-align: left;
}

#qkjedojvty .gt_center {
  text-align: center;
}

#qkjedojvty .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#qkjedojvty .gt_font_normal {
  font-weight: normal;
}

#qkjedojvty .gt_font_bold {
  font-weight: bold;
}

#qkjedojvty .gt_font_italic {
  font-style: italic;
}

#qkjedojvty .gt_super {
  font-size: 65%;
}

#qkjedojvty .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#qkjedojvty .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#qkjedojvty .gt_indent_1 {
  text-indent: 5px;
}

#qkjedojvty .gt_indent_2 {
  text-indent: 10px;
}

#qkjedojvty .gt_indent_3 {
  text-indent: 15px;
}

#qkjedojvty .gt_indent_4 {
  text-indent: 20px;
}

#qkjedojvty .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">1952</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">1972</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">1992</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left">Afghanistan</td>
<td class="gt_row gt_right">779.4453</td>
<td class="gt_row gt_right">739.9811</td>
<td class="gt_row gt_right">649.3414</td></tr>
    <tr><td class="gt_row gt_left">Albania</td>
<td class="gt_row gt_right">1601.0561</td>
<td class="gt_row gt_right">3313.4222</td>
<td class="gt_row gt_right">2497.4379</td></tr>
    <tr><td class="gt_row gt_left">Algeria</td>
<td class="gt_row gt_right">2449.0082</td>
<td class="gt_row gt_right">4182.6638</td>
<td class="gt_row gt_right">5023.2166</td></tr>
    <tr><td class="gt_row gt_left">Angola</td>
<td class="gt_row gt_right">3520.6103</td>
<td class="gt_row gt_right">5473.2880</td>
<td class="gt_row gt_right">2627.8457</td></tr>
  </tbody>
  
  
</table>
</div>
```

We saw how to use appropriate gridlines above. We can add bolding to our header row to make it stand out even more. Again, we do this with the `tab_style()` function two-step, first saying we want to alter the text (using the `cell_text()` function) by setting the weight to bold and then saying we want this to happen only to the header row (using the `cells_column_labels()` function).


```{=html}
<div id="cpqqiotbgi" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#cpqqiotbgi .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#cpqqiotbgi .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#cpqqiotbgi .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#cpqqiotbgi .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#cpqqiotbgi .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cpqqiotbgi .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#cpqqiotbgi .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#cpqqiotbgi .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#cpqqiotbgi .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#cpqqiotbgi .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#cpqqiotbgi .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#cpqqiotbgi .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#cpqqiotbgi .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#cpqqiotbgi .gt_from_md > :first-child {
  margin-top: 0;
}

#cpqqiotbgi .gt_from_md > :last-child {
  margin-bottom: 0;
}

#cpqqiotbgi .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#cpqqiotbgi .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#cpqqiotbgi .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#cpqqiotbgi .gt_row_group_first td {
  border-top-width: 2px;
}

#cpqqiotbgi .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cpqqiotbgi .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#cpqqiotbgi .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#cpqqiotbgi .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cpqqiotbgi .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#cpqqiotbgi .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#cpqqiotbgi .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#cpqqiotbgi .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#cpqqiotbgi .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#cpqqiotbgi .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#cpqqiotbgi .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#cpqqiotbgi .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#cpqqiotbgi .gt_left {
  text-align: left;
}

#cpqqiotbgi .gt_center {
  text-align: center;
}

#cpqqiotbgi .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#cpqqiotbgi .gt_font_normal {
  font-weight: normal;
}

#cpqqiotbgi .gt_font_bold {
  font-weight: bold;
}

#cpqqiotbgi .gt_font_italic {
  font-style: italic;
}

#cpqqiotbgi .gt_super {
  font-size: 65%;
}

#cpqqiotbgi .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#cpqqiotbgi .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#cpqqiotbgi .gt_indent_1 {
  text-indent: 5px;
}

#cpqqiotbgi .gt_indent_2 {
  text-indent: 10px;
}

#cpqqiotbgi .gt_indent_3 {
  text-indent: 15px;
}

#cpqqiotbgi .gt_indent_4 {
  text-indent: 20px;
}

#cpqqiotbgi .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1952</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1972</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1992</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Afghanistan</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">779.4453</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">739.9811</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">649.3414</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Albania</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">1601.0561</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">3313.4222</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2497.4379</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Algeria</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2449.0082</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">4182.6638</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">5023.2166</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Angola</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">3520.6103</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">5473.2880</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2627.8457</td></tr>
  </tbody>
  
  
</table>
</div>
```

### Principle Three: Align Appropriately {-}

A third principle of high-quality table design is appropriate alignment. Specifically, numbers in tables should be right-aligned. Tom Mock explains why:

> Left-alignment or center-alignment of numbers impairs the ability to clearly compare numbers and decimal places. Right-alignment lets you align decimal places and numbers for easy parsing.

We can see this in action. In the table below, we've left aligned 1952, center aligned 1972, and right aligned 1992. You can see how much easier it is to compare the values in 1992 than in the other two columns. In both 1952 and 1972, it is much more difficult to compare the numeric values because the numbers in the same columns (the tens place, for example) are not in the same vertical position. In 1992, however, the number in the tens place in Afghanistan (4) aligns with the number in the tens place in Albania (9) and all other countries. This vertical alignment makes it easier to scan the table. 


```{=html}
<div id="omxpbatmdy" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#omxpbatmdy .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#omxpbatmdy .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#omxpbatmdy .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#omxpbatmdy .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#omxpbatmdy .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#omxpbatmdy .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#omxpbatmdy .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#omxpbatmdy .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#omxpbatmdy .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#omxpbatmdy .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#omxpbatmdy .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#omxpbatmdy .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#omxpbatmdy .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#omxpbatmdy .gt_from_md > :first-child {
  margin-top: 0;
}

#omxpbatmdy .gt_from_md > :last-child {
  margin-bottom: 0;
}

#omxpbatmdy .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#omxpbatmdy .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#omxpbatmdy .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#omxpbatmdy .gt_row_group_first td {
  border-top-width: 2px;
}

#omxpbatmdy .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#omxpbatmdy .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#omxpbatmdy .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#omxpbatmdy .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#omxpbatmdy .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#omxpbatmdy .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#omxpbatmdy .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#omxpbatmdy .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#omxpbatmdy .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#omxpbatmdy .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#omxpbatmdy .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#omxpbatmdy .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#omxpbatmdy .gt_left {
  text-align: left;
}

#omxpbatmdy .gt_center {
  text-align: center;
}

#omxpbatmdy .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#omxpbatmdy .gt_font_normal {
  font-weight: normal;
}

#omxpbatmdy .gt_font_bold {
  font-weight: bold;
}

#omxpbatmdy .gt_font_italic {
  font-style: italic;
}

#omxpbatmdy .gt_super {
  font-size: 65%;
}

#omxpbatmdy .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#omxpbatmdy .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#omxpbatmdy .gt_indent_1 {
  text-indent: 5px;
}

#omxpbatmdy .gt_indent_2 {
  text-indent: 10px;
}

#omxpbatmdy .gt_indent_3 {
  text-indent: 15px;
}

#omxpbatmdy .gt_indent_4 {
  text-indent: 20px;
}

#omxpbatmdy .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1952</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1972</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1992</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Afghanistan</td>
<td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">779.4453</td>
<td class="gt_row gt_center" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">739.9811</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">649.3414</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Albania</td>
<td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">1601.0561</td>
<td class="gt_row gt_center" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">3313.4222</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2497.4379</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Algeria</td>
<td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2449.0082</td>
<td class="gt_row gt_center" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">4182.6638</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">5023.2166</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Angola</td>
<td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">3520.6103</td>
<td class="gt_row gt_center" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">5473.2880</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2627.8457</td></tr>
  </tbody>
  
  
</table>
</div>
```

As with other tables, we've actually had to override the defaults to get the `gt` package to misalign the columns. By default, `gt` will right align numeric values. So, just don't change anything and you'll be golden!


```{=html}
<div id="rnfelwvjdk" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#rnfelwvjdk .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#rnfelwvjdk .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#rnfelwvjdk .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#rnfelwvjdk .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#rnfelwvjdk .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rnfelwvjdk .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#rnfelwvjdk .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#rnfelwvjdk .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#rnfelwvjdk .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#rnfelwvjdk .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#rnfelwvjdk .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#rnfelwvjdk .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#rnfelwvjdk .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#rnfelwvjdk .gt_from_md > :first-child {
  margin-top: 0;
}

#rnfelwvjdk .gt_from_md > :last-child {
  margin-bottom: 0;
}

#rnfelwvjdk .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#rnfelwvjdk .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#rnfelwvjdk .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#rnfelwvjdk .gt_row_group_first td {
  border-top-width: 2px;
}

#rnfelwvjdk .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rnfelwvjdk .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#rnfelwvjdk .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#rnfelwvjdk .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rnfelwvjdk .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rnfelwvjdk .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#rnfelwvjdk .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#rnfelwvjdk .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rnfelwvjdk .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#rnfelwvjdk .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rnfelwvjdk .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#rnfelwvjdk .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rnfelwvjdk .gt_left {
  text-align: left;
}

#rnfelwvjdk .gt_center {
  text-align: center;
}

#rnfelwvjdk .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#rnfelwvjdk .gt_font_normal {
  font-weight: normal;
}

#rnfelwvjdk .gt_font_bold {
  font-weight: bold;
}

#rnfelwvjdk .gt_font_italic {
  font-style: italic;
}

#rnfelwvjdk .gt_super {
  font-size: 65%;
}

#rnfelwvjdk .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#rnfelwvjdk .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#rnfelwvjdk .gt_indent_1 {
  text-indent: 5px;
}

#rnfelwvjdk .gt_indent_2 {
  text-indent: 10px;
}

#rnfelwvjdk .gt_indent_3 {
  text-indent: 15px;
}

#rnfelwvjdk .gt_indent_4 {
  text-indent: 20px;
}

#rnfelwvjdk .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1952</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1972</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1992</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Afghanistan</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">779.4453</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">739.9811</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">649.3414</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Albania</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">1601.0561</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">3313.4222</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2497.4379</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Algeria</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2449.0082</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">4182.6638</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">5023.2166</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Angola</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">3520.6103</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">5473.2880</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2627.8457</td></tr>
  </tbody>
  
  
</table>
</div>
```

Right alignment is best practice for numeric columns, but for text columns, we want to use left alignment. As Jon Scwabish points out, it is much easier to read country names when they are left aligned. This is even easier to see if we add a country with a long name to our table. I've added Bosnia and Herzegovina to our table below and center aligned the country column. In this table, it is hard to scan the country names and that center-aligned column just looks a bit weird.





```{=html}
<div id="ultkrfyqdb" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#ultkrfyqdb .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#ultkrfyqdb .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#ultkrfyqdb .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#ultkrfyqdb .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#ultkrfyqdb .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ultkrfyqdb .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#ultkrfyqdb .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#ultkrfyqdb .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#ultkrfyqdb .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ultkrfyqdb .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ultkrfyqdb .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#ultkrfyqdb .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#ultkrfyqdb .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#ultkrfyqdb .gt_from_md > :first-child {
  margin-top: 0;
}

#ultkrfyqdb .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ultkrfyqdb .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#ultkrfyqdb .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#ultkrfyqdb .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#ultkrfyqdb .gt_row_group_first td {
  border-top-width: 2px;
}

#ultkrfyqdb .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ultkrfyqdb .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ultkrfyqdb .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ultkrfyqdb .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ultkrfyqdb .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ultkrfyqdb .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ultkrfyqdb .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ultkrfyqdb .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ultkrfyqdb .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#ultkrfyqdb .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ultkrfyqdb .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#ultkrfyqdb .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ultkrfyqdb .gt_left {
  text-align: left;
}

#ultkrfyqdb .gt_center {
  text-align: center;
}

#ultkrfyqdb .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ultkrfyqdb .gt_font_normal {
  font-weight: normal;
}

#ultkrfyqdb .gt_font_bold {
  font-weight: bold;
}

#ultkrfyqdb .gt_font_italic {
  font-style: italic;
}

#ultkrfyqdb .gt_super {
  font-size: 65%;
}

#ultkrfyqdb .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#ultkrfyqdb .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ultkrfyqdb .gt_indent_1 {
  text-indent: 5px;
}

#ultkrfyqdb .gt_indent_2 {
  text-indent: 10px;
}

#ultkrfyqdb .gt_indent_3 {
  text-indent: 15px;
}

#ultkrfyqdb .gt_indent_4 {
  text-indent: 20px;
}

#ultkrfyqdb .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1952</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1972</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1992</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_center" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Afghanistan</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">779.4453</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">739.9811</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">649.3414</td></tr>
    <tr><td class="gt_row gt_center" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Albania</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">1601.0561</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">3313.4222</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2497.4379</td></tr>
    <tr><td class="gt_row gt_center" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Algeria</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2449.0082</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">4182.6638</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">5023.2166</td></tr>
    <tr><td class="gt_row gt_center" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Angola</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">3520.6103</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">5473.2880</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2627.8457</td></tr>
    <tr><td class="gt_row gt_center" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Bosnia and Herzegovina</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">973.5332</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2860.1698</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2546.7814</td></tr>
  </tbody>
  
  
</table>
</div>
```


This is another example where we've had to change the `gt` defaults to mess things up. The `gt` package has good default alignment practices for other column types as well. In addition to right aligning numeric columns by default, it will also left align character columns. So, if we don't touch anything, `gt` will give me the alignment I'm looking for.


```{=html}
<div id="zzdxchjgab" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#zzdxchjgab .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#zzdxchjgab .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#zzdxchjgab .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#zzdxchjgab .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#zzdxchjgab .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zzdxchjgab .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#zzdxchjgab .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#zzdxchjgab .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#zzdxchjgab .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#zzdxchjgab .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#zzdxchjgab .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#zzdxchjgab .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#zzdxchjgab .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#zzdxchjgab .gt_from_md > :first-child {
  margin-top: 0;
}

#zzdxchjgab .gt_from_md > :last-child {
  margin-bottom: 0;
}

#zzdxchjgab .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#zzdxchjgab .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#zzdxchjgab .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#zzdxchjgab .gt_row_group_first td {
  border-top-width: 2px;
}

#zzdxchjgab .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zzdxchjgab .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#zzdxchjgab .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#zzdxchjgab .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zzdxchjgab .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#zzdxchjgab .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#zzdxchjgab .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#zzdxchjgab .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#zzdxchjgab .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#zzdxchjgab .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#zzdxchjgab .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#zzdxchjgab .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#zzdxchjgab .gt_left {
  text-align: left;
}

#zzdxchjgab .gt_center {
  text-align: center;
}

#zzdxchjgab .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#zzdxchjgab .gt_font_normal {
  font-weight: normal;
}

#zzdxchjgab .gt_font_bold {
  font-weight: bold;
}

#zzdxchjgab .gt_font_italic {
  font-style: italic;
}

#zzdxchjgab .gt_super {
  font-size: 65%;
}

#zzdxchjgab .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#zzdxchjgab .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#zzdxchjgab .gt_indent_1 {
  text-indent: 5px;
}

#zzdxchjgab .gt_indent_2 {
  text-indent: 10px;
}

#zzdxchjgab .gt_indent_3 {
  text-indent: 15px;
}

#zzdxchjgab .gt_indent_4 {
  text-indent: 20px;
}

#zzdxchjgab .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1952</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1972</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1992</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Afghanistan</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">779.4453</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">739.9811</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">649.3414</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Albania</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">1601.0561</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">3313.4222</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2497.4379</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Algeria</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2449.0082</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">4182.6638</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">5023.2166</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Angola</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">3520.6103</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">5473.2880</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2627.8457</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Bosnia and Herzegovina</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">973.5332</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2860.1698</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2546.7814</td></tr>
  </tbody>
  
  
</table>
</div>
```

If you ever do want to override the default alignments, you can use the `cols_align()` function. Within this function, we use the `columns` argument to tell `gt` which columns to align and the `align` argument to select our alignment. That table above with the country names center aligned? Here's how I made it.


```{=html}
<div id="poynzpkqor" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#poynzpkqor .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#poynzpkqor .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#poynzpkqor .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#poynzpkqor .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#poynzpkqor .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#poynzpkqor .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#poynzpkqor .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#poynzpkqor .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#poynzpkqor .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#poynzpkqor .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#poynzpkqor .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#poynzpkqor .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#poynzpkqor .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#poynzpkqor .gt_from_md > :first-child {
  margin-top: 0;
}

#poynzpkqor .gt_from_md > :last-child {
  margin-bottom: 0;
}

#poynzpkqor .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#poynzpkqor .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#poynzpkqor .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#poynzpkqor .gt_row_group_first td {
  border-top-width: 2px;
}

#poynzpkqor .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#poynzpkqor .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#poynzpkqor .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#poynzpkqor .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#poynzpkqor .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#poynzpkqor .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#poynzpkqor .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#poynzpkqor .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#poynzpkqor .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#poynzpkqor .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#poynzpkqor .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#poynzpkqor .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#poynzpkqor .gt_left {
  text-align: left;
}

#poynzpkqor .gt_center {
  text-align: center;
}

#poynzpkqor .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#poynzpkqor .gt_font_normal {
  font-weight: normal;
}

#poynzpkqor .gt_font_bold {
  font-weight: bold;
}

#poynzpkqor .gt_font_italic {
  font-style: italic;
}

#poynzpkqor .gt_super {
  font-size: 65%;
}

#poynzpkqor .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#poynzpkqor .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#poynzpkqor .gt_indent_1 {
  text-indent: 5px;
}

#poynzpkqor .gt_indent_2 {
  text-indent: 10px;
}

#poynzpkqor .gt_indent_3 {
  text-indent: 15px;
}

#poynzpkqor .gt_indent_4 {
  text-indent: 20px;
}

#poynzpkqor .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1952</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1972</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1992</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_center" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Afghanistan</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">779.4453</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">739.9811</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">649.3414</td></tr>
    <tr><td class="gt_row gt_center" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Albania</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">1601.0561</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">3313.4222</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2497.4379</td></tr>
    <tr><td class="gt_row gt_center" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Algeria</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2449.0082</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">4182.6638</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">5023.2166</td></tr>
    <tr><td class="gt_row gt_center" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Angola</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">3520.6103</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">5473.2880</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2627.8457</td></tr>
    <tr><td class="gt_row gt_center" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Bosnia and Herzegovina</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">973.5332</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2860.1698</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">2546.7814</td></tr>
  </tbody>
  
  
</table>
</div>
```

### Principle Four: Use the Right Level of Precision {-}

In all of the tables we've made so far, we've used the data exactly as it came to us. In all of the numeric columns, we have data to four decimal places. This is almost certainly too many. Having more decimal places than necessary makes our table harder to read. There is always a balance between what Jon Schwabish describes as "necessary precision and a clean, spare table." I've also heard it described that, if adding additional decimal places would change some action, keep them; otherwise, take them. out My general experience is that people tend to leave too many decimal places in, assuming that accuracy to a very high degree is more important than it is (and, in the process, they reduce the legibility of their tables).

Looking at our GDP table, we can use the `fmt_currency()` function to format our numeric values. The `gt` package has a whole series of functions for formatting values in tables. All of these functions start with `fmt_`. In the code below, we set `fmt_currency()` to be applied to the 1952, 1972, and 1992 columns. I then use `decimals` argument to tell `fmt_currency()` to format the values with zero decimal places (the difference between a GDP of \$799.4453 and \$779 is unlikely to lead to different decisions so I'm comfortable with sacrificing precision for legibility). What we end up with is values formatted as dollars, with a thousands-place comma automatically added by `fmt_currency()` to make the values even easier to read. 


```{=html}
<div id="htqnnljqeh" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#htqnnljqeh .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#htqnnljqeh .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#htqnnljqeh .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#htqnnljqeh .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#htqnnljqeh .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#htqnnljqeh .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#htqnnljqeh .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#htqnnljqeh .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#htqnnljqeh .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#htqnnljqeh .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#htqnnljqeh .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#htqnnljqeh .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#htqnnljqeh .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#htqnnljqeh .gt_from_md > :first-child {
  margin-top: 0;
}

#htqnnljqeh .gt_from_md > :last-child {
  margin-bottom: 0;
}

#htqnnljqeh .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#htqnnljqeh .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#htqnnljqeh .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#htqnnljqeh .gt_row_group_first td {
  border-top-width: 2px;
}

#htqnnljqeh .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#htqnnljqeh .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#htqnnljqeh .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#htqnnljqeh .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#htqnnljqeh .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#htqnnljqeh .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#htqnnljqeh .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#htqnnljqeh .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#htqnnljqeh .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#htqnnljqeh .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#htqnnljqeh .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#htqnnljqeh .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#htqnnljqeh .gt_left {
  text-align: left;
}

#htqnnljqeh .gt_center {
  text-align: center;
}

#htqnnljqeh .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#htqnnljqeh .gt_font_normal {
  font-weight: normal;
}

#htqnnljqeh .gt_font_bold {
  font-weight: bold;
}

#htqnnljqeh .gt_font_italic {
  font-style: italic;
}

#htqnnljqeh .gt_super {
  font-size: 65%;
}

#htqnnljqeh .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#htqnnljqeh .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#htqnnljqeh .gt_indent_1 {
  text-indent: 5px;
}

#htqnnljqeh .gt_indent_2 {
  text-indent: 10px;
}

#htqnnljqeh .gt_indent_3 {
  text-indent: 15px;
}

#htqnnljqeh .gt_indent_4 {
  text-indent: 20px;
}

#htqnnljqeh .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1952</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1972</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1992</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Afghanistan</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$779</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$740</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$649</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Albania</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$1,601</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$3,313</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$2,497</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Algeria</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$2,449</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$4,183</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$5,023</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Angola</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$3,521</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$5,473</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$2,628</td></tr>
  </tbody>
  
  
</table>
</div>
```

### Principle Five: Use Color Intentionally {-}

Up to this point, our table has not had any color. We're now going to add some, using color to highlight outliers. Especially for those readers who want to scan your table, highlighting outliers with color can help significantly. Let's make the highest value in any single year a different color. To do this, we again use the `tab_style()` function. Within this function, I'm using the `cell_text()` function to change both the color of text to orange and make it bold. I'm then using the `locations` argument to say that we want to adjust cells in the body of the table. Within the `cells_body()` function, we have to specify both the columns we want to apply our change to and the rows. If we just look at 1952, we see that we set the columns equal to that year. The rows are set to a more complicated formula. The text rows = `1952` == max(`1952`) means that the text transformation will occur in rows where the value is equal to the maximum value in that year. 


```{=html}
<div id="bfpmrwcyay" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#bfpmrwcyay .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#bfpmrwcyay .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#bfpmrwcyay .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#bfpmrwcyay .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#bfpmrwcyay .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bfpmrwcyay .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#bfpmrwcyay .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#bfpmrwcyay .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#bfpmrwcyay .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#bfpmrwcyay .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#bfpmrwcyay .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#bfpmrwcyay .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#bfpmrwcyay .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#bfpmrwcyay .gt_from_md > :first-child {
  margin-top: 0;
}

#bfpmrwcyay .gt_from_md > :last-child {
  margin-bottom: 0;
}

#bfpmrwcyay .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#bfpmrwcyay .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#bfpmrwcyay .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#bfpmrwcyay .gt_row_group_first td {
  border-top-width: 2px;
}

#bfpmrwcyay .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bfpmrwcyay .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#bfpmrwcyay .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#bfpmrwcyay .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bfpmrwcyay .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#bfpmrwcyay .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#bfpmrwcyay .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#bfpmrwcyay .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#bfpmrwcyay .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#bfpmrwcyay .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#bfpmrwcyay .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#bfpmrwcyay .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#bfpmrwcyay .gt_left {
  text-align: left;
}

#bfpmrwcyay .gt_center {
  text-align: center;
}

#bfpmrwcyay .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#bfpmrwcyay .gt_font_normal {
  font-weight: normal;
}

#bfpmrwcyay .gt_font_bold {
  font-weight: bold;
}

#bfpmrwcyay .gt_font_italic {
  font-style: italic;
}

#bfpmrwcyay .gt_super {
  font-size: 65%;
}

#bfpmrwcyay .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#bfpmrwcyay .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#bfpmrwcyay .gt_indent_1 {
  text-indent: 5px;
}

#bfpmrwcyay .gt_indent_2 {
  text-indent: 10px;
}

#bfpmrwcyay .gt_indent_3 {
  text-indent: 15px;
}

#bfpmrwcyay .gt_indent_4 {
  text-indent: 20px;
}

#bfpmrwcyay .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1952</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1972</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1992</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Afghanistan</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$779</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$740</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$649</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Albania</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$1,601</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$3,313</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$2,497</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Algeria</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$2,449</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$4,183</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent; color: #FFA500; font-weight: bold;">$5,023</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Angola</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent; color: #FFA500; font-weight: bold;">$3,521</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent; color: #FFA500; font-weight: bold;">$5,473</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$2,628</td></tr>
  </tbody>
  
  
</table>
</div>
```

We then repeat this same code for 1972 and 1992, ending up with the table below.


```{=html}
<div id="rbfqqkguvf" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#rbfqqkguvf .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#rbfqqkguvf .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#rbfqqkguvf .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#rbfqqkguvf .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#rbfqqkguvf .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rbfqqkguvf .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#rbfqqkguvf .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#rbfqqkguvf .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#rbfqqkguvf .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#rbfqqkguvf .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#rbfqqkguvf .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#rbfqqkguvf .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#rbfqqkguvf .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#rbfqqkguvf .gt_from_md > :first-child {
  margin-top: 0;
}

#rbfqqkguvf .gt_from_md > :last-child {
  margin-bottom: 0;
}

#rbfqqkguvf .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#rbfqqkguvf .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#rbfqqkguvf .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#rbfqqkguvf .gt_row_group_first td {
  border-top-width: 2px;
}

#rbfqqkguvf .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rbfqqkguvf .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#rbfqqkguvf .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#rbfqqkguvf .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rbfqqkguvf .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rbfqqkguvf .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#rbfqqkguvf .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#rbfqqkguvf .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rbfqqkguvf .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#rbfqqkguvf .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rbfqqkguvf .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#rbfqqkguvf .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#rbfqqkguvf .gt_left {
  text-align: left;
}

#rbfqqkguvf .gt_center {
  text-align: center;
}

#rbfqqkguvf .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#rbfqqkguvf .gt_font_normal {
  font-weight: normal;
}

#rbfqqkguvf .gt_font_bold {
  font-weight: bold;
}

#rbfqqkguvf .gt_font_italic {
  font-style: italic;
}

#rbfqqkguvf .gt_super {
  font-size: 65%;
}

#rbfqqkguvf .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#rbfqqkguvf .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#rbfqqkguvf .gt_indent_1 {
  text-indent: 5px;
}

#rbfqqkguvf .gt_indent_2 {
  text-indent: 10px;
}

#rbfqqkguvf .gt_indent_3 {
  text-indent: 15px;
}

#rbfqqkguvf .gt_indent_4 {
  text-indent: 20px;
}

#rbfqqkguvf .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1952</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1972</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1992</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Afghanistan</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$779</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$740</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$649</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Albania</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$1,601</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$3,313</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$2,497</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Algeria</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$2,449</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$4,183</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent; color: #FFA500; font-weight: bold;">$5,023</td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Angola</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent; color: #FFA500; font-weight: bold;">$3,521</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent; color: #FFA500; font-weight: bold;">$5,473</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$2,628</td></tr>
  </tbody>
  
  
</table>
</div>
```

### Principle Six: Add Data Visualization Where Appropriate {-}

Adding color to highlight outliers is one way to help guide the reader's attention. Another way is to incorporate graphs into tables. Tom Mock has developed an add-on package for `gt` called `gtExtras` that makes it possible to do just this. In our table that we've made we might want to show the trend of GDP by country. To do that, we'll add a new column that shows this trend using a sparkline (essentially, a simple line chart). 
The `gt_plt_sparkline()` function that we'll use to do this requires us to have a single column with all of the values needed to make the sparkline. We'll create a variable called `Trend` using `group_by()` and `mutate()`. This variable will be a list of the values for each country (so, for Afghanistan, it would be 779.4453145, 739.9811058, and 649.3413952). From there, we create our table, same as before. But at the end of our code, we add the `gt_plt_sparkline()` function. Within this function, we specify which column to use to create the sparkline (`Trend`). We set `label = FALSE` to remove text labels that `gt_plt_sparkline()` adds by default. And we add `palette = c("black", "transparent", "transparent", "transparent", "transparent")` to make the sparkline black and all other elements of it transparent (by default, the function will make different parts of the sparkline different colors). This stripped-down sparkline now allows the user to see the trend for each country at a glance. 


```{=html}
<div id="vpztriwfya" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#vpztriwfya .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#vpztriwfya .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#vpztriwfya .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#vpztriwfya .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#vpztriwfya .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vpztriwfya .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#vpztriwfya .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#vpztriwfya .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#vpztriwfya .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#vpztriwfya .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#vpztriwfya .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#vpztriwfya .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#vpztriwfya .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#vpztriwfya .gt_from_md > :first-child {
  margin-top: 0;
}

#vpztriwfya .gt_from_md > :last-child {
  margin-bottom: 0;
}

#vpztriwfya .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#vpztriwfya .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#vpztriwfya .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#vpztriwfya .gt_row_group_first td {
  border-top-width: 2px;
}

#vpztriwfya .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vpztriwfya .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#vpztriwfya .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#vpztriwfya .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vpztriwfya .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vpztriwfya .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#vpztriwfya .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#vpztriwfya .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vpztriwfya .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#vpztriwfya .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#vpztriwfya .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#vpztriwfya .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#vpztriwfya .gt_left {
  text-align: left;
}

#vpztriwfya .gt_center {
  text-align: center;
}

#vpztriwfya .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#vpztriwfya .gt_font_normal {
  font-weight: normal;
}

#vpztriwfya .gt_font_bold {
  font-weight: bold;
}

#vpztriwfya .gt_font_italic {
  font-style: italic;
}

#vpztriwfya .gt_super {
  font-size: 65%;
}

#vpztriwfya .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#vpztriwfya .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#vpztriwfya .gt_indent_1 {
  text-indent: 5px;
}

#vpztriwfya .gt_indent_2 {
  text-indent: 10px;
}

#vpztriwfya .gt_indent_3 {
  text-indent: 15px;
}

#vpztriwfya .gt_indent_4 {
  text-indent: 20px;
}

#vpztriwfya .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1952</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1972</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">1992</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" style="font-weight: bold;" scope="col">Trend</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Afghanistan</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$779</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$740</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$649</td>
<td class="gt_row gt_center" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;"><?xml version='1.0' encoding='UTF-8' ?><svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' class='svglite' width='85.04pt' height='14.17pt' viewBox='0 0 85.04 14.17'><defs>  <style type='text/css'><![CDATA[    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }  ]]></style></defs><rect width='100%' height='100%' style='stroke: none; fill: none;'/><defs>  <clipPath id='cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3'>    <rect x='0.00' y='0.00' width='85.04' height='14.17' />  </clipPath></defs><g clip-path='url(#cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3)'><polyline points='3.87,12.05 42.52,12.14 81.17,12.34 ' style='stroke-width: 1.07; stroke-linecap: butt;' /><circle cx='81.17' cy='12.34' r='0.89' style='stroke-width: 0.71; stroke: none;' /><circle cx='81.17' cy='12.34' r='0.89' style='stroke-width: 0.71; stroke: none;' /><circle cx='3.87' cy='12.05' r='0.89' style='stroke-width: 0.71; stroke: none;' /></g></svg></td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Albania</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$1,601</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$3,313</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$2,497</td>
<td class="gt_row gt_center" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;"><?xml version='1.0' encoding='UTF-8' ?><svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' class='svglite' width='85.04pt' height='14.17pt' viewBox='0 0 85.04 14.17'><defs>  <style type='text/css'><![CDATA[    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }  ]]></style></defs><rect width='100%' height='100%' style='stroke: none; fill: none;'/><defs>  <clipPath id='cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3'>    <rect x='0.00' y='0.00' width='85.04' height='14.17' />  </clipPath></defs><g clip-path='url(#cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3)'><polyline points='3.87,10.26 42.52,6.54 81.17,8.31 ' style='stroke-width: 1.07; stroke-linecap: butt;' /><circle cx='81.17' cy='8.31' r='0.89' style='stroke-width: 0.71; stroke: none;' /><circle cx='3.87' cy='10.26' r='0.89' style='stroke-width: 0.71; stroke: none;' /><circle cx='42.52' cy='6.54' r='0.89' style='stroke-width: 0.71; stroke: none;' /></g></svg></td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Algeria</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$2,449</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$4,183</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent; color: #FFA500; font-weight: bold;">$5,023</td>
<td class="gt_row gt_center" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;"><?xml version='1.0' encoding='UTF-8' ?><svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' class='svglite' width='85.04pt' height='14.17pt' viewBox='0 0 85.04 14.17'><defs>  <style type='text/css'><![CDATA[    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }  ]]></style></defs><rect width='100%' height='100%' style='stroke: none; fill: none;'/><defs>  <clipPath id='cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3'>    <rect x='0.00' y='0.00' width='85.04' height='14.17' />  </clipPath></defs><g clip-path='url(#cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3)'><polyline points='3.87,8.42 42.52,4.65 81.17,2.82 ' style='stroke-width: 1.07; stroke-linecap: butt;' /><circle cx='81.17' cy='2.82' r='0.89' style='stroke-width: 0.71; stroke: none;' /><circle cx='3.87' cy='8.42' r='0.89' style='stroke-width: 0.71; stroke: none;' /><circle cx='81.17' cy='2.82' r='0.89' style='stroke-width: 0.71; stroke: none;' /></g></svg></td></tr>
    <tr><td class="gt_row gt_left" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">Angola</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent; color: #FFA500; font-weight: bold;">$3,521</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent; color: #FFA500; font-weight: bold;">$5,473</td>
<td class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;">$2,628</td>
<td class="gt_row gt_center" style="border-left-width: 1px; border-left-style: solid; border-left-color: transparent; border-right-width: 1px; border-right-style: solid; border-right-color: transparent; border-top-width: 1px; border-top-style: solid; border-top-color: transparent; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: transparent;"><?xml version='1.0' encoding='UTF-8' ?><svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' class='svglite' width='85.04pt' height='14.17pt' viewBox='0 0 85.04 14.17'><defs>  <style type='text/css'><![CDATA[    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }  ]]></style></defs><rect width='100%' height='100%' style='stroke: none; fill: none;'/><defs>  <clipPath id='cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3'>    <rect x='0.00' y='0.00' width='85.04' height='14.17' />  </clipPath></defs><g clip-path='url(#cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3)'><polyline points='3.87,6.09 42.52,1.84 81.17,8.03 ' style='stroke-width: 1.07; stroke-linecap: butt;' /><circle cx='81.17' cy='8.03' r='0.89' style='stroke-width: 0.71; stroke: none;' /><circle cx='81.17' cy='8.03' r='0.89' style='stroke-width: 0.71; stroke: none;' /><circle cx='42.52' cy='1.84' r='0.89' style='stroke-width: 0.71; stroke: none;' /></g></svg></td></tr>
  </tbody>
  
  
</table>
</div>
```

## Conclusion {-}

Many of the tweaks we made to create an effective table are quite subtle. Things like removing excess gridlines, bolding header text, right aligning numeric values, and adjusting the level of precision can often go unnoticed. But skip them and your table will be far less effective. What we ended up with is not flashy, but it does communicate clearly, which is the main goal of tables. 

We used the `gt` package to make a high-quality table. One benefit of using this package is that we were able to use the `gt_plt_sparkline()` function from the `gtExtras` package to easily add a sparkline to our table. `gtExtras` does way more than this, though. This package has a set of "theme" functions to allow you to make your tables look like those made by FiveThirtyEight, the New York Times, the Guardian, and other news outlets. I've removed the formatting we created and instead used the `gt_theme_538()` function to make our tables look like they came from that organization. 


```{=html}
<div id="hiatstobvx" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>@import url("https://fonts.googleapis.com/css2?family=Chivo:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap");
html {
  font-family: Chivo, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#hiatstobvx .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: 300;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: none;
  border-top-width: 3px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#hiatstobvx .gt_heading {
  background-color: #FFFFFF;
  text-align: left;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#hiatstobvx .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#hiatstobvx .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#hiatstobvx .gt_bottom_border {
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hiatstobvx .gt_col_headings {
  border-top-style: none;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #000000;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#hiatstobvx .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: normal;
  text-transform: uppercase;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#hiatstobvx .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: normal;
  text-transform: uppercase;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#hiatstobvx .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#hiatstobvx .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#hiatstobvx .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #000000;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#hiatstobvx .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  text-transform: uppercase;
  border-top-style: none;
  border-top-width: 2px;
  border-top-color: #000000;
  border-bottom-style: solid;
  border-bottom-width: 1px;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#hiatstobvx .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  border-top-style: none;
  border-top-width: 2px;
  border-top-color: #000000;
  border-bottom-style: solid;
  border-bottom-width: 1px;
  border-bottom-color: #FFFFFF;
  vertical-align: middle;
}

#hiatstobvx .gt_from_md > :first-child {
  margin-top: 0;
}

#hiatstobvx .gt_from_md > :last-child {
  margin-bottom: 0;
}

#hiatstobvx .gt_row {
  padding-top: 3px;
  padding-bottom: 3px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#hiatstobvx .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 80%;
  font-weight: bolder;
  text-transform: uppercase;
  border-right-style: solid;
  border-right-width: 0px;
  border-right-color: #FFFFFF;
  padding-left: 5px;
  padding-right: 5px;
}

#hiatstobvx .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#hiatstobvx .gt_row_group_first td {
  border-top-width: 2px;
}

#hiatstobvx .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hiatstobvx .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#hiatstobvx .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#hiatstobvx .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hiatstobvx .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#hiatstobvx .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#hiatstobvx .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#hiatstobvx .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#hiatstobvx .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#hiatstobvx .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#hiatstobvx .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#hiatstobvx .gt_sourcenote {
  font-size: 12px;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#hiatstobvx .gt_left {
  text-align: left;
}

#hiatstobvx .gt_center {
  text-align: center;
}

#hiatstobvx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#hiatstobvx .gt_font_normal {
  font-weight: normal;
}

#hiatstobvx .gt_font_bold {
  font-weight: bold;
}

#hiatstobvx .gt_font_italic {
  font-style: italic;
}

#hiatstobvx .gt_super {
  font-size: 65%;
}

#hiatstobvx .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#hiatstobvx .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#hiatstobvx .gt_indent_1 {
  text-indent: 5px;
}

#hiatstobvx .gt_indent_2 {
  text-indent: 10px;
}

#hiatstobvx .gt_indent_3 {
  text-indent: 15px;
}

#hiatstobvx .gt_indent_4 {
  text-indent: 20px;
}

#hiatstobvx .gt_indent_5 {
  text-indent: 25px;
}

tbody tr:last-child {
  border-bottom: 2px solid #ffffff00;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" style="border-top-width: 0px; border-top-style: solid; border-top-color: black;" scope="col">Country</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="border-top-width: 0px; border-top-style: solid; border-top-color: black;" scope="col">1952</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="border-top-width: 0px; border-top-style: solid; border-top-color: black;" scope="col">1972</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="border-top-width: 0px; border-top-style: solid; border-top-color: black;" scope="col">1992</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" style="border-top-width: 0px; border-top-style: solid; border-top-color: black;" scope="col">Trend</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left">Afghanistan</td>
<td class="gt_row gt_right">779.4453</td>
<td class="gt_row gt_right">739.9811</td>
<td class="gt_row gt_right">649.3414</td>
<td class="gt_row gt_center"><?xml version='1.0' encoding='UTF-8' ?><svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' class='svglite' width='85.04pt' height='14.17pt' viewBox='0 0 85.04 14.17'><defs>  <style type='text/css'><![CDATA[    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }  ]]></style></defs><rect width='100%' height='100%' style='stroke: none; fill: none;'/><defs>  <clipPath id='cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3'>    <rect x='0.00' y='0.00' width='85.04' height='14.17' />  </clipPath></defs><g clip-path='url(#cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3)'><polyline points='3.87,12.05 42.52,12.14 81.17,12.34 ' style='stroke-width: 1.07; stroke-linecap: butt;' /><circle cx='81.17' cy='12.34' r='0.89' style='stroke-width: 0.71; stroke: none;' /><circle cx='81.17' cy='12.34' r='0.89' style='stroke-width: 0.71; stroke: none;' /><circle cx='3.87' cy='12.05' r='0.89' style='stroke-width: 0.71; stroke: none;' /></g></svg></td></tr>
    <tr><td class="gt_row gt_left">Albania</td>
<td class="gt_row gt_right">1601.0561</td>
<td class="gt_row gt_right">3313.4222</td>
<td class="gt_row gt_right">2497.4379</td>
<td class="gt_row gt_center"><?xml version='1.0' encoding='UTF-8' ?><svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' class='svglite' width='85.04pt' height='14.17pt' viewBox='0 0 85.04 14.17'><defs>  <style type='text/css'><![CDATA[    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }  ]]></style></defs><rect width='100%' height='100%' style='stroke: none; fill: none;'/><defs>  <clipPath id='cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3'>    <rect x='0.00' y='0.00' width='85.04' height='14.17' />  </clipPath></defs><g clip-path='url(#cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3)'><polyline points='3.87,10.26 42.52,6.54 81.17,8.31 ' style='stroke-width: 1.07; stroke-linecap: butt;' /><circle cx='81.17' cy='8.31' r='0.89' style='stroke-width: 0.71; stroke: none;' /><circle cx='3.87' cy='10.26' r='0.89' style='stroke-width: 0.71; stroke: none;' /><circle cx='42.52' cy='6.54' r='0.89' style='stroke-width: 0.71; stroke: none;' /></g></svg></td></tr>
    <tr><td class="gt_row gt_left">Algeria</td>
<td class="gt_row gt_right">2449.0082</td>
<td class="gt_row gt_right">4182.6638</td>
<td class="gt_row gt_right" style="color: #FFA500; font-weight: bold;">5023.2166</td>
<td class="gt_row gt_center"><?xml version='1.0' encoding='UTF-8' ?><svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' class='svglite' width='85.04pt' height='14.17pt' viewBox='0 0 85.04 14.17'><defs>  <style type='text/css'><![CDATA[    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }  ]]></style></defs><rect width='100%' height='100%' style='stroke: none; fill: none;'/><defs>  <clipPath id='cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3'>    <rect x='0.00' y='0.00' width='85.04' height='14.17' />  </clipPath></defs><g clip-path='url(#cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3)'><polyline points='3.87,8.42 42.52,4.65 81.17,2.82 ' style='stroke-width: 1.07; stroke-linecap: butt;' /><circle cx='81.17' cy='2.82' r='0.89' style='stroke-width: 0.71; stroke: none;' /><circle cx='3.87' cy='8.42' r='0.89' style='stroke-width: 0.71; stroke: none;' /><circle cx='81.17' cy='2.82' r='0.89' style='stroke-width: 0.71; stroke: none;' /></g></svg></td></tr>
    <tr><td class="gt_row gt_left">Angola</td>
<td class="gt_row gt_right" style="color: #FFA500; font-weight: bold;">3520.6103</td>
<td class="gt_row gt_right" style="color: #FFA500; font-weight: bold;">5473.2880</td>
<td class="gt_row gt_right">2627.8457</td>
<td class="gt_row gt_center"><?xml version='1.0' encoding='UTF-8' ?><svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' class='svglite' width='85.04pt' height='14.17pt' viewBox='0 0 85.04 14.17'><defs>  <style type='text/css'><![CDATA[    .svglite line, .svglite polyline, .svglite polygon, .svglite path, .svglite rect, .svglite circle {      fill: none;      stroke: #000000;      stroke-linecap: round;      stroke-linejoin: round;      stroke-miterlimit: 10.00;    }    .svglite text {      white-space: pre;    }  ]]></style></defs><rect width='100%' height='100%' style='stroke: none; fill: none;'/><defs>  <clipPath id='cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3'>    <rect x='0.00' y='0.00' width='85.04' height='14.17' />  </clipPath></defs><g clip-path='url(#cpMC4wMHw4NS4wNHwwLjAwfDE0LjE3)'><polyline points='3.87,6.09 42.52,1.84 81.17,8.03 ' style='stroke-width: 1.07; stroke-linecap: butt;' /><circle cx='81.17' cy='8.03' r='0.89' style='stroke-width: 0.71; stroke: none;' /><circle cx='81.17' cy='8.03' r='0.89' style='stroke-width: 0.71; stroke: none;' /><circle cx='42.52' cy='1.84' r='0.89' style='stroke-width: 0.71; stroke: none;' /></g></svg></td></tr>
  </tbody>
  
  
</table>
</div>
```

Add-on packages like `gtExtras` are common in the table-making landscape. If you are working with the `reactable` package to make interactive tables, for example, you can also use the `reactablefmtr` to add interactive sparklines, themes, and more. The functionality that you get from these packages is enough to never make you go back to making tables in Word!

No matter which packages you use to make tables, it's essential to treat them as worthy of as much thought as data visualization (because, let me remind you, tables *are* data visualization). Good tables are well designed; they are not data dumps. And fortunately for us, R is well-suited to making well designed tables. Working within R, the tool you're already using to create your reports (TODO add something about RMarkdown?), you make publication-ready tables with just a few lines of code.

<!--chapter:end:tables.Rmd-->

# (PART\*) Communicate {-}

<!--chapter:end:part-communicate.Rmd-->

# Use RMarkdown to Communicate Accurately and Efficiently 


<!--chapter:end:rmarkdown.Rmd-->

# Use RMarkdown to Instantly Generate Hundreds of Reports 

<!--chapter:end:parameterized-reports.Rmd-->

# Create Beautiful Presentations with RMarkdown 


<!--chapter:end:presentations.Rmd-->

# Make Websites to Share Results Online 

- When to do static vs when you need Shiny

<!--chapter:end:websites.Rmd-->

# (PART\*) Automate {-}

<!--chapter:end:part-automate.Rmd-->

# Access Up to Date Census Data with the `tidycensus` Package 


<!--chapter:end:tidycensus.Rmd-->

# Pull in Survey Results as Soon as They Come In 


<!--chapter:end:qualtrics.Rmd-->

# Stop Copying and Pasting Code by Creating Your Own Functions {#functions}

https://twitter.com/hadleywickham/status/1574373127349575680

<!--chapter:end:functions.Rmd-->

# Bundle Your Functions Together in Your Own R Package {#custom-packages}

<!--chapter:end:custom-packages.Rmd-->

# (PART\*) Conclusion {-}


<!--chapter:end:part-conclusion.Rmd-->

# Come for the Data, Stay for the Community 


<!--chapter:end:conclusion.Rmd-->

