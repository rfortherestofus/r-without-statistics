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

---
output: html_document
editor_options: 
  chunk_output_type: console
---



# Make Your Own Theme

In 2017, BBC data journalist Nassos Stylianou was working with a backend developer on a particularly large data set. Nassos was primarily an Excel user at the time, but this data was too large for Excel. Seeing the developer work through the data with ease, a light bulb went off for Stylianou: if he and his data journalism team learned to use R, they could do this type of analysis on their own. 

This realization began a journey into R. This journey, which started with needing to analyze data too large for Excel to handle, would ultimately end up in a very different place. In 2018, Stylianou, his colleague Clara Guibourg, and their team created a custom ggplot theme to create plots that match the BBC style. The code in the `bbplot` package is a great example of the value of developing a custom theme. But the real story of the creation of `bbplot` is not just about technical tools. Through learning R and creating a custom theme for others to use, Nassos, Clara and their colleagues would change the culture, remove bottlenecks, and allow the BBC to be more creative with their data viz.

To understand how big these changes were, it's helpful to understand what things looked like at the BBC before bbplot. In the mid-2010s, journalists at the BBC who wanted to make data visualization had two choices:

1. They could use an internal tool. This tool could create data visualization, but only the predefined charts it had been designed to generate. 

1. They could use Excel to create mockups and then work with a graphic designer to finalize the charts. This approach led to better results, and was way more flexible, but required extensive back-and-forth with a designer. As Stylianou described it, working with a designer "is just a very time consuming workflow if you think of how many visualizations the BBC does." 

Neither of these choices was ideal. And this limited set of less-than-ideal choices led to a limited output of data viz.   

That would all change when Stylianou, Guibourg, and their colleagues realized that R, the tool they had decided to learn for data analysis, could also do data visualization. As they began playing around with ggplot, they quickly saw its power. Guibourg said she found it "immediately addictive when I started working with ggplot to make charts." No longer limited by the BBC's inflexible internal tool, she found that ggplot was "completely flexible in a way that was just completely new to me." 

