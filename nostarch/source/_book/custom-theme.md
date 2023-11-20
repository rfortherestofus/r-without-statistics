---
output: html_document
editor_options: 
  chunk_output_type: console
---



# Making Your Own Theme {#custom-theme-chapter}

A custom theme is nothing more than a chunk of code that applies a set of small tweaks to all plots. So much of the work involved in making a professional chart consists of these adjustments. What font should you use? Where should the legend go? Should axes have titles? Should charts have grid lines? These questions may seem minor, but they have a big impact on the final product. 

In 2018, BBC data journalists Nassos Stylianou and Clara Guibourg, along with their team, developed a custom ggplot theme that matches the BBC’s style. By introducing this `bbplot` package for others to use, they changed their organization’s culture, removed bottlenecks, and allowed the BBC to visualize data more creatively.

Rather than forcing everyone to copy the long code to tweak each plot they make, custom themes enable everyone who uses them to follow style guidelines and ensures that all data visualization meets a brand’s standards. For example, to understand the significance of the custom theme introduced at the BBC, it’s helpful to know how things worked before `bbplot`. In the mid-2010s, journalists who wanted to make data visualization had two choices:

1.	They could use an internal tool. This tool could create data visualizations but was limited to the predefined charts it had been designed to generate.

2.	They could use Excel to create mockups and then work with a graphic designer to finalize the charts. This approach led to better results, and was way more flexible, but required extensive, time-consuming back-and-forth with a designer. 

Neither of these choices was ideal, and they limited the BBC’s data visualization output. R freed the journalists from having to work with a designer. It wasn’t that the designers were bad (they weren’t), but ggplot allowed the journalists to explore different visualizations on their own. As the team improved their ggplot skills, they realized that it might be possible to produce more than just exploratory data visualizations and create production-ready charts in R that could go straight onto the BBC website.

In this chapter, we discuss the power of custom ggplot themes, then walk through the code in the `bbplot` package to demonstrate how custom themes work. You’ll learn how to consolidate your styling code into a reusable function and how to consistently modify your plots’ text, axes, grid lines, background, and other elements.

## Using a Custom Theme to Style a Plot {-}

The bbplot package has two functions: `bbc_style()` and `finalise_plot()`. The latter deals with things like adding the BBC logo and saving plots in the correct dimensions. For now, let’s look at the `bbc_style()` function, which applies a custom ggplot theme to any plot, making all plots look consistent and follow BBC style guidelines.

### Creating an Example Plot {-}

To show how this function works, let’s create a plot. We’ll do so using the `palmerpenguins` package, which contains data about penguins living on three islands in Antarctica. To give you a sense of what this data looks like, load the `palmerpenguins` and `tidyverse` packages:


```r
library(palmerpenguins)
library(tidyverse)
```

We now have data that we can work with in an object called `penguins`. Here's what the first ten rows look like.


```
#> # A tibble: 344 × 8
#>    species island    bill_length_mm bill_depth_mm
#>    <fct>   <fct>              <dbl>         <dbl>
#>  1 Adelie  Torgersen           39.1          18.7
#>  2 Adelie  Torgersen           39.5          17.4
#>  3 Adelie  Torgersen           40.3          18  
#>  4 Adelie  Torgersen           NA            NA  
#>  5 Adelie  Torgersen           36.7          19.3
#>  6 Adelie  Torgersen           39.3          20.6
#>  7 Adelie  Torgersen           38.9          17.8
#>  8 Adelie  Torgersen           39.2          19.6
#>  9 Adelie  Torgersen           34.1          18.1
#> 10 Adelie  Torgersen           42            20.2
#> # ℹ 334 more rows
#> # ℹ 4 more variables: flipper_length_mm <int>,
#> #   body_mass_g <int>, sex <fct>, year <int>
```

To get our data in a more usable format, let’s count how many penguins live on each island. We do this with the `count()` function from the `dplyr` package (one of several packages that are loaded when we load the `tidyverse`): 



This gives us some simple data that we can use for plotting below.


```
#> # A tibble: 3 × 2
#>   island        n
#>   <fct>     <int>
#> 1 Biscoe      168
#> 2 Dream       124
#> 3 Torgersen    52
```

Because we’ll use this data multiple times in the chapter, let’s save it as an object called `penguins_summary`:


```r
penguins_summary <- penguins %>%
  count(island)
```

Now that we’ve got some data to work with, we’re ready to create a plot. Before showing what `bbplot` does, let’s make our plot with the ggplot defaults. Here is the code we’ll use: 



