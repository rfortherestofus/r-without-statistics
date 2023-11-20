

# An R Programming Crash Course {#howto-chapter}

R has a well-earned reputation for being hard to learn, especially for those who come to it without prior programming experience. This chapter is designed to help those who have never used R before. You’ll set up an R programming environment with RStudio and learn how to work with data using functions, objects, packages, and projects. You’ll also be introduced to the `tidyverse` package, which contains the core data analysis and manipulation functions we’ll use in this book.

If you have prior experience with R, feel free to skip this chapter, but if you’re just starting out, it should help you make sense of the rest of the book.

## Setting Up {-}

You’ll need two pieces of software to use R effectively. The first is R itself, which provides the underlying computational tools that make the language work. The second is an integrated development environment (IDE) like RStudio. This coding platform simplifies working with R. The best way to understand the relationship between R and RStudio is with this analogy from the book *Modern Dive* by Chester Ismay and Albert Kim: R is the engine that powers your data; RStudio is like a dashboard that provides a user-friendly interface.

### Installing R and RStudio

To download R, go to https://cloud.r-project.org/ and choose the link for your operating system. Once you’ve installed it, open the file. This should open an interface like the one in Figure \@ref(fig:r-console) that lets you work with R on your operating system’s command line. For example, enter `2 + 2`, and you should see `4`.



