# An R Programming Crash Course

R has a well-earned reputation for being hard to learn. Especially for those who come to R without programming experience, it can be hard to figure out how things work. This chapter is designed to help those who have never used R learn the basics. I'll start from scratch, showing you what you need to download in order to use R, and how to work with data using functions, objects, packages, and projects. If you've used R before, feel free to skip this chapter. But if you're just starting out, this chapter will help set you up to make sense of the rest of the book.

## Getting Set Up {-}

One of the more confusing things for people just starting out is that you need two pieces of software in order to use R. The first is R itself, which provides the engine that makes R work. The second is RStudio, which makes working with R much easier.

TODO: Add engine/dashboard image with credit to Modern Dive

Let's download each piece and get started. To download R, go to https://cloud.r-project.org/ and choose your operating system.

TODO: Add screenshot

Once you download and install R, open it and you will see Figure \@ref(fig:TODO).

TODO: Add screenshot

You can work directly in the R.  For example, I can type 2 + 2, hit enter, and I will see 4.

TODO: Add screenshot

Simple math problems are only the start, of course. You can do pretty much anything in R. No matter what you're planning to do, you're probably not super impressed with user-friendliness of R. A few brave souls work only using the command line style interface we're looking at, but most do not. RStudio is where most R coders do their work. RStudio is like a skin that lives on top of R itself. It doesn't provide new functionality to R, but it wraps R in a much more user-friendly app, providing a way to see your files, outputs, and more. You can download RStudio at https://posit.co/download/rstudio-desktop/. 

TODO: Add screenshot

Install RStudio as you would any other app and open it up. You'll see that RStudio has several panels. The first time you open RStudio, you'll see these three panels:

TODO: Add screenshot

The left side panel should look familiar. It is what we saw when working just in R. This is known as the **console**. You'll use it to add code and see results. This panel, like the others we'll discuss, has several tabs (terminal and background jobs) for more advanced usages. For now, we'll stick to the default tab. Let's look at the bottom right panel next. This **files** panel shows all of the files on my computer. Finally, the top right panel shows my **environment**. The environment is what functions and objects (both of which are discussed below) I have available to me when working in RStudio.

TODO: Add screenshot of all panels

There's one more panel that you'll typically have when working in RStudio. But to make it appear, we need to create an R script file. 

## Files {-}

If you work in the console, either in RStudio or in R itself, you won't have a record of your code. Say you sit down today and write code to import your data, analyze it, and make some graphs. You wouldn't want to have to recreate that code from scratch tomorrow. The way to save your code is by using files. There are two types of files we'll discuss in this book:

1. R script files, which contain code.
2. R Markdown files, which contain code combined with text. 

We'll talk about R Markdown files starting in Chapter \@ref(rmarkdown-chapter). Let's start with R script files, which use the .R extension. To create an R script file, go to File > New File > R Script. When you create a new R script file, you'll now have fourth panel in the top left. 

TODO: Add screenshot

I'll save this file in my `Documents` folder as `sample-code.R`. I can now use the same syntax in my R script file that I did when working in just R. If I type `2 + 2` in the R script file and hit the **Run** button, the 4 will show up in the console pane. 

TODO: Add screenshot of code and show run button

If you're looking to learn R, it's probably not to figure out the answer to 2 + 2. Instead, you probably want to read in your own data and do analysis on it. Let's now work with some real data. 

## Working with Data {-}

Let's talk about working with data in R. We'll go on a bit of a detour, with stops to discuss RStudio functions, objects, packages, and projects, but we'll end up importing and taking a look at data in R.

Conceptually, working with data in R is very different than working with data in a tool like Excel. In Excel, your data and any analysis you do on it all live in the same place: a spreadsheet. With R, you typically have data that lives in some external source (for example, an Excel spreadsheet). In order to work with this data in R, you have to run code to import it. It's only once you've run this code, which is made up of functions, that you have the data available in R. 

## Functions {-}

Let's say I have a CSV file called `population-by-state.csv` in my `Documents` folder that I want to import to R. To import it into R, you might think to add a line like this in the `sample-code.R` file:

```
read.csv(file = "Documents/population-by-state.csv")
```

This line shows the `read.csv()` function. Functions in R are pieces of code that you can run to achieve specific goals. Functions have two pieces:

1. A name.
2. Arguments, which are surrounded by parentheses.

