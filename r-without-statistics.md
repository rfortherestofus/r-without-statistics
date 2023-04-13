--- 
title: "R Without Statistics"
author: "David Keyes"
# date: "2023-03-27"
site: bookdown::bookdown_site
documentclass: book
url: https://book.rwithoutstatistics.com
cover-image: mock-cover.png
description: |
  Since R was invented in 1993, it has become a widely used programming language for statistical analysis. From academia to the tech world and beyond, R is used for a wide range of statistical analysis. R Without Statistics will show ways that R can be used beyond complex statistical analysis. Readers will learn about a range of uses for R, many of which they have likely never even considered.
biblio-style: apalike
---

# date: "2023-03-27"

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
### Plotting One Region and Year {-}
### Changing Aesthetic Properties {-}
### Faceting the Plot {-}
### Applying Small Polishes {-}
### The Complete Visualization Code {-}
## In Conclusion: ggplot is Your Data Viz Secret Weapon {-}

<!--chapter:end:data-viz.Rmd-->


# Making Your Own Theme {#custom-theme-chapter}

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


# Creating Maps {#maps-chapter}

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
#### Applying Data Visualization Principles to the Map {-}
## Making Your Own Maps {-}
### Importing Raw Data {-}
### Accessing Geospatial Data Using R Functions {-}
### Using Appropriate Projections {-}
### Bring Your Existing R Skills to Geospatial Data {-}
## In Conclusion: R is a Map-Making Swiss Army Knife {-}

<!--chapter:end:maps.Rmd-->


# Making High-Quality Tables {#tables-chapter}

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


# Create Beautiful Presentations with R Markdown {#presentations-chapter}

Placeholder


## How `xaringan` Works {-} 
### Breaking Content Across Slides {-}
### Incrementally Revealing Content {-}
### Aligning Content {-}
### Adding Background Images to Slides {-}
### Customizing our Slides Further {-}
## In Conclusion: The Advantages of `xaringan` {-}

<!--chapter:end:presentations.Rmd-->


# Make Websites to Share Results Online {#websites-chapter} 

Placeholder


## Creating a Website With the `distill` Package {-}
## Working with R Markdown Documents in `distill` {-}
## Setting Options for Our Website with `_site.yml` {-}
## Building our Site {-}
## Custom CSS {-}
## Adding Content to Our Website {-}
## Using Different Layouts {-}
## Making Our Content Interactive {-}
## Hosting {-}
## Conclusion {-}

<!--chapter:end:websites.Rmd-->

# (PART\*) Automate {-}

<!--chapter:end:part-automate.Rmd-->


# Accessing Data {#accessing-data-chapter}

Placeholder


## Importing Data from Google Sheets {-}
### Using the `googlesheets4` Package {-}
## Accessing Census Data with the `tidycensus` Package {-}
### Using `tidycensus` {-}
### Working with Decennial Census Data {-}
#### Identifying Variables {-}
#### Using Multiple Variables {-}
#### Giving Variables More Descriptive Names {-}
### Analyzing Census Data {-}
#### Using a Summary Variable {-}
#### Working with American Community Survey Data {-}
#### Using ACS Data to Make Charts {-}
#### Using ACS Data to Make Maps {-}
## Packages like `googlesheets4` and `tidycensus` Make it Easy to Access Data {-}

<!--chapter:end:accessing-data.Rmd-->


# Code Once, Run Twice: Creating Your Own Functions {#functions-chapter}

Placeholder


## How Functions Work {-}
## Creating a ggplot Theme Function {-}
## Creating a Function to Automatically Format Race and Ethnicity Data {-}
## Conclusion {-}

<!--chapter:end:functions.Rmd-->


# Bundle Your Functions Together in Your Own R Package {#packages-chapter}

Placeholder


## Intro
## How to Create a Package {-}
### Starting the Package {-}
### Checking our Package {-}
### Adding Dependency Packages {-}
### Referring to Functions Correctly {-}
### Adding Documentation {-}
### Editing the `DESCRIPTION` File
### Installing the Package {-}
## In Conclusion: You're Already Ready to Make Your Own R Package {-}

<!--chapter:end:packages.Rmd-->

# (PART\*) Conclusion {-}


<!--chapter:end:part-conclusion.Rmd-->


# Come for the Data, Stay for the Community {#conclusion}

Placeholder


## How R Community Came to Be Welcoming {-}
## Making the R Community Welcoming for Underrepresented Folks Helps Everyone {-}

<!--chapter:end:conclusion.Rmd-->

