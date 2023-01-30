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


# Making Your Own Theme

Placeholder


## The Power of a Theme {-}
## Using bbplot to Style a Penguin Plot {-}
## Creating an Example Plot {-}
### Applying the `bbc_style()` Function {-}  
### Breaking Down the Custom Theme {-}
### Text Formatting {-}
### Legend Formatting {-}
### Axis Formatting {-}
### Grid Lines Formatting {-}
### Background Formatting {-}
### Small Multiples Formatting {-}
### What About Colors? {-}
## In Conclusion: Code is the Catalyst for Culture Change {-}

<!--chapter:end:custom-theme.Rmd-->


# Creating Maps

Placeholder


## The Briefest of Primers on Geospatial Data {-}
### Geometry Type {-}
### The Dimensions {-}
### Bounding Box {-}
### The Geodetic CRS {-}
### The `geometry` Column {-}
## Recreating the COVID Map {-}
### Importing the Data {-}
### Calculating Daily COVID Cases {-}
### Calculating Incidence Rates {-}
### Adding Geospatial Data {-}
### Making the Map {-}
#### Generating the Basic Map {-}
#### Changing Colors and Beginning to Tweak the Legend {-}
#### Tweaking the Theme: The Legend {-}
#### Tweaking the Theme: The Title, Caption, and Strip Text {-}
#### Tweaking the Theme: Grid Lines and Axis Text {-}
#### Tweaking the Theme: Plot Background and Margins {-}
## Making Your Own Maps {-}
### Importing Raw Data {-}
### Accessing Geospatial Data Using R Functions {-}
### Using Appropriate Projections {-}
### Bring Your Existing R Skills to Geospatial Data {-}
### In Conclusion: R is a Map-Making Swiss Army Knife {-}

<!--chapter:end:maps.Rmd-->


# Make High-Quality Tables

Placeholder


## Table Design Principles {-}
### Principle One: Minimize Clutter {-}
### Principle Two: Differentiate the Header from the Body {-}
### Principle Three: Align Appropriately {-}
### Principle Four: Use the Right Level of Precision {-}
### Principle Five: Use Color Intentionally {-}
### Principle Six: Add Data Visualization Where Appropriate {-}
## Conclusion {-}

<!--chapter:end:tables.Rmd-->

# (PART\*) Communicate {-}

<!--chapter:end:part-communicate.Rmd-->


# Communicating with R Markdown {#rmarkdown-chapter}

Placeholder


## How R Markdown Works {-}
## Document Structure {-}
### The YAML Metadata {-}
### The Code Chunks {-}
#### Code Chunk Options {-}
### Markdown Text {-}
### Inline R Code {-}
### Running Code Chunks Interactively {-}
## Quarto {-}
## In Conclusion: R Markdown Opens up All Sorts of Possibilities {-}

<!--chapter:end:rmarkdown.Rmd-->


# Generate Multiple Reports at Once with Parameterized Reporting {#parameterized-reports-chapter}

Placeholder


## How Parameterized Reporting Works {-}
### Creating an R Markdown Document with Parameters {-}
### Creating an R Script File to Render Multiple Reports {-}
#### Step 1: Create a Vector of All States {-}
#### Step 2: Create a Tibble with Data to Render All Reports {-}
#### Step 3: Render All of the Reports {-}
## Best Practices for Working with Parameterized Reporting {-}
## In Conclusion: Parameterized Reporting Makes New Reporting Options Possible {-}

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