\begin{figure}
\includegraphics[width=1\linewidth]{assets/r-console} \caption{The R console}(\#fig:r-console)
\end{figure}



A few brave souls work with R using only this command line, but most opt to use RStudio, which provides a way to see your files, the output of your code, and more. You can download RStudio at https://posit.co/download/rstudio-desktop/. Install RStudio as you would any other app and open it. 

### Exploring the RStudio Interface {-}

The first time you open RStudio, you should see the three panels shown in Figure \@ref(fig:rstudio-no-project).



\begin{figure}
\includegraphics[width=1\linewidth]{assets/rstudio-no-project} \caption{The RStudio editor}(\#fig:rstudio-no-project)
\end{figure}



The left panel should look familiar. It’s similar to the screen you saw when working in R on the command line. This is known as the *console*. You’ll use it to enter code and see the results. This panel, like the others we’ll discuss, has several tabs, such as Terminal and Background Jobs, for more advanced usages. For now, we’ll stick to the default tab. 

At the bottom right, the *files* panel shows all of the files on your computer. You can click any file to open it within RStudio. Finally, the top-right panel shows your *environment*, or the objects that are available to you when working in RStudio. We discuss objects below.

There is one more panel that you’ll typically use when working in RStudio, but to make it appear, you need to create an R script file.

## R Script Files {-}

If you write all of your code in the console, you won’t have any record of it. Say you sit down today and import your data, analyze it, and then make some graphs. If you run these operations in the console, you’ll have to recreate that code from scratch tomorrow. Writing your code in files lets you run it multiple times. There are two types of files we’ll discuss in this book:

- R script files, which contain only code.
- R Markdown files, which contain both code and text.

We'll talk about R Markdown files starting in Chapter \@ref(rmarkdown-chapter). For now, let’s work with R script files, which use the *.R* extension. To create an R script file, go to File > New File > R Script. When you create a new R script file, a fourth panel should appear in the top left of R Studio, as you can see in Figure 1-3. Save this file in your *Documents* folder as *sample-code.R*.



\begin{figure}
\includegraphics[width=1\linewidth]{assets/rstudio-four-panels} \caption{RStudio with four panels}(\#fig:rstudio-four-panels)
\end{figure}



Now you can enter R code in your script file. For example, try entering `2 + 2` in the script file panel. To run a script file, press the **Run** button or use the keyboard shortcut **CMD + ENTER** on macOS and **CTRL + ENTER** on Windows. The result (`4`, in this case) should show up in the console pane.

You now have a working programming environment. But if you’re trying to learn R, you probably want to perform more complex operations than `2 + 2`. Let’s discuss how to import data for your R programs to work with.

## Working with Data {-}

R lets you do all of the same data manipulation tasks you might perform in a tool like Excel, such as calculating averages, totals, and so on. Conceptually, however, working with data in R is very different from working with Excel, where your data and analysis code live in the same place: a spreadsheet. In R, your data typically comes from some external file. To work with this data in R, you have to run code to import it. 

### Importing Data {-}

Let’s import data from a *comma-separated values (CSV)* file. CSV files, a common way to store data, are text files that have values separated by commas. You can open them using most spreadsheet applications. Figure \@ref(fig:population-by-state-csv) shows the *population-by-state.csv* file when opened in Excel. You can download this file at https://data.rwithoutstatistics.com/population-by-state.csv. Let’s import it into R.



\begin{figure}
\includegraphics[width=1\linewidth]{assets/population-by-state-csv} \caption{The population-by-state.csv file in Excel}(\#fig:population-by-state-csv)
\end{figure}



To import the *population-by-state.csv* file into R, add a line like this one in the *sample-code.R* file, replacing the filepath with the path to the file’s location on your system:


```r
read.csv(file = "/Users/davidkeyes/Documents/population-by-state.csv")
```


This line uses the `read.csv()` function. *Functions* are pieces of code that do specific things. They have a name and *arguments*, which are values that affect the function’s behavior. For example, the `read.csv()` function’s name is `read.csv`. Within the parentheses is the argument `file`, which specifies the file from which to import data. The text after the equal sign (`=`) gives the location of that file. 

Arguments have the following structure: the argument name, followed by the equal sign and some value. Functions can have multiple arguments separated by commas. For example, this code uses the `file` and `skip` arguments to import the same file but skip the first row:


```r
read.csv(file = "/Users/davidkeyes/Documents/population-by-state.csv",
				 skip = 1)
```

At this point, you can run the code to import your data (without the `skip` argument). Select the line you want to run and press **Run**. The following output should show up in the console pane:


```
#>    rank                State      Pop  Growth  Pop2018
#> 1     1           California 39613493  0.0038 39461588
#> 2     2                Texas 29730311  0.0385 28628666
#> 3     3              Florida 21944577  0.0330 21244317
#> 4     4             New York 19299981 -0.0118 19530351
#> 5     5         Pennsylvania 12804123  0.0003 12800922
#> 6     6             Illinois 12569321 -0.0121 12723071
#> 7     7                 Ohio 11714618  0.0033 11676341
#> 8     8              Georgia 10830007  0.0303 10511131
#> 9     9       North Carolina 10701022  0.0308 10381615
#> 10   10             Michigan  9992427  0.0008  9984072
#> 11   11           New Jersey  8874520 -0.0013  8886025
#> 12   12             Virginia  8603985  0.0121  8501286
#> 13   13           Washington  7796941  0.0363  7523869
#> 14   14              Arizona  7520103  0.0506  7158024
#> 15   15            Tennessee  6944260  0.0255  6771631
#> 16   16        Massachusetts  6912239  0.0043  6882635
#> 17   17              Indiana  6805663  0.0165  6695497
#> 18   18             Missouri  6169038  0.0077  6121623
#> 19   19             Maryland  6065436  0.0049  6035802
#> 20   20             Colorado  5893634  0.0356  5691287
#> 21   21            Wisconsin  5852490  0.0078  5807406
#> 22   22            Minnesota  5706398  0.0179  5606249
#> 23   23       South Carolina  5277830  0.0381  5084156
#> 24   24              Alabama  4934193  0.0095  4887681
#> 25   25            Louisiana  4627002 -0.0070  4659690
#> 26   26             Kentucky  4480713  0.0044  4461153
#> 27   27               Oregon  4289439  0.0257  4181886
#> 28   28             Oklahoma  3990443  0.0127  3940235
#> 29   29          Connecticut  3552821 -0.0052  3571520
#> 30   30                 Utah  3310774  0.0499  3153550
#> 31   31          Puerto Rico  3194374  0.0003  3193354
#> 32   32               Nevada  3185786  0.0523  3027341
#> 33   33                 Iowa  3167974  0.0061  3148618
#> 34   34             Arkansas  3033946  0.0080  3009733
#> 35   35          Mississippi  2966407 -0.0049  2981020
#> 36   36               Kansas  2917224  0.0020  2911359
#> 37   37           New Mexico  2105005  0.0059  2092741
#> 38   38             Nebraska  1951996  0.0137  1925614
#> 39   39                Idaho  1860123  0.0626  1750536
#> 40   40        West Virginia  1767859 -0.0202  1804291
#> 41   41               Hawaii  1406430 -0.0100  1420593
#> 42   42        New Hampshire  1372203  0.0138  1353465
#> 43   43                Maine  1354522  0.0115  1339057
#> 44   44              Montana  1085004  0.0229  1060665
#> 45   45         Rhode Island  1061509  0.0030  1058287
#> 46   46             Delaware   990334  0.0257   965479
#> 47   47         South Dakota   896581  0.0204   878698
#> 48   48         North Dakota   770026  0.0158   758080
#> 49   49               Alaska   724357 -0.0147   735139
#> 50   50 District of Columbia   714153  0.0180   701547
#> 51   51              Vermont   623251 -0.0018   624358
#> 52   52              Wyoming   581075  0.0060   577601
#>     Pop2010 growthSince2010 Percent    density
#> 1  37319502          0.0615  0.1184   254.2929
#> 2  25241971          0.1778  0.0889   113.8081
#> 3  18845537          0.1644  0.0656   409.2229
#> 4  19399878         -0.0051  0.0577   409.5400
#> 5  12711160          0.0073  0.0383   286.1704
#> 6  12840503         -0.0211  0.0376   226.3967
#> 7  11539336          0.0152  0.0350   286.6944
#> 8   9711881          0.1151  0.0324   188.3054
#> 9   9574323          0.1177  0.0320   220.1041
#> 10  9877510          0.0116  0.0299   176.7351
#> 11  8799446          0.0085  0.0265  1206.7609
#> 12  8023699          0.0723  0.0257   217.8776
#> 13  6742830          0.1563  0.0233   117.3249
#> 14  6407172          0.1737  0.0225    66.2016
#> 15  6355311          0.0927  0.0208   168.4069
#> 16  6566307          0.0527  0.0207   886.1845
#> 17  6490432          0.0486  0.0203   189.9644
#> 18  5995974          0.0289  0.0184    89.7419
#> 19  5788645          0.0478  0.0181   624.8518
#> 20  5047349          0.1677  0.0176    56.8653
#> 21  5690475          0.0285  0.0175   108.0633
#> 22  5310828          0.0745  0.0171    71.6641
#> 23  4635649          0.1385  0.0158   175.5707
#> 24  4785437          0.0311  0.0147    97.4271
#> 25  4544532          0.0181  0.0138   107.0966
#> 26  4348181          0.0305  0.0134   113.4760
#> 27  3837491          0.1178  0.0128    44.6872
#> 28  3759944          0.0613  0.0119    58.1740
#> 29  3579114         -0.0073  0.0106   733.7507
#> 30  2775332          0.1929  0.0099    40.2918
#> 31  3721525         -0.1416  0.0095   923.4964
#> 32  2702405          0.1789  0.0095    29.0195
#> 33  3050745          0.0384  0.0095    56.7158
#> 34  2921964          0.0383  0.0091    58.3059
#> 35  2970548         -0.0014  0.0089    63.2186
#> 36  2858190          0.0207  0.0087    35.6808
#> 37  2064552          0.0196  0.0063    17.3540
#> 38  1829542          0.0669  0.0058    25.4087
#> 39  1570746          0.1842  0.0056    22.5079
#> 40  1854239         -0.0466  0.0053    73.5443
#> 41  1363963          0.0311  0.0042   218.9678
#> 42  1316762          0.0421  0.0041   153.2674
#> 43  1327629          0.0203  0.0040    43.9167
#> 44   990697          0.0952  0.0032     7.4547
#> 45  1053959          0.0072  0.0032  1026.6044
#> 46   899593          0.1009  0.0030   508.1242
#> 47   816166          0.0985  0.0027    11.8265
#> 48   674715          0.1413  0.0023    11.1596
#> 49   713910          0.0146  0.0022     1.2694
#> 50   605226          0.1800  0.0021 11707.4262
#> 51   625879         -0.0042  0.0019    67.6197
#> 52   564487          0.0294  0.0017     5.9847
```

This is R’s way of confirming that it imported the CSV file and understands the data within it. You can see four variables, which show the rank (in terms of population size), the state name, the population, the population growth between the `Pop` and `Pop2018` variables (expressed as a percentage), and the 2018 population. There are also several other variables that are hidden in the output, though you’ll see them if you import this CSV file yourself. We discuss variables in more detail in the next section.

You might think you’re now ready to work with your data. But all you’ve done at this point is display the result of running the code that imports your data. To use the data again, you need to save this data to an object.

## Saving Data as Objects {-}

To save your data for reuse, you need to create an object. In his book *Extending R*, John Chambers writes that “everything exists in R is an object.” For our purposes, an *object* is a data structure that we store to use later. To create an object, add to your data-importing syntax so it looks like this:


```r
population_data <- read.csv(file = "/Users/davidkeyes/Documents/population-by-state.csv")
```

The second half of this code is the same as the line shown in the previous section, except it contains this: `<-`. Known as the *assignment operator*, it takes what follows it and assigns it to the item on the left. To the left of the assignment operator is the `population_data` object. Put together, the whole line imports the CSV and assigns it to an object called `population_data`. 

If you run this code, you should see `population_data` in your environment pane, as in Figure \@ref(fig:population-data-environment).



\begin{figure}
\includegraphics[width=1\linewidth]{assets/population-data-environment} \caption{An object in our environment pane}(\#fig:population-data-environment)
\end{figure}



This message confirms that your data import worked and that the `population_data` object is ready for future use. Now, instead of having to rerun the code to import the data, you can simply enter `population_data` to output the data. 

Data imported to an object in this way is known as a *data frame*. You can see that the `population_data` data frame has 52 observations and nine variables. *Variables* are the columns in a data frame, each of which represents some value (for example, the population of each state). As you’ll see throughout the book, you can add new variables or modify existing ones using R code. The 52 observations come from the 50 states, as well as the District of Columbia and Puerto Rico. 

## Installing Packages {-}

The `read.csv()` function we’ve been using comes from what is known as *base R*. This is a set of functions that are built into R, and to use them, you can simply enter their function names. However, one of the benefits of R being an open source language is that anyone create their own code and share it with others. R users around the world make what are called *packages*, which provide their own functions to do specific things. 

The best analogy for understanding packages also comes from *Modern Dive*. The functionality in base R is like the features built into a phone. A phone can do a lot on its own. But you usually want to install additional apps to do specific things. Packages are like apps, giving you specific functionality that doesn’t come built into base R. In Chapters \@ref(custom-theme-chapter) and \@ref(packages-chapter), you’ll create your own R package.

You can install packages using the `install.packages()` function. For example, to install the `tidyverse` package, which provides a range of functions for data import, cleaning, analysis, visualization, and more, enter `install.packages("tidyverse")`. Typically, you’ll enter package installation code in the console rather than in a script file because you need to install a package only once on your computer to access its code in the future.

To confirm that the `tidyverse` package has been installed correctly, click the **Packages** tab on the bottom right panel in R Studio. Search for tidyverse, and you should see it pop up, as in Figure \@ref(fig:tidyverse-installed).



\begin{figure}
\includegraphics[width=1\linewidth]{assets/tidyverse-installed} \caption{Confirmation that the tidyverse package is installed on my computer}(\#fig:tidyverse-installed)
\end{figure}



Now that you’ve installed `tidyverse`, let’s use it. While you need to install packages only once per computer, you need to *load* packages each time you restart RStudio by running `library(tidyverse)`. Return to the *sample-code.R* file and re-import your data using a function from the tidyverse package:


```r
library(tidyverse)

population_data_2 <- read_csv(file = "/Users/davidkeyes/Documents/population-by-state.csv")
```

At the top of the script, load the `tidyverse`. Then, use the package’s `read_csv()` function to import the data. Note the underscore (`_`) in place of the period (`.`) in the function’s name; this is a different function from one we used earlier. Using this alternate function to import CSV files achieves the same goal of creating an object, in this case one called `population_data_2`. If you enter `population_data_2` in the console, you should see this output:


```
#> # A tibble: 52 x 9
#>     rank State               Pop  Growth  Pop2018  Pop2010
#>    <dbl> <chr>             <dbl>   <dbl>    <dbl>    <dbl>
#>  1     1 California     39613493  0.0038 39461588 37319502
#>  2     2 Texas          29730311  0.0385 28628666 25241971
#>  3     3 Florida        21944577  0.033  21244317 18845537
#>  4     4 New York       19299981 -0.0118 19530351 19399878
#>  5     5 Pennsylvania   12804123  0.0003 12800922 12711160
#>  6     6 Illinois       12569321 -0.0121 12723071 12840503
#>  7     7 Ohio           11714618  0.0033 11676341 11539336
#>  8     8 Georgia        10830007  0.0303 10511131  9711881
#>  9     9 North Carolina 10701022  0.0308 10381615  9574323
#> 10    10 Michigan        9992427  0.0008  9984072  9877510
#> # i 42 more rows
#> # i 3 more variables: growthSince2010 <dbl>, Percent <dbl>,
#> #   density <dbl>
```

This data looks slightly different from the data we generated using the `read.csv()` function. For example, R shows us only the first 10 rows. This variation occurs because `read_csv()` imports the data not as a data frame but as a data type called a *tibble*. Both are used to describe *rectangular* data like that you would see in a spreadsheet. There are some small differences between data frames and tibbles, the most important of which is that tibbles will print only the first 10 rows by default, while data frames print all rows. For the purposes of this book, we can use the terms interchangeably. 

## RStudio Projects {-}

So far, we’ve imported a CSV file from the *Documents* folder. But the path to the file on my computer was */Users/davidkeyes/Documents/population-by-state.csv*. Because others won’t have this exact location on their computer, my code won’t work if they try to run it. There is a solution to this problem called *RStudio projects*.

By working in a project, you can use what are known as *relative paths* to your files instead of having to write the entire filepath when calling a function to import data. If you place the CSV file in your project, anyone can open it by using the file’s name, as in `read_csv(file = "population-by-state.csv")`. This makes the path easier to write and enables others to use your code.

To create a new RStudio project, go to **File > New Project**. Select either New Directory or Existing Directory and choose where to put your project. If you choose New Directory, you’ll need to specify that you want to create a new project. Do this, then choose a name for the new directory and where it should live. Leave the checkboxes that ask about creating a git repository and using `renv` unchecked. These are for more advanced purposes. 

Having created this project, you should now see two major differences in RStudio’s appearance. First, the Files pane no longer shows every file on your computer. Instead, it shows only files in the *example-project* directory. Right now, that’s just the *example-project.Rproj* file, which indicates that the folder contains a project. Second, at the top right of RStudio, you can see the name of the example-project project. This label had previously read `Project: (None)`. If you want to make sure you’re working in a project, check for its name here. Figure \@ref(fig:rstudio-active-project) shows these changes.



\begin{figure}
\includegraphics[width=1\linewidth]{assets/rstudio-active-project} \caption{RStudio with an active project}(\#fig:rstudio-active-project)
\end{figure}



Now that you’ve created a project, use your operating system’s filesystem to manually copy the *population-by-state.csv* file into the *example-project* directory. Once you’ve done this, you should see it in the RStudio files pane.

With this CSV file in your project, you can now import it more easily. As before, start by loading the `tidyverse` package. After that, remove the reference to the *Documents* folder and import your data by simply using the name of the file:


```r
library(tidyverse)

population_data_2 <- read_csv(file = "population-by-state.csv")
```

You’re able to import the *population-by-state.csv* file in this way because the RStudio project sets the working directory to be the root of your project. With the working directory set in this way, all references to files are relative to the *.Rproj* file at the root of the project. Now anyone can run this code because it imports the data from a location that is guaranteed to exist on their computer.

## Data Analysis with the Tidyverse {-}

Now that we’ve imported data, let’s do a bit of analysis on it. While I’ve been referring to the `tidyverse` as a single package, it is actually a collection of packages for performing data importing, analysis, visualization, and more. We’ll explore several of its functions throughout this book, but this section introduces you to its basic workflow.

### Tidyverse Functions {-}

Because we’ve loaded the `tidyverse` package, we can access its functions. The following code calculates the mean population of all states using the `summarize()` function from the `tidyverse`:


```r
summarize(.data = population_data_2,
          mean_population = mean(Pop))
```

To understand what is happening here, you need to understand two functions: `mean()` and `summarize()`. The `mean()` function calculates the mean of a set of values. If I were to write `mean(c(1, 3, 5))`, R would return `3` because that is the mean of the values `1`, `3`, and `5`. The `c()` function that surrounds the values tells R to combine these values when calculating the mean.

The `summarize()` function takes a data frame or tibble and calculates a summary of one or more variables. In the previous code, we use the `summarize()` function to calculate the mean population of all states. To do this, we pass `population_data_2` to the `.data` argument of the `summarize()` function to tell it to use that data frame. Next, we create a new variable called `mean_population` and assign it to the output of the `mean()` function run on the `Pop` variable (one of the variables in the `population_data_2` data frame). 

Running this code should return a tibble with a single variable (`mean_population`) that is of type double (meaning numeric data) and has a value of `6433422`, the mean population of all states:


```
#> # A tibble: 1 x 1
#>   mean_population
#>             <dbl>
#> 1        6433422.
```

This is a basic example of data analysis, but you can do a lot more with the `tidyverse`.

### The Tidyverse Pipe

One advantage of working with the `tidyverse` is that it uses what’s known as the `pipe` for multi-step operations. The `tidyverse` pipe, which is written as `%>%`, allows us to break steps into multiple lines. For example, we could rewrite our code using the pipe:


```r
population_data_2 %>% 
  summarize(mean_population = mean(Pop))
```

This code says, "Start with the `population_data_2` data frame, then run the `summarize()` function on it, creating a variable called `mean_population` by calculating the mean of the `Pop` variable."

The pipe becomes even more useful when we use multiple steps in our data analysis. Let’s say, for example, we want to calculate the mean population of the five largest states. The following code adds a line that uses the `filter()` function (also from the `tidyverse`) to include only states where the `rank` variable (which is the rank of the total population size of all states) is less than or equal to five. Then, it uses `summarize()` function, as we did before:


```r
population_data_2 %>% 
  filter(rank <= 5) %>% 
  summarize(mean_population = mean(Pop))
```

Running this code shows us the mean population of the five largest states:


```
#> # A tibble: 1 x 1
#>   mean_population
#>             <dbl>
#> 1        24678497
```

Combining functions using the pipe lets us do multiple things to our data in a way that keeps our code readable and easy to understand. 

We’ve introduced only two functions for analysis at this point, but the `tidyverse` has many more functions that enable you to do nearly anything you could hope to do with your data. *R for Data Science* by Hadley Wickham, Mine Çetinkaya-Rundel, and Garrett Grolemund is the bible of tidyverse programming and worth reading for more details on how its many packages work. Because of how useful it is, the `tidyverse` will appear in every single piece of R code you write in this book.

## Comments {-}

In addition to code, R script files often contain comments. In R script files, lines with hashes (`#`) at the start are not treated as code, but as text comments. For example, I could add a comment to the code above like so:


```r
# Calculate the mean population of the five largest states

population_data_2 %>% 
  filter(rank <= 5) %>% 
  summarize(mean_population = mean(Pop))
```

Having this comment will help yourself and others understand what is happening in the code. 

## How to Get Help {-}

Now that you’ve learned about the basics of how R works, you’re probably ready to dive in and write some code. When you do, though, you’re going to encounter errors. Learning how to get help when you run into issues is a key part of learning to use R successfully. There are two main strategies you can use to get unstuck.

The first is to read the documentation for the functions you use. To access the documentation for any function, simply enter `?` and then the name of the function in the console. For example, run `?read.csv` to see documentation about that function pop up in the bottom right panel, as in Figure \@ref(fig:readcsv-documentation).



\begin{figure}
\includegraphics[width=1\linewidth]{assets/readcsv-documentation} \caption{The documentation for the `read.csv()` function}(\#fig:readcsv-documentation)
\end{figure}



Help files can be a bit hard to decipher, but at their core, they tell you what package the function comes from, what it does, what arguments it accepts, and some examples of how to use it. For additional guidance on reading documentation, I recommend the appendix of Kieran Healy’s book *Data Visualization: A Practical Introduction*. A free online version is available at https://socviz.co/appendix.html.

In addition to providing help files in RStudio, many R packages have documentation websites. These can be easier to read than R Studio’s help files. In addition, they often contain longer articles known as *vignettes* that provide an overview of how a given package works. Reading these can help you understand how to combine individual functions in the context of a larger project. Every package discussed in this book has a good documentation website.

## Conclusion {-}

This chapter should have helped you get started with R programming. You’ve learned a number of things, beginning with how to download and set up R and RStudio, what the various RStudio panels are for, and how R script files work. You also learned how to import CSV files and explore them in R, how to save data as objects, and how to install packages to access additional functions. Then, to make the files used in your code more accessible, you created an RStudio project.

Lastly, we covered the basics of data exploration with `tidyverse` functions and the `tidyverse` pipe, and you learned how to get help when those functions don’t work as expected. Now that you understand the basics, you can use R to work with your data. Let’s get started!

## Learn More {-}

Consult the following resources to learn more about R programming:

*Statistical Inference via Data Science: A ModernDive into R and the Tidyverse* by Chester Ismay and Albert Y. Kim (CRC Press, 2020), https://moderndive.com/

The *Getting Started with R* course: https://rfortherestofus.com/courses/getting-started/


