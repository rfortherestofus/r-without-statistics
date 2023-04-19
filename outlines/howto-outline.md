# Intro

- R is hard to learn

# Getting set up

- Download R 
- Download RStudio

# File types

- R script files
	- Rmd files coming later
- Data


# Working with data

- Import data as function and save as object
- Data types (data frame vs tibble)
- How to examine your data

# Packages

- tidyverse

# Functions

- How to run them
- Arguments

# Objects


# Projects

# How to get help

- ? 
- Package websites
	- Every package I recommend has one


# Conclusion

Now that you know the basics, let's do some cool stuff in R





The easiest way to do this is to use the `?` in combination with a function. For example, if I type `?summarize()` in the console, I will see the documentation of how that function works appear in the bottom right panel. Let's break down the `summarize()` documentation. At the top you will see the name of the function as well as the package it comes from. The name here is `summarise` (because `tidyverse` functions can use both American and British English spellings). We then see {dplyr}. This refers to the package that the function comes from (I've referred to the `tidyverse` as a single package, but it is technically a collection of packages, of which `dplyr` is one).

TODO: Add screenshot

Below that is a snippet of text that explains in plain English what the function does. The `Description` section gives a longer description of the same thing. 

Next is the `Usage` section. This shows all of the arguments the function expects you to use. In the case of `summarize()`, that is `.data`, `.by`, and `.groups`. The `...` you see indicates additional arguments that can be passed to another function (for more advanced usages of the function). 

The `Arguments` section provides details on all of the arguments.

The `Value` section tells us what is returned when we run this function. 