Looking at the `read.csv()` function, the name, which appears before the open parentheses, is `read.csv`. Within the parentheses, we have the text `file = "Documents/population-by-state.csv"`. Here we can see the argument `file`. The text after the equals sign gives the location of the file we want to read in. Arguments work in this way: the argument name, followed by the equals sign, followed by some value. Functions can have multiple arguments as well, each of which is separated by a comma. 

At this point, you might think to run the code in order to import your data. You can do so by selecting the line of code and hitting the Run button (or using the keyboard shortcut Command/Control + Enter on Mac/Windows). Running this code sees this text show up in console pane. 

```
 rank                State      Pop  Growth  Pop2018  Pop2010 growthSince2010 Percent    density
1     1           California 39613493  0.0038 39461588 37319502          0.0615  0.1184   254.2929
2     2                Texas 29730311  0.0385 28628666 25241971          0.1778  0.0889   113.8081
3     3              Florida 21944577  0.0330 21244317 18845537          0.1644  0.0656   409.2229
4     4             New York 19299981 -0.0118 19530351 19399878         -0.0051  0.0577   409.5400
5     5         Pennsylvania 12804123  0.0003 12800922 12711160          0.0073  0.0383   286.1704
6     6             Illinois 12569321 -0.0121 12723071 12840503         -0.0211  0.0376   226.3967
7     7                 Ohio 11714618  0.0033 11676341 11539336          0.0152  0.0350   286.6944
8     8              Georgia 10830007  0.0303 10511131  9711881          0.1151  0.0324   188.3054
9     9       North Carolina 10701022  0.0308 10381615  9574323          0.1177  0.0320   220.1041
10   10             Michigan  9992427  0.0008  9984072  9877510          0.0116  0.0299   176.7351
11   11           New Jersey  8874520 -0.0013  8886025  8799446          0.0085  0.0265  1206.7609
12   12             Virginia  8603985  0.0121  8501286  8023699          0.0723  0.0257   217.8776
13   13           Washington  7796941  0.0363  7523869  6742830          0.1563  0.0233   117.3249
14   14              Arizona  7520103  0.0506  7158024  6407172          0.1737  0.0225    66.2016
15   15            Tennessee  6944260  0.0255  6771631  6355311          0.0927  0.0208   168.4069
16   16        Massachusetts  6912239  0.0043  6882635  6566307          0.0527  0.0207   886.1845
17   17              Indiana  6805663  0.0165  6695497  6490432          0.0486  0.0203   189.9644
18   18             Missouri  6169038  0.0077  6121623  5995974          0.0289  0.0184    89.7419
19   19             Maryland  6065436  0.0049  6035802  5788645          0.0478  0.0181   624.8518
20   20             Colorado  5893634  0.0356  5691287  5047349          0.1677  0.0176    56.8653
21   21            Wisconsin  5852490  0.0078  5807406  5690475          0.0285  0.0175   108.0633
22   22            Minnesota  5706398  0.0179  5606249  5310828          0.0745  0.0171    71.6641
23   23       South Carolina  5277830  0.0381  5084156  4635649          0.1385  0.0158   175.5707
24   24              Alabama  4934193  0.0095  4887681  4785437          0.0311  0.0147    97.4271
25   25            Louisiana  4627002 -0.0070  4659690  4544532          0.0181  0.0138   107.0966
26   26             Kentucky  4480713  0.0044  4461153  4348181          0.0305  0.0134   113.4760
27   27               Oregon  4289439  0.0257  4181886  3837491          0.1178  0.0128    44.6872
28   28             Oklahoma  3990443  0.0127  3940235  3759944          0.0613  0.0119    58.1740
29   29          Connecticut  3552821 -0.0052  3571520  3579114         -0.0073  0.0106   733.7507
30   30                 Utah  3310774  0.0499  3153550  2775332          0.1929  0.0099    40.2918
31   31          Puerto Rico  3194374  0.0003  3193354  3721525         -0.1416  0.0095   923.4964
32   32               Nevada  3185786  0.0523  3027341  2702405          0.1789  0.0095    29.0195
33   33                 Iowa  3167974  0.0061  3148618  3050745          0.0384  0.0095    56.7158
34   34             Arkansas  3033946  0.0080  3009733  2921964          0.0383  0.0091    58.3059
35   35          Mississippi  2966407 -0.0049  2981020  2970548         -0.0014  0.0089    63.2186
36   36               Kansas  2917224  0.0020  2911359  2858190          0.0207  0.0087    35.6808
37   37           New Mexico  2105005  0.0059  2092741  2064552          0.0196  0.0063    17.3540
38   38             Nebraska  1951996  0.0137  1925614  1829542          0.0669  0.0058    25.4087
39   39                Idaho  1860123  0.0626  1750536  1570746          0.1842  0.0056    22.5079
40   40        West Virginia  1767859 -0.0202  1804291  1854239         -0.0466  0.0053    73.5443
41   41               Hawaii  1406430 -0.0100  1420593  1363963          0.0311  0.0042   218.9678
42   42        New Hampshire  1372203  0.0138  1353465  1316762          0.0421  0.0041   153.2674
43   43                Maine  1354522  0.0115  1339057  1327629          0.0203  0.0040    43.9167
44   44              Montana  1085004  0.0229  1060665   990697          0.0952  0.0032     7.4547
45   45         Rhode Island  1061509  0.0030  1058287  1053959          0.0072  0.0032  1026.6044
46   46             Delaware   990334  0.0257   965479   899593          0.1009  0.0030   508.1242
47   47         South Dakota   896581  0.0204   878698   816166          0.0985  0.0027    11.8265
48   48         North Dakota   770026  0.0158   758080   674715          0.1413  0.0023    11.1596
49   49               Alaska   724357 -0.0147   735139   713910          0.0146  0.0022     1.2694
50   50 District of Columbia   714153  0.0180   701547   605226          0.1800  0.0021 11707.4262
51   51              Vermont   623251 -0.0018   624358   625879         -0.0042  0.0019    67.6197
52   52              Wyoming   581075  0.0060   577601   564487          0.0294  0.0017     5.9847
```

