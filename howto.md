# An R Programming Crash Course

R has a well-earned reputation for being hard to learn. Especially for those who come to R without programming experience, it can be hard to figure out how things work. This chapter is designed to expose those who have never used R to the basics. I'll start from scratch, showing you what you need to download, how to work with projects, packages, functions, objects, and the basics of working with data. If you've used R before, feel free to skip this chapter. But if you're just starting out, this chapter will help set you up for the rest of the book.

# Getting Set Up {-}

One of the more confusing things for people just starting out is that you need two pieces of software in order to use R. The first is R itself. R provides the engine that makes R work. The second is RStudio. This integrated development environment (IDE) makes working with R much easier.

TODO: Add engine/dashboard image with credit to Modern Dive

Let's download each piece and get started. To download R, go to https://cloud.r-project.org/ and choose your operating system.

TODO: Add screenshot

Once you download and install R, open it and you will see Figure \@ref(fig:TODO).

TODO: Add screenshot

You can work directly in the R.  For example, I can type 2 + 2, hit enter, and I will see 4.

TODO: Add screenshot

Simple math problems are only the start, of course. You can do pretty much anything in R. But, while a few brave souls work only using the command line style interface we're looking at, most people do not. RStudio is where most R coders do their work. RStudio is like a skin that lives on top of R itself. It doesn't provide new functionality to R, but it wraps R in a much more user-friendly app. You can download RStudio at https://posit.co/download/rstudio-desktop/. 

TODO: Add screenshot

Install RStudio as you would any other app and open it up. You'll see that RStudio has several panels. The first time you open RStudio, you'll see these three panels:

TODO: Add screenshot

The left side panel should look familiar. It is what we saw when working just in R. This is known as the **console**. You'll use it to add code and see results. This panel, like the others we'll discuss, has several tabs (Terminal and Background Jobs) for more advanced usages. For now, we'll stick to the default tab. Let's look at the bottom right panel next. This **files** panel shows all of the files on my computer. Finally, the top right panel shows my **environment**. The environment is what functions and objects I have available to me when working in RStudio.

TODO: Add screenshot of all panels

There's one more panel that you'll typically have when working in RStudio. But to make it appear, we need to create an R script file. 

# Files {-}

If you work in the console, either in RStudio or in R itself, you won't have a record of your code. Say you sit down today and write code to import your data, analyze it, and make some graphs. You wouldn't want to have to recreate that code from scratch tomorrow. The way to save your code is by using files. There are two types of files we'll discuss in this book:

1. R script files
2. R Markdown files

We'll talk about R Markdown files starting in Chapter \@ref(rmarkdown-chapter). Let's start with R script files, which use the .R extension. To create an R script file, go to File > New File > R Script. When you create a new R script file, you'll now have fourth panel in the top left. 

TODO: Add screenshot

I'll save this file in my `Documents` folder as `sample-code.R`. I can now use the same syntax in my R script file that I did when working in just R. If I type `2 + 2` in the R script file and hit the **Run** button, the 4 will show up in the console pane. 

TODO: Add screenshot of code and show run button

# Working with Data {-}

If you're looking to learn R, it's probably not to figure out the answer to 2 + 2. Instead, you probably want to read in your own data and do analysis on it. Let's talk about working with data in R. We'll go on a bit of a detour, with stops to discuss RStudio projects, packages, functions, and objects, but we'll end up importing and taking a look at data in R.

Conceptually, working with data in R is very different than working with data in a tool like Excel. In Excel, your data and any analysis you do on it all live in the same place: a spreadsheet. With R, you typically have data that lives in some external source (for example, an Excel spreadsheet). In order to work with this data in R, you have to run code to import it. It's only once you've run this code that you have the data available in R. 

# Functions {-}

Let's say I have a CSV file called `population-by-state.csv` in my `Documents` folder that I want to import to R. To import it into R, I would add this line in my `sample-code.R` file.

```
population_data <- read.csv(file = "Documents/population-by-state.csv")
```

I can then highlight my code and hit the Run button (or use the keyboard shortcut Command/Control + Enter on Mac/Windows). This code does two things:

1. Reads in the CSV file using a function called `read.csv()`.
2. Saves the data in the CSV file as an object called `population_data`.

Let's start with the `read.csv()` function. Functions in R are pieces of code that you can run to achieve specific goals. Functions have several pieces:

1. A name
2. Opening and closed parentheses
3. Arguments

When I run the function `read.csv()`, I am using the `file` argument. 