We use our `penguins_summary` data frame, putting the island on the x axis and the count of the number of penguins (`n`) on the y axis, and making each bar a different color with the `fill` aesthetic property. We’ll modify this plot multiple times, so to simplify this process, we save it as an object called `penguins_plot`. Figure \@ref(fig:basic-penguins-plot-plot) shows the resulting plot.

[F03001.pdf]

![(\#fig:basic-penguins-plot-plot)A chart with the default theme](custom-theme_files/figure-docx/basic-penguins-plot-plot-1.png){width=100%}



It isn’t the most aesthetically pleasing chart. The gray background is ugly, the y axis title is hard to read because it’s angled, and the text size overall is quite small. But don’t worry: we’ll be improving it soon!

### Applying the `bbc_style()` Function {-}  

Now that we have a basic plot to work with, let’s make it look like a BBC chart. To do this, we must install the bbplot package. First, install the remotes package using `install.packages("remotes")`. From there, you can run the following code to install `bbplot`.


```r
library(remotes)
install_github("bbc/bbplot")
```

Once the bbplot package is installed, we can then apply the bbc_style() function to our penguins_plot:


```r
library(bbplot)

penguins_plot +
  bbc_style()
```

Take a look at what happens in Figure \@ref(fig:penguins-bbc-style-plot) with the application of bbc_style() to our plot.

[F03002.pdf]

![(\#fig:penguins-bbc-style-plot)The same chart with BBC style](custom-theme_files/figure-docx/penguins-bbc-style-plot-1.png){width=100%}



Way different, right? The font size is larger, the legend is on top, there are no axis titles, the grid lines are stripped down, and there is a white background. These are the major changes that the `bbc_style()` function makes. Let’s look at them one by one.

## Breaking Down the Custom Theme {-}

This section walks through the code for the `bbc_style()` function (taken from the `bbplot` GitHub repository at https://github.com/bbc/bbplot, with some minor tweaks for readability). We’ll discuss functions more in Chapter \@ref(packages-chapter).

### Setting Up {-}

The first line gives the function a name and indicates that what follows is, in fact, a function definition:


```r
bbc_style <- function() {
  font <- "Helvetica"
  
  ggplot2::theme(
```



We then define a variable called `font` and assign it the value Helvetica. This allows later sections to simply write `font` rather than repeating Helvetica over and over again. Also, if the BBC team ever wanted to use a different font, they could change Helvetica to, say, Comic Sans and update the font of all BBC plots (though I suspect higher-ups at the BBC might not be on board).

Until recently, working custom fonts in R was notoriously tricky. However, recent changes have made the process much simpler. To ensure that custom fonts such as Helvetica work in ggplot, follow these steps. First, install two packages. `systemfonts` and `ragg`, by running this code in the console:


```r
install.packages(c("systemfonts", "ragg"))
```

The `systemfonts` package allows R to directly access fonts you’ve installed on your computer, while `ragg` allows ggplot to use these fonts when generating plots. 

Second, select **Tools** > **Global Options**. Click the **Graphics** menu at the top of the interface, and under the Backend option, select **AGG**. This change should ensure that RStudio renders the previews of any plots with the `ragg` package. With these changes in place, you should be able to use any fonts you’d like (assuming you have them installed) in the same way that the `bbc_style()` function uses Helvetica.

After specifying the font to use, we call the `ggplot2` package’s `theme()` function. Rather than first loading the package with the code `library(ggplot2)` and then using its function, we use the syntax `ggplot2::theme()`, indicating that the `theme()` function comes from the `ggplot2` package. We write code in this way when making an R package, something we’ll discuss in Chapter \@ref(packages-chapter).

Nearly all of the code in the `bbc_style()` function exists within this `theme()` function. Remember from Chapter \@ref(data-viz-chapter) that `theme()` makes additional tweaks to an existing theme; it isn’t a complete theme like `theme_light()`, which will change the whole look-and-feel of your plot. In other words, by jumping straight into the `theme()` function, `bbc_style()` makes tweaks to the ggplot defaults. 

As you’ll see, the `bbc_style()` function does a lot of tweaking. Let’s go through the changes it makes, section by section.

### Text Formatting {-}

The first code section within the theme() function formats the text: 



To make changes to the title, subtitle, and caption, it uses using the following pattern:


```r
AREA_OF_CHART = ELEMENT_TYPE(
  PROPERTY = VALUE
)
```

For each area, we say what type of element it is: `element_text()`, `element_line()`, `element_rect()`, or `element_blank()`. Within the element type, we give values to properties. This can be, say, setting the font family (the property) to Helvetica (the value).

One of the main things the `bbc_style()` function does is bump up the text size. Increasing font size helps with legibility, especially when plots made using the `bbplot` package are viewed on smaller mobile devices. The code first formats the title (with `plot.title`) using Helvetica 28-point bold font in a nearly black color (that’s the hex code #222222). The subtitle (using `plot.subtitle`) is 22-point Helvetica. 

We add some spacing between the title and subtitle using the `margin()` function, which gives the spacing, in points, for the top (9), right (0), bottom (9), and left (0) sides. Finally, the caption (through the `plot.caption` argument) is removed using the `element_blank()` function. This is done because the `finalise_plot()` function in the `bbplot` package adds elements, including a caption and the BBC logo, to the bottom of plots. Figure \@ref(fig:penguins-plot-text-formatting-plot) shows these changes.

[F03003.pdf]

![(\#fig:penguins-plot-text-formatting-plot)The penguin chart with only the text formatting changed](custom-theme_files/figure-docx/penguins-plot-text-formatting-plot-1.png){width=100%}



With these changes in place, we’re on our way toward the BBC look. Let’s now tweak the legend.

### Legend Formatting {-}

Next, we format the legend, putting it on top of the plot and left-aligning the text within it: 


```r
legend.position = "top",
legend.text.align = 0,
legend.background = element_blank(),
legend.title = element_blank(),
legend.key = element_blank(),
legend.text = element_text(
  family = font,
  size = 18,
  color = "#222222"
),
```

We remove the legend background (which would show up only if the background color of the entire plot were different), the title, and the legend key (the borders on the red, green, and blue boxes that show the island names). Finally, we make the legend’s text 18-point Helvetica with the same nearly black color. We can see the result in Figure \@ref(fig:penguins-plot-legend-plot).

[F03004.pdf]

![(\#fig:penguins-plot-legend-plot)Our chart with changes to the legend](custom-theme_files/figure-docx/penguins-plot-legend-plot-1.png){width=100%}



The legend is looking better, but now we need to format the rest of the chart so it matches.

### Axis Formatting {-}

Next are the axes. The code first removes axis titles because these tend to take up a lot of chart real estate, and you can use the title and subtitle to make it clear what the axes show. 


```r
axis.title = ggplot2::element_blank(),
axis.text = ggplot2::element_text(
  family = font,
  size = 18,
  color = "#222222"
),
axis.text.x = ggplot2::element_text(margin = ggplot2::margin(5, b = 10)),
axis.ticks = ggplot2::element_blank(),
axis.line = ggplot2::element_blank(),
```


All text on the axes becomes 18-point Helevetica and nearly black. The text on the x axis (in our case, Biscoe, Dream, and Torgersen) gets a bit of spacing around it. Finally, we remove both axis ticks and axis lines. We can see the changes to the axes in Figure \@ref(fig:penguins-plot-axes-plot).

[F03005.pdf]

![(\#fig:penguins-plot-axes-plot)Our chart with changes to axis formatting](custom-theme_files/figure-docx/penguins-plot-axes-plot-1.png){width=100%}



With the axis text now matching the legend text, and the axis ticks and lines removed, we’re ready to deal with the grid lines.

### Grid Lines Formatting {-}

Now that we’ve tweaked the overall text formatting, the legend, and the axes, let’s move onto grid lines. The approach here is fairly straightforward: remove all minor grid lines and the major grid lines on the x axis, keeping only major grid lines on the y axis, but making them a light gray (using the #cbcbcb hex code).


```r
panel.grid.minor = ggplot2::element_blank(),
panel.grid.major.y = ggplot2::element_line(color = "#cbcbcb"),
panel.grid.major.x = ggplot2::element_blank(),
```

We can see the result of these tweaks to the grid lines in Figure \@ref(fig:penguins-plot-gridlines-plot).

[F03006.pdf]

![(\#fig:penguins-plot-gridlines-plot)Our chart with tweaks to the grid lines](custom-theme_files/figure-docx/penguins-plot-gridlines-plot-1.png){width=100%}



### Background Formatting {-}

The previous iteration of our plot still had a gray background. The `bbc_style()` function removes this with the following code.


```r
panel.background = ggplot2::element_blank(),
```

The plot without the gray background is seen in Figure \@ref(fig:penguins-plot-no-bg).

[F03007.pdf]

![(\#fig:penguins-plot-no-bg)Our chart with the gray background removed](custom-theme_files/figure-docx/penguins-plot-no-bg-1.png){width=100%}



We’ve nearly recreated the penguin plot using the `bbc_style()` function. There is just one more tweak to go.

### Small Multiples Formatting {-}

The function contains a bit more code, to modify `strip.background` and `strip.text`. These elements become relevant in small multiples charts like the one discussed in Chapter \@ref(data-viz-chapter). Let’s turn our penguin chart into a small multiples chart to see these components of the BBC’s theme. I’ve used the code from the `bbc_style()` function, minus the sections that deal with small multiples, to make Figure \@ref(fig:penguin-facetted-plot). 


[F03008.pdf]

![(\#fig:penguin-facetted-plot)Small multiples chart with no changes to the strip text formatting](custom-theme_files/figure-docx/penguin-facetted-plot-1.png){width=100%}



When we use the `facet_wrap()` function to make a small multiples chart, we are left with one chart per island. But note that, by default, the text above each chart is noticeably smaller than the rest of the chart. What’s more, the gray background behind the text stands out when we have removed the gray background from other parts of the chart. The consistency we’ve worked toward is now gone, with small text that is out of proportion to the other text in the chart and a gray background that sticks out like a sore thumb. 

The following code changes the text that shows up above each small multiples chart (called the *strip* in ggplot): 




```r
penguins_plot_weight +
  theme(
    strip.background = element_rect(fill = "white"),
    strip.text = element_text(size = 17, hjust = 0, face = "bold")
  )
```

We remove the background (or, more accurately, color it white). Then we make the text larger, bold, and left aligned using `hjust = 0`. I did have to make the text size slightly smaller to fit in the book and added code to make it bold. You can see the result in Figure \@ref(fig: penguins-plot-facetted-bbc-plot).

[F03009.pdf]

![(\#fig:penguins-plot-facetted-bbc-plot)Small multiples chart in the BBC style](custom-theme_files/figure-docx/penguins-plot-facetted-bbc-plot-1.png){width=100%}



If you take a look at any chart on the BBC website, you’ll see how similar it looks to ours. The tweaks in the `bbc_style()` function (to the text formatting, legends, axes, grid lines, and backgrounds) show up in charts seen by millions on the BBC.

## What About Colors? {-}

You might be thinking: Wait, what about the color of the bars? Doesn’t the theme change those? It’s a common point of confusion, but the answer is that it doesn’t. If we read the documentation for the `theme()` function, it becomes clearer why this is the case: "Themes are a powerful way to customize the non-data components of your plots: i.e. titles, labels, fonts, background, gridlines, and legends." In other words, ggplot themes change the elements of the chart that aren’t mapped to data.

Plots, on the other hand, use color to communicate information about data. In our small multiples chart, for instance, the fill property is mapped to the island (Biscoe is salmon, Dream is green, and Torgersen is blue). As we saw in Chapter \@ref(data-viz-chapter), we can change the fill using the various `scale_fill_` functions. In the world of ggplot, these `scale_` functions control color, while the custom themes control the overall look-and-feel of charts.

## Conclusion {-}

When Stylianou and Guibourg started developing a custom theme for the BBC, they had one question: Would they be able to create graphs in R that could go directly onto the BBC website? Using ggplot, they succeeded. The `bbplot` package allowed them to make plots with a consistent look-and-feel that followed BBC standards and, most importantly, did not need help from a designer.

You can see many of the principles of high-quality data visualization discussed in Chapter \@ref(data-viz-chapter) in this custom theme. In particular, the removal of extraneous elements (axis titles and grid lines, for instance) helps keep the focus on the data itself. And because applying the theme requires users to add only a single line to their ggplot code, it became simple to get others on board. Users had only to append `bbc_style()` to their code to produce a BBC-style plot.

Over time, others at the BBC noticed the data journalism team’s production-ready graphs and wanted to make their own. The team members set up R trainings for their colleagues and developed a "cookbook" (found at https://bbc.github.io/rcookbook/) that showed how to make various types of charts. Soon, the quality and quantity of BBC’s data visualization exploded. Stylianou told me, "I don’t think there’s been a day where someone at the BBC hasn’t used the package to produce a graphic." 

Now that you’ve seen how custom ggplot themes work, try making one of your own. After all, once you’ve written the code, you can apply it with only one line of code.

## Learn More {-}

Consult the following resources to learn more about how the BBC created and used their custom theme:

BBC Visual and Data Journalism cookbook for R graphics (2019), https://bbc.github.io/rcookbook/

"How the BBC Visual and Data Journalism team works with graphics in R" by the BBC Visual and Data Journalism team (2019), https://medium.com/bbc-visual-and-data-journalism/how-the-bbc-visual-and-data-journalism-team-works-with-graphics-in-r-ed0b35693535