This is R confirming that it read in the CSV file and showing us the data within it. You might think you are ready to work with your data in R. But in fact all you've done at this point is **display** the result of running the code that imports your data. To use the data again, you need to **save** the result of running the code.

## Objects {-}

To save your data for reuse, you need to create an object. To do so, you would add to your data importing syntax from above. 

```
population_data <- read.csv(file = "Documents/population-by-state.csv")
```

The second half of this code should look familiar, but we've added to it. In the middle you will see this: `<-`. Known as the assignment operator, it takes what follows it and assigns it to the item on the left. To the left of the assignment operator is `population_data`. This is an **object**. Put together, the whole line reads in the CSV and assigns it to an object called `population_data`. If you run this line of code, you will now see `population_data` in your environment pane. 

TODO: Add screenshot

This is confirmation that your data import worked and you have the `population_data` object ready for any future use. Now, instead of having to rerun the code to import the data, I can simply type `population_data`, run that line, and I'll see the same output as above. Data imported to an object is known as a **data frame**.

## Packages {-}

The `read.csv()` function that we've used up to this point is one of a set of functions that come from what is known as base R. They are built into R and you simply have to type the name of the function to use it. However, one of the benefits of R being an open source language is that anyone can write code that others can use. When people bundle a series of functions together, it is known as a **package**. 

The best analogy for understanding packages also comes from the *Modern Dive*  book by Chester Ismay and Albert Y. Kim. The functionality in base R is like when you get a new phone. It can do a lot on its own. But you usually want to install apps on your phone to do specific things. Packages are like apps, giving you specific functionality that doesn't come built into base R.

TODO: Add screenshot

You can install a package using the `install.packages()` function. For example, to install the `tidyverse` package, which provides a range of functions for data import, cleaning, analysis, visualization, and more, you would type `install.packages("tidyverse")`. I typically enter this code in the console because you only need to install a package once on your computer. To confirm that the `tidyverse` package has been installed correctly, click on the packages tab on the bottom right panel. Search for `tidyverse` and you should see it pop up.

TODO: Add screenshot

Now that we've installed the `tidyverse` package, let's use it. While you only need to install packages once per computer, you need to load packages each time you restart RStudio. You can only use functions from the `tidyverse` package if you first run the line `library(tidyverse)`. I'll go back to my `sample-code.R` file and re-import my data using a function from the `tidyverse` package. 

```
library(tidyverse)

population_data <- read_csv(file = "Documents/population-by-state.csv")
```

At the top of my script I load the `tidyverse`. Then, I use the `read_csv()` function (note the `_` in place of the `.`) to import my data. This alternate function to import CSV files achieves the same goal of creating an object called `population_data`. If we type `population_data` and run the code (either by using the run button or the keyboard shortcut) you will see the output in the console. 

```{r}
population_data
```

The output is slightly different from what we saw above using the `read.csv()` function. It describes the output as a **tibble** and only shows us the first 10 rows. This slightly different output occurs because `read_csv()` imports the data not as a data frame, but as a tibble. Both are used to describe rectangular data similar to what you might see in a spreadsheet. While there are some small differences between data frames and tibbles, I'll use the terms interchangeably in this book. 