The biggest change, though, came from not having to work with a designer. Not because the designers were bad (they weren't), but because ggplot allowed the BBC data journalists to explore different visualizations on their own. Working with a designer required the journalists to have a fully-formed idea that the designer could take and improve upon. Working in ggplot allowed BBC data journalists to explore different data viz ideas. 

Clara Guibourg believes this freedom is what explains the addictive quality of ggplot. As she told me, "even before we got anywhere near having a production-ready chart, just trying things out, visualizing things for the first time" was completely captivating. Having learned the basics of ggplot, she saw that "you can make like the simplest chart with just a couple of lines of code." Being able to explore different types of visualization on her own led Clara and others to produce more  data viz than they had previously. 

As the BBC data journalism team improved their ggplot skills, they realized that it might be possible produce for more than just exploratory data viz. They had learned to use R for data analysis and they were starting to use it for exploratory data visualization. Could they go all the way and create production-ready charts in R that could go straight onto the BBC website? 

Stylianou, Guibourg, and their colleagues set about looking into what would be involved in creating production-ready charts from R. They realized that so much of this work involved small tweaks. What font should they use? Where should the legend go? Should axes have titles? Should charts have grid lines? These questions may seem small but they have a big impact. Having consistent answers to them is what enabled BBC designers to turn Excel mockups into high-quality data viz ready to go on the website. As the BBC data journalism team dug further into ggplot, they realized that they might be able to write code to make their data viz production-ready. They realized that, if making production-ready charts required asking question about fonts, legends, axes, and grid lines, ggplot had the answer. And the answer was to make a custom theme. 

## Enter bbplot {-}

Take a look at this 2019 plot that Stylianou, Guibourg, and their colleague  Helen Briggs made for an article on the carbon footprint of various food items. It's got a distinctive look, with the same minimalist aesthetic we saw in Chapter \@ref(data-viz-chapter). 



<div class="figure">
<img src="assets/bbc-food-chart.png" alt="BBC chart showing carbon impact of various foods" width="100%" />
<p class="caption">(\#fig:bbc-beef-chart)BBC chart showing carbon impact of various foods</p>
</div>



This plot was made using the `bbplot` package. To show how this works, let's create our own plot. We'll do so using the `palmerpenguins` package, which has data on penguins living on three islands in Antarctica. To give you a sense of what this data looks like, let's load the `palmerpenguins` and `tidyverse` packages.


```r
library(palmerpenguins)
library(tidyverse)
```

We now have data that we can work with in an object called `penguins`. Here's what the first ten rows look like.



To get our data in a more usable format, let's count how many penguins live on each island. We do this with the `count()` function from the `dplyr` package (one of several packages that are loaded when we load the `tidyverse`).



This gives us some simple data that we can use for plotting below.


```
#> # A tibble: 3 × 2
#>   island        n
#>   <fct>     <int>
#> 1 Biscoe      168
#> 2 Dream       124
#> 3 Torgersen    52
```

Because we're going to use this data multiple times below, let's save it as an object called `penguins_summary`.


```r
penguins_summary <- penguins %>%
  count(island)
```

Now that we've got some data to work with, we're ready to create a plot. Before showing what `bbplot` does, let's make a plot with ggplot defaults. Here is the code we'll use. We're using our `penguins_summary` data frame, putting the island on the x axis, the count of the number of penguins (n) on the y axis, and making each bar a different color with the fill aesthetic property. 



The resulting plot, seen in Figure \@ref(fig:basic-penguins-plot-plot), isn't the most aesthetically pleasing chart, but we'll be improving it soon!



<div class="figure">
<img src="custom-theme_files/figure-html/basic-penguins-plot-plot-1.png" alt="A chart with the default theme" width="100%" />
<p class="caption">(\#fig:basic-penguins-plot-plot)A chart with the default theme</p>
</div>



We're going to use this plot multiple times (with some modifications each time). To simplify things, let's save it as an object called `penguins_plot`. 


```r
penguins_plot <- ggplot(
  data = penguins_summary,
  aes(
    x = island,
    y = n,
    fill = island
  )
) +
  geom_col() +
  labs(
    title = "Number of Penguins",
    subtitle = "Islands are in Antarctica",
    caption = "Data from palmerpenguins package"
  )
```

### The `bbc_style()` function {-}  

Now that we have a basic plot to work with, let's make it look like a BBC chart. To do this, we load the `bbplot` package. This package has two functions: `bbc_style()` and `finalise_plot()`. The latter deals with things like adding the BBC logo, saving plots in the correct dimensions, and other tasks done after the plot is complete. We'll discuss this a bit more below. For now, let's look at the `bbc_style()` function. This function applies a custom ggplot theme to any plot. We first load the `bbplot` package. Then we apply `bbc_style()` to `penguins_plot`.



Take a look at what happens in Figure \@ref(fig:penguins-bbc-style-plot) with the application of `bbc_style()` to our plot.



<div class="figure">
<img src="custom-theme_files/figure-html/penguins-bbc-style-plot-1.png" alt="The same chart with BBC style" width="100%" />
<p class="caption">(\#fig:penguins-bbc-style-plot)The same chart with BBC style</p>
</div>



Way different, right? Larger font size, legend on top, no axis titles, stripped down grid lines, and a white background – these are the major changes that the `bbc_style()` function makes. Let's look at them one by one. 

Here's the code for the `bbc_style()` function (taken from the `bbplot` GitHub repository, found at https://github.com/bbc/bbplot). You may be a bit confused by the way some of the code is written. This is in part because it is the code used to create a function. The first line gives the function a name (`bbc_style`) and indicates that it is, in fact, a function definition. We'll discuss functions more in Chapter \@ref(functions).

You'll see that instead of loading the package `ggplot2` with the code `library(ggplot2)` and then using the `theme()` function, the code below uses `ggplot2::theme()`. This indicates that the `theme()` function comes from the `ggplot2` package. Writing code in this way is something that is done when making an R package, something we'll discuss in Chapter \@ref(custom-packages).

I've made some minor formatting tweaks for readability. For example, you can see the comments in ALL CAPS, which show the category of modification that the section which follows makes. Fortunately for us, the code is organized nicely and allows us to see what each section does. 

TODO: START HERE BY CHECKING LINE LENGTH


```r
bbc_style <- function() {
  font <- "Helvetica"
  
  ggplot2::theme(
    
    # TEXT FORMAT
    # This sets the font, size, type and colour of text for the chart's title
    plot.title = ggplot2::element_text(
      family = font,
      size = 28,
      face = "bold",
      color = "#222222"
    ),
    # This sets the font, size, type and colour of text for the chart's subtitle,
    # as well as setting a margin between the title and the subtitle
    plot.subtitle = ggplot2::element_text(
      family = font,
      size = 22,
      margin = ggplot2::margin(9, 0, 9, 0)
    ),
    # This leaves the caption text element empty, because it is set elsewhere in the finalise plot function
    plot.caption = ggplot2::element_blank(),
    
    # LEGEND FORMAT
    # This sets the position and alignment of the legend, removes a title and background for it
    # and sets the requirements for any text within the legend.
    # The legend may often need some more manual tweaking when it comes to its exact position based on the plot coordinates.
    legend.position = "top",
    legend.text.align = 0,
    legend.background = ggplot2::element_blank(),
    legend.title = ggplot2::element_blank(),
    legend.key = ggplot2::element_blank(),
    legend.text = ggplot2::element_text(
      family = font,
      size = 18,
      color = "#222222"
    ),
    
    # AXIS FORMAT
    # This sets the text font, size and colour for the axis test, as well as setting the margins and removes lines and ticks.
    # In some cases, axis lines and axis ticks are things we would want to have in the chart - the cookbook shows examples of how to do so.
    axis.title = ggplot2::element_blank(),
    axis.text = ggplot2::element_text(
      family = font,
      size = 18,
      color = "#222222"
    ),
    axis.text.x = ggplot2::element_text(margin = ggplot2::margin(5, b = 10)),
    axis.ticks = ggplot2::element_blank(),
    axis.line = ggplot2::element_blank(),
    
    # GRID LINES
    # This removes all minor gridlines and adds major y gridlines.
    # In many cases you will want to change this to remove y gridlines and add x gridlines.
    # The cookbook shows you examples for doing so.
    panel.grid.minor = ggplot2::element_blank(),
    panel.grid.major.y = ggplot2::element_line(color = "#cbcbcb"),
    panel.grid.major.x = ggplot2::element_blank(),
    
    # BLANK BACKGROUND
    # This sets the panel background as blank, removing the standard grey ggplot background colour from the plot.
    panel.background = ggplot2::element_blank(),
    
    # STRIP BACKGROUND
    # This sets the panel background for facet-wrapped plots to white,
    # removing the standard grey ggplot background colour and sets the title size of the facet-wrap title to font size 22.
    strip.background = ggplot2::element_rect(fill = "white"),
    strip.text = ggplot2::element_text(size = 22, hjust = 0)
  )
}
```

Nearly all of the code in the `bbc_style()` function exists within the `theme()` function from `ggplot2`. In the Chapter \@ref(data-viz), we saw how Cédric Scherer and Georgios Karamanis customized their plot by applying the `theme_light()` function. This a so-called complete theme, meaning you can call the function and will change the whole look-and-feel of your plot. After applying `theme_light()`, Scherer and Karamanis used the `theme()` function make additional tweaks. The `bbc_style()` theme does not use a complete theme to start. Instead, by jumping straight into the `theme()` function, they make tweaks to the ggplot defaults. 

It can be challenging to remember how to tweak different elements in a plot. Fortunately, there are cheatsheets available to help. This one by Clara Granell shows the various elements that you can tweak within the `theme()` function. 

<div class="figure">
<img src="assets/ggplot_theme_system_cheatsheet.png" alt="Cheatsheet for working with ggplot themes" width="100%" />
<p class="caption">(\#fig:ggplot-theme-cheatsheet)Cheatsheet for working with ggplot themes</p>
</div>

As you can see, the `bbc_style()` function does a lot of tweaking. So, let's go through the changes it makes, section by section. 

### Text Formatting {-}

The first section of the code deals with text formatting. First, it defines a variable called "font" and assigns it the value "Helvetica." This allows later sections of code to simply write "font" rather than repeating "Helvetica" over and over again. And, if the team ever wanted to use a different font, they could simply change "Helvetica" to, say, "Comic Sans" and change all BBC plots (I suspect higher-ups at the BBC might not be on board). 


```r
font <- "Helvetica"
```

Subsequent pieces of this section of the code make changes to the title, subtitle, and caption. The pattern used in code to make changes is as follows:


```r
AREA_OF_CHART = ELEMENT_TYPE(
  PROPERTY = VALUE
)
```

We begin by selecting an area of the chart (for example, `plot.title`). Then, we have to say what type of element it is. The options are `element_text()`, `element_line()`, `element_rect()`, and `element_blank()`. We'll deal with the other three later on. For now, we're working with `element_text()` to handle formatting of the title, subtitle, and caption since they're all text elements. Within the element type, we give values to properties. This can be, say, setting the font family (the property) to Helvetica (the value).

One of the main things that the `bbc_style()` function does is to bump up the text size. As Nassos put it to me, on a lot of plots made with ggplot, "font and the numbers are just so small." Increasing font size helps with legibility, especially when plots made using the `bbplot` package are viewed on smaller mobile devices. 

The code first formats the title using Helvetica 28-point bold font in a nearly black color (that's the hex code #222222). The subtitle is 22-point Helvetica. Some spacing is added between the title and subtitle using the `margin()` function, which gives the spacing, in points, for the top (9), right (0), bottom (9), and left (0) sides. Finally, the caption is removed using the `element_blank()` function. This is done because the `finalise_plot()` function in the `bbplot` package adds elements, including a caption and the BBC logo to the bottom of plots. 



We can see these changes in Figure \@ref(fig:penguins-plot-text-formatting) below.



<div class="figure">
<img src="custom-theme_files/figure-html/unnamed-chunk-18-1.png" alt="Our chart with only text formatting changed" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-18)Our chart with only text formatting changed</p>
</div>



We then save our plot as an object in order to work with it in the next section.


```r
penguins_plot_text <- penguins_plot +
  theme(
    plot.title = element_text(
      family = font,
      size = 28,
      face = "bold",
      color = "#222222"
    ),
    plot.subtitle = element_text(
      family = font,
      size = 22,
      margin = margin(9, 0, 9, 0)
    ),
    plot.caption = element_blank()
  )
```

### Legend Formatting {-}

Next, we deal with the legend. The code puts the legend on top of the plot, and left aligns the text within it. Then, it removes the legend background (this would only show up if the background color of the entire plot were different than the legend background), title, and legend key (this is a box that can show up around the boxes with the names of the islands). Finally, we make the legend text 18-point Helevetica with the same nearly black color. 



We can see the result in Figure \@ref(fig:penguins-plot-legend).



<div class="figure">
<img src="custom-theme_files/figure-html/unnamed-chunk-22-1.png" alt="Our chart with changes to the legend" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-22)Our chart with changes to the legend</p>
</div>



And again, we save this plot so we can continue to alter it below.


```r
penguins_plot_legend <- penguins_plot_text +
  theme(
    legend.position = "top",
    legend.text.align = 0,
    legend.background = element_blank(),
    legend.title = element_blank(),
    legend.key = element_blank(),
    legend.text = element_text(
      family = font,
      size = 18,
      color = "#222222"
    )
  )
```

### Axis Formatting {-}

Next up are the axes. The code first removes axis titles because, as Nassos told me, these tend to take up a lot of chart real estate and you can use the title and subtitle to make clear what the axes show. All text on axes becomes 18-point Helevetica nearly black. The text on the x axis (in our case, Biscoe, Dream, and Torgersen) gets a bit of spacing around it. And, finally, both axis ticks and axis lines are removed. 



We can see the changes to our axes in Figure \@ref(fig:penguins-plot-axes).







Let's now save this plot as an object for future tweaks.


```r
penguins_plot_axes <- penguins_plot_legend +
  theme(
    axis.title = element_blank(),
    axis.text = element_text(
      family = font,
      size = 18,
      color = "#222222"
    ),
    axis.text.x = element_text(margin = margin(5, b = 10)),
    axis.ticks = element_blank(),
    axis.line = element_blank()
  )
```

### Grid Lines Formatting {-}

Now that we've tweaked overall text formatting, the legend, and the axes, let's move onto grid lines. The approach here is fairly straightforward: remove all minor grid lines, remove major grid lines on the x axis, keeping only major grid lines on the y axis, but making them a light gray (using the #cbcbcb hex code). 



We can see the result of these tweaks to the grid lines in Figure \@ref(fig:penguins-plot-gridlines).




```r
penguins_plot_axes +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major.y = element_line(color = "#cbcbcb"),
    panel.grid.major.x = element_blank()
  )
```

<div class="figure">
<img src="custom-theme_files/figure-html/unnamed-chunk-30-1.png" alt="Our chart with tweaks to the grid lines" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-30)Our chart with tweaks to the grid lines</p>
</div>



And, once again, we save our plot to an object.



### Background Formatting {-}

Of course, in the previous iteration of our plot, it still had a gray background. The `bbc_style()` function removes this with the following code.



 The plot without the gray background is seen in Figure \@ref(fig:penguins-plot-no-bg)).



<div class="figure">
<img src="custom-theme_files/figure-html/penguins-plot-no-bg-1.png" alt="Our chart with the gray background removed" width="100%" />
<p class="caption">(\#fig:penguins-plot-no-bg)Our chart with the gray background removed</p>
</div>



### Small Multiples Formatting {-}

And there we go! We've now recreated the plot that we made above using the `bbc_style()` function. However, you may recall there is a bit more code in the `bbc_style()` function. This code deals with `strip.background` and `strip.text`. Both of these occur when we make small multiples charts. Small multiples is a common technique in data visualization, where, instead of making one chart that incorporates all of the available data, we break the chart into multiple charts in order to make the final results easier for the reader to comprehend. 

Let's make an example small multiples chart to show what this looks like. I've used the code from the `bbc_style()` function (though I've removed the legend as it's not necessary in this chart). See Figure \@ref(fig:penguin-facetted-plot) below.



<div class="figure">
<img src="custom-theme_files/figure-html/penguin-facetted-plot-1.png" alt="Small multiples chart with no changes to the strip text formatting" width="100%" />
<p class="caption">(\#fig:penguin-facetted-plot)Small multiples chart with no changes to the strip text formatting</p>
</div>



When we use the `facet_wrap()` function, we are left with one chart per island. But note that, by default, the text above each chart is noticeably smaller than the rest of the chart. And the gray background behind the text stands out when we have removed the gray background from other parts of the chart. 



I've saved the code used to make Figure \@ref(fig:penguin-facetted-plot) as an object (`penguins_plot_weight`). We now use this object in order to show how to change the text that shows up above each small multiples chart (in ggplot this text is called the "strip"). We remove the background (or, more accurately, make it white) and make the text larger, bold, and left aligned (using `hjust = 0`). (I did have to make the text size slightly smaller to fit in the book and added code to make it bold, something done in the chart on carbon impact of food chart, though not seen in the `bbc_style()` code.) 



The result shows up in Figure \@ref(fig:penguins-plot-facetted-bbc).



<div class="figure">
<img src="custom-theme_files/figure-html/unnamed-chunk-39-1.png" alt="Small multiples chart in the BBC style" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-39)Small multiples chart in the BBC style</p>
</div>



If we now return to Figure \@ref(fig:bbc-beef-chart), the 2019 carbon impact of food chart that Nassos and Clara made, we can again see how similar it is. All of the tweaks in the `bbc_style()` function (text formatting, legends, axes, grid lines, and backgrounds) are visible. 



<img src="assets/bbc-food-chart.png" width="100%" />



### What About Colors? {-}

You might be thinking: wait, what about the colors? Doesn't the theme change that? It's a common point of confusion. If we read the documentation for the `theme()` function, though, it becomes clearer why this is the case:

> Themes are a powerful way to customize the non-data components of your plots: i.e. titles, labels, fonts, background, gridlines, and legends.

Color is used in plots as an aesthetic property to show something about data. In Figure \@ref(fig:bbc-beef-chart), for instance, color is mapped to the type of carbon impact (emissions, land use, and water use). As we saw in Chapter \@ref(data-viz-chapter), we can change color using the various `scale_` functions. It is because color is tied to the data rather than being about the overall look-and-feel that ggplot themes do not, on their own, change this component of plots. 

## Code is the Catalyst for Culture Change {-}

When Nassos Stylianou and Clara Guibourg started developing a custom theme for the BBC, they had one question: would they be able to create graphs in R that could go straight onto the BBC website? And, wouldn't you know, they succeeded! The creation of the the `bbplot` package allowed them to make plots that had a consistent look-and-feel, followed BBC standards, and, most importantly, did not need help from a designer. 

Many of the principles of high-quality data visualization that we discussed in Chapter \@ref(data-viz-chapter) can be seen in this custom theme. In particular, the removal of extraneous elements (axis titles and grid lines, for instance) helps keep the focus on the data itself. And by creating a custom theme that only requires users to add a single line to their ggplot code, it became simple to get others on board. Telling users they could just append `bbc_style()` to their code and get a BBC-style plot was an eye-opener.

The development of the `bbplot` package would lead to significant changes at the BBC. It inspired Nassos, Clara, and the other data journalists who created it to use ggplot more than before. Knowing that they had the flexibility of ggplot at their fingertips gave them license to explore. And knowing that they did not have to work with a designer to create production-ready graphics empowered them to make more and better graphics.

In addition to the `bbc_style()` function, the `bbplot` package also provides another function (`finalise_plot()`) that adds a source at the bottom of the chart (recall how the `bbc_style()` function removed the caption), adds the BBC logo in the footer, and gives height, width, and file name options for saving the plot. These two functions combined allowed Nassos, Clara, and others to achieve their holy grail: creating production-ready graphs that could go straight from R to the BBC website. 

The impact of `bbplot` would also come to be seen outside of the small team of data journalists that brought it to life. Others at the BBC saw how the data journalism team was now able to produce production-ready graphs and they wanted to do the same. This led the data journalism team to set up R trainings for their colleagues and to develop a "cookbook" (shown in Figure \@ref(fig:bbc-cookbook)) that provided examples of how to make various types of charts. 



<div class="figure">
<img src="assets/bbc-graphics-cookbook.png" alt="Screenshot of BBC graphics cookbook" width="100%" />
<p class="caption">(\#fig:bbc-cookbook)Screenshot of BBC graphics cookbook</p>
</div>



These two resources led to a large increase in R users at the BBC. As Nassos told me, they "spurred people a lot people outside of the data journalism team to take a real interest [in R]." Having `bbplot` made the value of R click for many people at the BBC. He continued:

> There is no, "why am I doing this?" in their mind. It's is worth the pain [to learn R], because it is a pain at first. But seeing this graphic that a few months ago you would have had to do in this old process ... if you devote a bit of time each day, here are the five lines of code that you can run and you can [make a production-ready graphic] yourself.

As so many more people at the BBC came to learn R, the quality and quantity of data visualization produced exploded. Nassos told me, "I don't think there's been a day where someone at the BBC hasn't used the package to produce a graphic." The `bbplot` package came in particularly helpful during COVID. Being able to produce on-brand graphics on a quick turnaround was possible in a way it would not have been previously. 

Reflecting on her experience, Clara attributes the successful transition to R at the BBC to its culture. As she put it, "I think that what helped me get started was that there was a really supportive environment internally at the BBC for learning." And, indeed, this same supportive culture that led Clara to organically explore what R was capable of was reinforced after she and the data journalism team released `bbplot`. The custom theme they developed enabled the creation of so many BBC graphics that otherwise never would have seen the light of day. A culture open to learning led the data journalism team to insights about the power of code. And this code then facilitated a culture change around how graphics are produced at the BBC. 

<!--chapter:end:custom-theme.Rmd-->

# R is a Full-Fledged Map-Making Tool 


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