Before moving on from our discussion of packages, let me show you a bit more code so you can see that the `tidyverse` is more than just the `read_csv()` function. Below is a code snippet that calculates the mean population of all states. It does so by starting with the `population_data` data frame that we imported. It then uses what's known as a pipe, written with the text `%>%`. This allows us to start with our data and then do additional operations on it. The second line uses the `summarize()` function (made available when we load the `tidyverse` package) and then calculates a new variable called `mean_population` by using the `mean()` function on the `Pop` variable. 

```{r eval = FALSE, echo = TRUE}
population_data %>% 
  summarize(mean_population = mean(Pop))
```

Running this code will return the mean population of all states.

```{r}
population_data %>% 
  summarize(mean_population = mean(Pop))
```

The `tidyverse` has many functions that enable you to do nearly anything you could hope to do with your data. In this book, I'll introduce you to a number of packages, but the `tidyverse` is the one package you will find in every single piece of R code I write. 

Before you try to write code to do something, do a bit of searching to see if you can find a package that could help. You'll be surprised how often someone else has done the hard work for you!

## Projects {-}

So far, we've imported a CSV file from the Documents folder. But what happens if you're working with someone who has put the CSV file in, say, their Downloads folder? If they try to run our code, it won't work. There's a solution to this problem, and it's called RStudio projects. 

By working in a project, you can use what are known as **relative paths** to your files. Instead of having to write out `read_csv(file = "Documents/population-by-state.csv")`, you can put the CSV file in your project and then call it using `read_csv(file = "population-by-state.csv")`. This makes it easier for you, and enables others to use your code.

To create a new RStudio project, go to File > New Project. Select either New Directory or Existing Directory and choose where to put your project. 

TODO: Add screenshot

If you choose New Directory, you'll need to specify that you want to create a new project. I'll do this and then choose a name for the new directory and where it should live. You can leave the two checkboxes that ask about creating a git repository and using `renv` unchecked (these are for more advanced purposes). 

TODO: Add screenshot

Having now created this `example-project` project, there are two major differences in RStudio's appearance:

First, the files pane no longer shows every file on my computer, but instead only shows files in the `example-project` directory. Right now that's just the `example-project.Rproj` file that indicates the folder contains a project.

TODO: Add screenshot

Second, at the very top right of RStudio, you can see the name of the `example-project` project (it had previously said `Project: (None)`).  If you want to make sure you're working in a project, make sure you see its name here.

TODO: Add screenshot

Now that I've created a project, I'll use the Finder on my Mac computer to copy the `population-by-state.csv` file into the `example-project` directory. Once I do this, I can see it in the RStudio files pane.

TODO: Add screenshot

With this CSV file in my project, I can now import it more easily. As before, I'll start by loading the `tidyverse` package. After that, I can remove the reference to the `Documents` folder and import my data by simply using its name:

```
library(tidyverse)

population_data <- read_csv(file = "population-by-state.csv")
```

I'm able to import the `population-by-state.csv` file in this way because the RStudio project sets the **working directory** to be the root of my project. That is, all references to files are relative to the `.Rproj` file at the root of the project. If we were to put `population-by-state.csv` in a `data` folder, we could then use `read_csv(file = "data/population-by-state.csv")`. And now anyone can run this code because it imports data from a location that they are guaranteed to have on their computer. 

## How to Get Help {-}

Now that you've learned about the basics of how R works, you're probably ready to dive in. When you do, you're going to encounter errors. Everyone does, and it's just part of working in R. Learning how to get help when you do run into issues is a key part of learning to use R successfully. There are a few strategies you can use to get unstuck.

The first is to read the documentation. The easiest way to do this is to use the `?` in combination with a function. For example, if I type `?read_csv()` in the console, I will see the documentation of how that function works appear in the bottom right panel. 

TODO: Add screenshot

Help files can be a bit hard to decipher but at their core, they tell you what package the function comes from, what it does, its arguments, and some examples of how to use it. For additional guidance on reading documentation, I recommend the appendix of Kieran Healy's book *Data Visualization: A practical introduction* (a free online version is available at https://socviz.co/appendix.html).

In addition to providing help files in RStudio, many R packages have documentation websites. I find these easier to read and tend to use them when I have questions. In addition, many packages have longer articles known as vignettes that provide an overview of how the package works. Reading these can help you see how individual functions can be used in the context of a larger project. Every package I discuss in this book has a good documentation website. 

## Conclusion {-}