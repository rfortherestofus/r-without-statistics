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

---
output: html_document
editor_options: 
  chunk_output_type: console
---





# Principles of Data Visualization {#data-viz-chapter}

In the spring of 2021, nearly all of the American West was in a drought. By April of that year, officials in Southern California had declared a water emergency, citing unprecedented conditions.

This wouldn’t have come as news to those living in California and other Western states.  Drought conditions like those in the West in 2021 are becoming increasingly common. Yet communicating the extent of problem remains difficult. How can we show the data in a way that accurately represents it while making it compelling enough to get people to take notice?
This was the challenge that data-visualization designers Cédric Scherer and Georgios Karamanis took on in the fall of 2021. Commissioned by the magazine *Scientific American* to create a data visualization of drought conditions over the last two decades in the United States, they turned to the ggplot2 package to transform what could have been dry data (pardon the pun) into a visually arresting and impactful graph.

In this chapter, I show how Scherer and Karamanis made their data visualization. We begin by looking at why the data visualization is effective. Next, we talk about the grammar of graphics, a theory to make sense of graphs that underlies the ggplot2 package that Scherer, Karamanis, and millions of others use to make data visualization. We then return to the drought graph, recreating it step-by-step using ggplot2. In the process, we pull out some key principles of high-quality data visualization that you can use to improve your own work.

## The Drought Visualization {-}

There was nothing unique about the data that Scherer and Karamanis used. Other news organizations had relied on the same data, from the National Drought Center, in their stories. But Scherer and Karamanis visualized it in a way that it both grabs attention and communicates the scale of the phenomenon. Figure \@ref(fig:final-viz) shows a section of the final visualization. Showing four regions over the last two decades, the increase in drought conditions, especially in California and the Southwest, is made apparent.





<div class="figure">
<img src="data-viz_files/figure-html/final-viz-1.png" alt="A section of the final drought visualization. If you’re incredibly eagle-eyed, you’ll see a few minor elements that differ from the version published in *Scientific American*. These are things I had to change to make the plots fit in this book (for example, altering the text size and putting legend text on two rows) or things that *Scientific American* added in post-production (such as annotations)." width="100%" />
<p class="caption">(\#fig:final-viz)A section of the final drought visualization. If you’re incredibly eagle-eyed, you’ll see a few minor elements that differ from the version published in *Scientific American*. These are things I had to change to make the plots fit in this book (for example, altering the text size and putting legend text on two rows) or things that *Scientific American* added in post-production (such as annotations).</p>
</div>



To understand why this visualization is effective, let’s break it down into pieces. At the broadest level, the data visualization is notable for its minimalist aesthetic. There are, for example, no grid lines and few text labels, as well as little text along the axes. What Scherer and Karamanis have done is remove what statistician Edward Tufte, in his 1983 book *The Visual Display of Quantitative Information*, calls *chartjunk*. Tufte wrote (and researchers, as well as data visualization designers since, have generally agreed) that extraneous elements often hinder, rather than help, our understanding of charts.

Need proof that Scherer and Karamanis’s decluttered graph is better than the alternative? Figure \@ref(fig:cluttered-viz) shows a version with a few small tweaks to the code to include grid lines and text labels on axes. Prepare yourself for clutter!



<div class="figure">
<img src="data-viz_files/figure-html/cluttered-viz-1.png" alt="The cluttered version of the drought visualization" width="100%" />
<p class="caption">(\#fig:cluttered-viz)The cluttered version of the drought visualization</p>
</div>



Again, it’s not just that this cluttered version looks worse. The clutter actively inhibits understanding. Rather than focus on overall drought patterns (the point of the graph), our brain gets stuck reading repetitive and unnecessary axis text.

One of the best ways to reduce clutter is to break a single chart into what are known as* small multiples*. When we look closely at the data visualization, we see that it is not one chart but actually a set of charts. Each rectangle represents one region in one year. If we filter to show the Southwest region in 2003 and add axis titles, we can see in Figure \@ref(fig:viz-sw-2003) that the x axis shows the week while the y axis shows the percentage of that region at different drought levels.




<div class="figure">
<img src="data-viz_files/figure-html/viz-sw-2003-1.png" alt="A drought visualization for the Southwest in 2003" width="100%" />
<p class="caption">(\#fig:viz-sw-2003)A drought visualization for the Southwest in 2003</p>
</div>




Zooming in on a single region in a single year also makes the color choices more obvious. The lightest bars show the percentage of the region that is abnormally dry while the darkest bars show the percentage in exceptional drought conditions. These colors, as we’ll see shortly, are intentionally chosen to make differences in the drought levels visible to all readers.
When I asked Scherer and Karamanis to speak with me about this data visualization, they initially told me that the code for this piece might be too simple to highlight the power of R for data visualization. No, I told them, I want to speak with you precisely because the code is not super complex. The fact that Scherer and Karamanis were able to produce this complex graph with relatively simple code shows the power of R for data visualization. And it is possible *because* of a theory called the grammar of graphics.


## The Grammar of Graphics {-}

If you’ve used Excel to make graphs, you’re probably familiar with the menu shown in Figure \@ref(fig:excel-chart-chooser). When working in Excel, your graph-making journey begins by selecting the type of graph you want to make. Want a bar chart? Click the bar chart icon. Want a line chart? Click the line chart icon.



<div class="figure">
<img src="assets/excel-chart-chooser.png" alt="The Excel chart chooser menu" width="100%" />
<p class="caption">(\#fig:excel-chart-chooser)The Excel chart chooser menu</p>
</div>




f you’ve only ever made data visualization in Excel, this first step may seem so obvious that you’ve never even considered the process of creating data visualization in any other way. But there are different models for thinking about graphs. Rather than conceptualizing graphs types as being distinct, we can recognize the things that they have in common and use these commonalities as the starting point for making them.

This approach to thinking about graphs comes from the late statistician Leland Wilkinson. For years, Wilkinson thought deeply about what data visualization is and how we can describe it. In 1999, he published a book called *The Grammar of Graphics* that sought to develop a consistent way of describing all graphs. In it, Wilkinson argued that we should think of plots not as distinct types à la Excel, but as following a grammar that we can use to describe *any* plot. Just as English grammar tells us that a noun is typically followed by a verb (which is why “he goes” works, while the opposite, “goes he,” does not), knowledge of the grammar of graphics allows us to understand why certain graph types “work.” 

Thinking about data visualization through the lens of the grammar of graphics allow us to see, for example, that graphs typically have some data that is plotted on the x axis and other data that is plotted on the y axis. This is the case no matter whether the graph is a bar chart or a line chart, for example. Consider Figure \@ref(fig:bar-line-chart), which shows two charts that use identical data on life expectancy in Afghanistan.




<div class="figure">
<img src="data-viz_files/figure-html/bar-line-chart-1.png" alt="A bar chart and a line chart showing identical data on Afghanistan life expectancy" width="100%" />
<p class="caption">(\#fig:bar-line-chart)A bar chart and a line chart showing identical data on Afghanistan life expectancy</p>
</div>



While they look different (and would, to the Excel user, be different types of graphs), Wilkinson’s grammar of graphics allows us to see their similarities. (Incidentally, Wilkinson’s feelings on graph-making tools like Excel became clear when he wrote that “most charting packages channel user requests into a rigid array of chart types.”)

When Wilkinson wrote his book, no data visualization tool could implement his grammar of graphics. This would change in 2010, when Hadley Wickham announced the ggplot2 package for R in an article titled “A Layered Grammar of Graphics.” By providing the tools to implement Wilkinson’s ideas, ggplot2 would come to revolutionize the world of data visualization.

## Working With ggplot2 {-}

The ggplot2 R package (which I, like nearly everyone in the data visualization world, will refer to simply as ggplot) relies on the idea of plots having multiple layers. Let’s walk through some of the most important layers. We’ll begin by selecting variables to map to aesthetic properties. Then we’ll choose a geometric object to use to represent our data. Next we’ll change the aesthetic properties of our chart (the color scheme, for example) using a `scale_` function. And finally we’ll use a `theme_` function to set the overall look-and-feel of our plot.

### The First Layer: Mapping Data to Aesthetic Properties {-}

When creating a graph with ggplot, we begin by mapping data to aesthetic properties. All this really means is that we use things like the x or y axis, color, and size (the so-called aesthetic properties) to represent variables. To make this concrete, we’ll use the data on life expectancy in Afghanistan, introduced in the previous section, to generate a plot. Here’s what this data looks like:


```
#> # A tibble: 10 × 6
#>    country     continent  year lifeExp      pop gdpPercap
#>    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
#>  1 Afghanistan Asia       1952    28.8  8425333      779.
#>  2 Afghanistan Asia       1957    30.3  9240934      821.
#>  3 Afghanistan Asia       1962    32.0 10267083      853.
#>  4 Afghanistan Asia       1967    34.0 11537966      836.
#>  5 Afghanistan Asia       1972    36.1 13079460      740.
#>  6 Afghanistan Asia       1977    38.4 14880372      786.
#>  7 Afghanistan Asia       1982    39.9 12881816      978.
#>  8 Afghanistan Asia       1987    40.8 13867957      852.
#>  9 Afghanistan Asia       1992    41.7 16317921      649.
#> 10 Afghanistan Asia       1997    41.8 22227415      635.
```

If we want to make a chart with ggplot, we need to first decide which variable to put on the x axis and which to put on the y axis. Let’s say we want to show life expectancy over time. That means we would use the variable `year` on the x axis and the variable `lifeExp` on the y axis. To do so, we begin by using the `ggplot()` function: 





Within this function, we tell R that we’re using the data frame `gapminder_10_rows`. This is the filtered version we created from the full `gapminder` data frame, which includes over 1,700 rows of data. The line following this tells R to use `year` on the x axis and `lifeExp` on the y axis. When we run the code, what we get in Figure \@ref(fig:blank-ggplot) doesn’t look like much.



<div class="figure">
<img src="data-viz_files/figure-html/blank-ggplot-1.png" alt="A blank chart" width="100%" />
<p class="caption">(\#fig:blank-ggplot)A blank chart</p>
</div>



But, if you look closely, you can see the beginnings of a plot. Remember that x axis using `year`? There it is! And `lifeExp` on the y axis? Yup, it’s there too. I can also see that the values on the x and y axes match up to our data. In the `gapminder_10_rows` data frame, the first year is 1952 and the last year is 1997. The range of the x axis seems to have been created with this data, which goes from 1952 to 1997, in mind (spoiler: it was). And `lifeExp`, which goes from about 28 to about 42 will fit nicely on our y axis.

### The Second Layer: Choosing the geoms {-}

Axes are nice, but we’re missing any type of visual representation of the data. To get this, we need to add the next layer in ggplot: geoms. Short for geometric objects, geoms are functions that provide different ways of representing data. For example, if we want to add points, we use `geom_point()`: 



Now, in Figure \@ref(fig:gapminder-points), we see that people in 1952 had a life expectancy of about 28 and that this value rose through every year in our data.



<div class="figure">
<img src="data-viz_files/figure-html/unnamed-chunk-17-1.png" alt="The same chart but with points added" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-17)The same chart but with points added</p>
</div>



Let’s say we change our mind and want to make a line chart instead. Well, all we have to do is replace `geom_point()` with `geom_line()`:



Figure \@ref(fig:gapminder-line) shows the result.



<div class="figure">
<img src="data-viz_files/figure-html/unnamed-chunk-20-1.png" alt="The data as a line chart" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-20)The data as a line chart</p>
</div>



To really get fancy, what if we add both `geom_point()` and `geom_line()`? 



This code generates a line chart with points, as seen in Figure \@ref(fig:gapminder-points-line).



<div class="figure">
<img src="data-viz_files/figure-html/unnamed-chunk-23-1.png" alt="The data with points and a line" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-23)The data with points and a line</p>
</div>



We can extend this idea further, as seen in Figure \@ref(fig:gapminder-bar), swapping in `geom_col()` to create a bar chart:



Note that the y axis range has been automatically updated, going from 0 to 40 to account for the different geom.



<div class="figure">
<img src="data-viz_files/figure-html/unnamed-chunk-26-1.png" alt="The data as a bar chart" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-26)The data as a bar chart</p>
</div>



As you can see, the difference between a line chart and a bar chart isn’t as great as the Excel chart-type picker might have us think. Both can have the same aesthetic properties (namely, putting years on the x axis and life expectancies on the y axis). They simply use different geometric objects to visually represent the data.

### The Third Layer: Altering Aesthetic Properties {-}

Before we return to the drought data visualization, let’s look at a few additional layers that can help us can alter our bar chart. Say we want to change the color of our bars. In the grammar of graphics approach to chart-making, this means mapping some variable to the aesthetic property of `fill`. (Slightly confusingly, the aesthetic property of `color` would, for a bar chart, change only the outline of each bar). In the same way that we mapped `year` to the x axis and y to `lifeExp`, we can also map fill to a variable, such as year:



The result is shown in Figure \@ref(fig:gapminder-bar-colors). We see now that, for earlier years, the fill is darker, while for later years, it is lighter (the legend, added to the right of our plot, shows this).



<div class="figure">
<img src="data-viz_files/figure-html/unnamed-chunk-29-1.png" alt="The same chart, now with added colors" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-29)The same chart, now with added colors</p>
</div>



What if we want to change the fill colors? For that, we use a new *scale layer*. In this case, I’ll use the `scale_fill_viridis_c()` function. The c at the end of the function name refers to the fact that the data is continuous, meaning it can take any numeric value:



This function changes the default palette to one that is colorblind-friendly and prints well in grayscale. The `scale_fill_viridis_c()` function is just one of many that start with `scale_` and can alter the fill scale.



<div class="figure">
<img src="data-viz_files/figure-html/unnamed-chunk-32-1.png" alt="The same chart with a colorblind-friendly palette" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-32)The same chart with a colorblind-friendly palette</p>
</div>



### The Fourth Layer: Setting a Theme {-}

A final layer we’ll look at is the theme layer. This layer allows us to change the overall look-and-feel of plots (plot backgrounds, grid lines, and so on). Just as there are a number of `scale_` functions, there are also a number of functions that start with `theme_.` Here, we’ve added `theme_minimal()`: 



Notice in Figure \@ref(fig:gapminder-theme) that this theme starts to declutter our plot.




<div class="figure">
<img src="data-viz_files/figure-html/unnamed-chunk-35-1.png" alt="The same chart with `theme_minimal()` added" width="100%" />
<p class="caption">(\#fig:unnamed-chunk-35)The same chart with `theme_minimal()` added</p>
</div>



We’ve now seen why Hadley Wickham described the ggplot2 package as using a layered grammar of graphics. It implements Wilkinson’s theory through the creation of multiple layers. First, we select variables to map to aesthetic properties, such as x or y axes, color, and fill. Second, we choose the geometric object (or geom) we want to use to represent our data. Third, if we want to change aesthetic properties (for example, to use a different palette), we do this with a `scale_` function. Fourth, we use a `theme_` function to set the overall look-and-feel of our plot.

We could improve the plot we’ve been working on in many ways. But rather than adding to an ugly plot, let’s instead return to the drought data visualization by Cédric Scherer and Georgios Karamanis. Going through their code will show us some familiar aspects of ggplot and reveal tips on how to make high-quality data visualization with R.

## Recreating the Drought Visualization with ggplot {-}

The code that Cédric and Georgios wrote to make their final data viz relies on a combination of ggplot fundamentals and some less-well-known tweaks that make it really shine. In order to understand how Cédric and Georgios made their data viz, we'll start out with a simplified version of their code. We'll build it up layer by layer, adding elements until we can see exactly how they made their drought data viz. 

Let's start by looking again at one region (Southwest) in one year (2003). First, we filter our data and save it as a new object called `southwest_2003`. 


```r
southwest_2003 <- dm_perc_cat_hubs %>%
  filter(hub == "Southwest") %>%
  filter(year == 2003)
```

We can take a look at this object to see the variables we have to work with:

- **date**: start date of the week of the observation
- **hub**: region
- **category**: level of drought (D0 = lowest level of drought; D5 = highest level)
- **percentage**: percentage of that region that is in that category of drought (0 = 0%, 1 = 100%)
- **year**: observation year
- **week**: week number (i.e. first week is week 1)
- **max_week**: the maximum number of weeks in a given year



```r
southwest_2003 %>%
  slice(1:10)
#> # A tibble: 10 × 7
#>    date       hub       category perce…¹  year  week max_w…²
#>    <date>     <fct>     <fct>      <dbl> <dbl> <dbl>   <dbl>
#>  1 2003-12-30 Southwest D0        0.0718  2003    52      52
#>  2 2003-12-30 Southwest D1        0.0828  2003    52      52
#>  3 2003-12-30 Southwest D2        0.269   2003    52      52
#>  4 2003-12-30 Southwest D3        0.311   2003    52      52
#>  5 2003-12-30 Southwest D4        0.0796  2003    52      52
#>  6 2003-12-23 Southwest D0        0.0823  2003    51      52
#>  7 2003-12-23 Southwest D1        0.131   2003    51      52
#>  8 2003-12-23 Southwest D2        0.189   2003    51      52
#>  9 2003-12-23 Southwest D3        0.382   2003    51      52
#> 10 2003-12-23 Southwest D4        0.0828  2003    51      52
#> # … with abbreviated variable names ¹​percentage, ²​max_week
```
Now we can use this `southwest_2003` object for our plotting. In the `ggplot()` function, we tell R to put week on the x axis, percentage on the y axis, and use the category variable (i.e. drought level) for our fill color. We then use `geom_col()` to create a bar chart where the fill color of each bar represents the percentage of the region in a single week that is at different drought levels. The colors don't match the final version of the plot, but with this code we can start to see the outlines of Cédric and Georgios's data viz in Figure \@ref(fig:southwest-2003-no-style).  




```r
ggplot(
  data = southwest_2003,
  aes(
    x = week,
    y = percentage,
    fill = category
  )
) +
  geom_col()
```

<div class="figure">
<img src="data-viz_files/figure-html/southwest-2003-no-style-1.png" alt="One year and one region of the drought visualization" width="100%" />
<p class="caption">(\#fig:southwest-2003-no-style)One year and one region of the drought visualization</p>
</div>



Cédric and Georgios next select different fill colors for their bars. They use the `scale_fill_viridis_d()` function. The "d" here means the data that the fill scale is being applied to has discrete categories (D0, D1, D2, D3, D4, D5). They use the argument `option = "rocket"` in order to select the "rocket" palette (the `scale_fill_viridis_d()` function has several other palettes). And they use the `direction = -1` argument to reverse the order of fill colors so that darker colors mean higher drought conditions, as seen in Figure \@ref(fig:southwest-2003-with-color). 




```r
ggplot(
  data = southwest_2003,
  aes(
    x = week,
    y = percentage,
    fill = category
  )
) +
  geom_col() +
  scale_fill_viridis_d(
    option = "rocket",
    direction = -1
  )
```

<div class="figure">
<img src="data-viz_files/figure-html/southwest-2003-with-color-1.png" alt="One year and one region of the drought visualization using a viridis palette" width="100%" />
<p class="caption">(\#fig:southwest-2003-with-color)One year and one region of the drought visualization using a viridis palette</p>
</div>



In the language of ggplot, x and y axis are aesthetic properties, the same as fill color. Cédric and Georgios tweak the x axis to remove both the axis title ("week") using `name = NULL` and the 0-50 axis text with `guide = none`. On the y axis, they remove the axis title and axis text (which was showing percentages in 0.00, 0.25, 0.50, 0.75 format) using `labels = NULL` (this functionally does the same thing as `guide = "none"`). They also move the axis lines themselves to the right side using `position = "right"` (they are only apparent as tick marks at this point, but will become more visible later). Figure \@ref(fig:southwest-2003-xy-scales) shows the result of these tweaks.




```r
ggplot(
  data = southwest_2003,
  aes(
    x = week,
    y = percentage,
    fill = category
  )
) +
  geom_col() +
  scale_fill_viridis_d(
    option = "rocket",
    direction = -1
  ) +
  scale_x_continuous(name = NULL, 
                     guide = "none") +
  scale_y_continuous(name = NULL, 
                     labels = NULL, 
                     position = "right")
```

<div class="figure">
<img src="data-viz_files/figure-html/southwest-2003-xy-scales-1.png" alt="One year and one region of the drought visualization with adjustments to the x and y axes" width="100%" />
<p class="caption">(\#fig:southwest-2003-xy-scales)One year and one region of the drought visualization with adjustments to the x and y axes</p>
</div>



Up to this point, we've focused on one of the single plots that make up the larger data viz. But the final product that Cédric and Georgios made is actually 176 plots (22 years and 8 regions). One of the most useful features of ggplot is what's known as facetting (known more commonly in the data viz world as small multiples). With the `facet_grid()` function, we can select which variable to put in rows and which to put in columns of our facetted plot. Cédric and Georgios put `year` in rows and `hub` (region) in columns. The `switch = "y"` argument moves the year label from the right side (where it appears by default) to the left. With this code in place, we can see the final plot coming together in Figure \@ref(fig:drought-viz-facetted). Space considerations require me to again include only four regions, but you get the idea.




```r
dm_perc_cat_hubs %>%
  filter(hub %in% c("Northwest", 
                    "California", 
                    "Southwest", 
                    "Northern Plains")) %>%
  ggplot(aes(x = week, 
             y = percentage,
             fill = category)) +
  geom_col() +
  scale_fill_viridis_d(
    option = "rocket",
    direction = -1
  ) +
  scale_x_continuous(name = NULL, 
                     guide = "none") +
  scale_y_continuous(name = NULL, 
                     labels = NULL, 
                     position = "right") +
  facet_grid(rows = vars(year), 
             cols = vars(hub), 
             switch = "y")
```

<div class="figure">
<img src="data-viz_files/figure-html/drought-viz-facetted-1.png" alt="Facetted version of the drought visualization" width="100%" />
<p class="caption">(\#fig:drought-viz-facetted)Facetted version of the drought visualization</p>
</div>



Incredibly, the broad outlines of the plot took us just 10 lines to create. All of the final code from here on out falls in the category of small polishes. That's not to minimize how important small polishes are (very) or the time it takes to create them (lots). But it is to say that a little bit of ggplot goes a long way. 

Let's look at a few of the small polishes that Cédric and Georgios make. The first is to apply a theme, as seen in Figure \@ref(fig:drought-viz-theme-light). They use `theme_light()`, which removes the default gray background and changes the font to Roboto. 




```r
dm_perc_cat_hubs %>%
  filter(hub %in% c("Northwest", 
                    "California", 
                    "Southwest", 
                    "Northern Plains")) %>%
  ggplot(aes(x = week, 
             y = percentage,
             fill = category)) +
  geom_col() +
  scale_fill_viridis_d(
    option = "rocket",
    direction = -1
  ) +
  scale_x_continuous(name = NULL, 
                     guide = "none") +
  scale_y_continuous(name = NULL, 
                     labels = NULL, 
                     position = "right") +
  facet_grid(rows = vars(year), 
             cols = vars(hub), 
             switch = "y") +
  theme_light(base_family = "Roboto")
```

<div class="figure">
<img src="data-viz_files/figure-html/drought-viz-theme-light-1.png" alt="Drought visualization with theme_light() added" width="100%" />
<p class="caption">(\#fig:drought-viz-theme-light)Drought visualization with theme_light() added</p>
</div>




`theme_light()` is what's known as a "complete theme." So-called complete themes change the overall look-and-feel of a plot. But Cédric and Georgios don't stop with applying a complete theme. From there, they use the `theme()` function to make additional tweaks to what `theme_light()` gives them. The drought visualization as it currently stands is seen in Figure \@ref(fig:drought-viz-theme-tweaks).




```r
dm_perc_cat_hubs %>%
  filter(hub %in% c("Northwest", 
                    "California", 
                    "Southwest", 
                    "Northern Plains")) %>%
  ggplot(aes(x = week, 
             y = percentage,
             fill = category)) +
  geom_col() +
  scale_fill_viridis_d(
    option = "rocket",
    direction = -1
  ) +
  scale_x_continuous(name = NULL, 
                     guide = "none") +
  scale_y_continuous(name = NULL, 
                     labels = NULL, 
                     position = "right") +
  facet_grid(rows = vars(year), 
             cols = vars(hub), 
             switch = "y") +
  theme_light(base_family = "Roboto") +
  theme(
    axis.title = element_text(size = 14, 
                              color = "black"),
    axis.text = element_text(family = "Roboto Mono", 
                             size = 11),
    axis.line.x = element_blank(),
    axis.line.y = element_line(color = "black", 
                               size = .2),
    axis.ticks.y = element_line(color = "black", 
                                size = .2),
    axis.ticks.length.y = unit(2, "mm"),
    legend.position = "top",
    legend.title = element_text(color = "#2DAADA", 
                                face = "bold"),
    legend.text = element_text(color = "#2DAADA"),
    strip.text.x = element_text(hjust = .5, 
                                face = "plain", 
                                color = "black", 
                                margin = margin(t = 20, b = 5)),
    strip.text.y.left = element_text(angle = 0, 
                                     vjust = .5, 
                                     face = "plain", 
                                     color = "black"),
    strip.background = element_rect(fill = "transparent", 
                                    color = "transparent"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    panel.spacing.x = unit(0.3, "lines"),
    panel.spacing.y = unit(0.25, "lines"),
    panel.background = element_rect(fill = "transparent", 
                                    color = "transparent"),
    panel.border = element_rect(color = "transparent", 
                                size = 0),
    plot.background = element_rect(fill = "transparent", 
                                   color = "transparent", 
                                   size = .4),
    plot.margin = margin(rep(18, 4))
  )
```

<div class="figure">
<img src="data-viz_files/figure-html/drought-viz-theme-tweaks-1.png" alt="Drought visualization with tweaks to the theme" width="100%" />
<p class="caption">(\#fig:drought-viz-theme-tweaks)Drought visualization with tweaks to the theme</p>
</div>



The code in the `theme()` function does many different things, but let's take a look at a few of the most important:

`legend.position = "top"` moves the legend from the right (the default) to the top of the plot. 

`strip.text.y.left = element_text(size = 18, angle = 0, vjust = .5, face = "plain", color = "black")` turns the year text in the columns so that it is no longer angled. Without the `angle = 0`, the years would be much less readable.



<div class="figure">
<img src="data-viz_files/figure-html/drought-viz-more-tweaks-1.png" alt="Drought visualization with additional tweaks to the theme" width="100%" />
<p class="caption">(\#fig:drought-viz-more-tweaks)Drought visualization with additional tweaks to the theme</p>
</div>



The following lines make the distinctive axis lines and ticks that show up on the right side of the final plot:


```r
axis.line.x = element_blank(),
axis.line.y = element_line(color = "black", size = .2),
axis.ticks.y = element_line(color = "black", size = .2),
axis.ticks.length.y = unit(2, "mm")
```

`panel.grid.minor = element_blank()` and `panel.grid.major = element_blank()` remove all grid lines from the final plot. 

And finally, these three lines remove the borders and make each of the individual plots have a transparent background. 


```r
panel.background = element_rect(fill = "transparent", color = "transparent"),
panel.border = element_rect(color = "transparent", size = 0),
plot.background = element_rect(fill = "transparent", color = "transparent", size = .4)
```

Keen readers such as yourself may now be thinking: "wait, didn't the individual plots have a gray background behind them?" Yes, dear reader, they did. How did Cédric and Georgios make these? They did this with a separate geom: `geom_rect()`. Here, they set some additional aesthetic properties specific to `geom_rect()` (`xmin`, `xmax`, `ymin`, and `ymax`). The result is a gray background drawn behind each small multiple, as seen in Figure \@ref(fig:drought-viz-gray-backgrounds). 


```r
geom_rect(
  aes(
    xmin = .5,
    xmax = max_week + .5,
    ymin = -0.005,
    ymax = 1
  ),
  fill = "#f4f4f9",
  color = NA,
  size = 0.4
)
```



<div class="figure">
<img src="data-viz_files/figure-html/drought-viz-gray-backgrounds-1.png" alt="Facetted version of the drought visualization with gray backgrounds behind each small multiple" width="100%" />
<p class="caption">(\#fig:drought-viz-gray-backgrounds)Facetted version of the drought visualization with gray backgrounds behind each small multiple</p>
</div>



The final polish to highlight is the tweaks to the legend. I previously showed a simplified version of the `scale_fill_viridis_d()` function. A more complete version is as follows. The `name` argument sets the legend title and the `labels` argument determine the labels that show up in the legend. Rather than D0, D1, D2, D3, and D4, we now have Abnormally Dry, Moderate Drought, Severe Drought, Extreme Drought, and Exceptional Drought. Figure \@ref(fig:drought-viz-legend-tweaks) shows the result of these changes.



```r
scale_fill_viridis_d(
  option = "rocket",
  direction = -1,
  name = "Category:",
  labels = c(
    "Abnormally Dry",
    "Moderate Drought",
    "Severe Drought",
    "Extreme Drought",
    "Exceptional Drought"
  )
)
```



<div class="figure">
<img src="data-viz_files/figure-html/drought-viz-legend-tweaks-1.png" alt="Drought visualization with changes made to the legend text" width="100%" />
<p class="caption">(\#fig:drought-viz-legend-tweaks)Drought visualization with changes made to the legend text</p>
</div>



While I've showed you a nearly complete version of the code, I have made some small changes along the way to make it easier to understand. If you're curious to see the full code Cédric and Georgios used to create the data viz, here it is. There are a few additional tweaks to colors and spacing, but nothing major beyond what we've seen so far. 


```r
ggplot(dm_perc_cat_hubs, aes(week, percentage)) +
  geom_rect(
    aes(
      xmin = .5,
      xmax = max_week + .5,
      ymin = -0.005,
      ymax = 1
    ),
    fill = "#f4f4f9",
    color = NA,
    size = 0.4,
    show.legend = FALSE
  ) +
  geom_col(
    aes(
      fill = category,
      fill = after_scale(addmix(darken(fill, .05, 
                                       space = "HLS"), 
                                "#d8005a", 
                                .15)),
      color = after_scale(darken(fill, .2, 
                                 space = "HLS"))
    ),
    width = .9,
    size = 0.12
  ) +
  facet_grid(rows = vars(year), 
             cols = vars(hub), 
             switch = "y") +
  coord_cartesian(clip = "off") +
  scale_x_continuous(expand = c(.02, .02), 
                     guide = "none", 
                     name = NULL) +
  scale_y_continuous(expand = c(0, 0), 
                     position = "right", 
                     labels = NULL, 
                     name = NULL) +
  scale_fill_viridis_d(
    option = "rocket",
    name = "Category:",
    direction = -1,
    begin = .17,
    end = .97,
    labels = c(
      "Abnormally Dry",
      "Moderate Drought",
      "Severe Drought",
      "Extreme Drought",
      "Exceptional Drought"
    )
  ) +
  guides(fill = guide_legend(nrow = 2,
                             override.aes = list(size = 1))) +
  theme_light(base_size = 18, 
              base_family = "Roboto") +
  theme(
    axis.title = element_text(size = 14, 
                              color = "black"),
    axis.text = element_text(family = "Roboto Mono", 
                             size = 11),
    axis.line.x = element_blank(),
    axis.line.y = element_line(color = "black", 
                               size = .2),
    axis.ticks.y = element_line(color = "black", 
                                size = .2),
    axis.ticks.length.y = unit(2, "mm"),
    legend.position = "top",
    legend.title = element_text(color = "#2DAADA", 
                                size = 18, 
                                face = "bold"),
    legend.text = element_text(color = "#2DAADA", 
                               size = 16),
    strip.text.x = element_text(size = 16, 
                                hjust = .5, 
                                face = "plain", 
                                color = "black", 
                                margin = margin(t = 20, b = 5)),
    strip.text.y.left = element_text(size = 18, 
                                     angle = 0, 
                                     vjust = .5, 
                                     face = "plain", 
                                     color = "black"),
    strip.background = element_rect(fill = "transparent", 
                                    color = "transparent"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    panel.spacing.x = unit(0.3, "lines"),
    panel.spacing.y = unit(0.25, "lines"),
    panel.background = element_rect(fill = "transparent", 
                                    color = "transparent"),
    panel.border = element_rect(color = "transparent", 
                                size = 0),
    plot.background = element_rect(fill = "transparent", 
                                   color = "transparent", 
                                   size = .4),
    plot.margin = margin(rep(18, 4))
  )
```


## ggplot is Your Data Viz Secret Weapon {-}

If you take up ggplot, you may start to think of it as a solution to all of your data viz problems. Yes, you have a new hammer, but no, everything is not a nail. If you look at the version of this data viz that appeared in Scientific American in November 2021, you'll see that there are some annotations not visible in our recreation. That's because they were added in post-production outside of ggplot. While you *can* come up with ways to do everything in ggplot, it's often not the best use of your time. Get yourself 90% of the way there with ggplot and then use Illustrator, Figma, or a similar tool to finish off your work. 

With that caveat in place, ggplot is a very powerful hammer. And it's a hammer used to make plots that you've seen in the New York Times, FiveThirtyEight, the BBC, and other well-known news outlets. ggplot is so popular not because it is the only tool that can make data viz that follows principles of high-quality data viz, but because it makes it straightforward to do so. The graph that Cédric Scherer and Georgios Karamanis made shows this in several ways:

1. **It strips away extraneous elements such as grid lines in order to keep the focus on the data itself**. Complete themes such as `theme_light()` and the `theme()` function allowed Cédric and Georgios to create a decluttered visualization that communicates effectively. 
1. **It uses well-chosen colors**. The `scale_fill_viridis_d()` allowed them to create a color scheme that shows differences between groups well, is both colorblind-friendly, and shows up well when printed in grayscale. 
1. **It uses small multiples to break data from two decades and eight regions into a set of graphs that come together to create a single plot.** With a single call to the `facet_grid()` function, Cédric and Georgios created over 100 small multiples that are automatically combined into a single plot. 

Learning to create data visualization in ggplot involves a significant time investment. But the long-term payoff is even greater. Once you learn how ggplot works, you can look at others' code and learn how to improve your own. Take Cédric and Georgios's code, run it on your own system, and the beautiful visualization they made will magically appear.  
Being able to run and learn from others' code is not something you can do in Excel. When you make a data viz in Excel, the series of point-and-click steps disappear into the ether with each use. Want to recreate a visualization you made last week? You'll need to remember the exact steps you used. Want to make a data viz that you saw someone else make? You'll need them to write up their process for you. 

Code-based data viz tools like ggplot allow you to keep that record of the steps you made. In the end, that's all code is: a set of instructions. And it's a set of instructions that you can re-run or you can share with others for them to run. Or the reverse: others can share their code and you can learn from them. You don't have to be the most talented designer to make high-quality data viz with ggplot. You can study others' code, adapt it to your own needs, and create your own data viz with ggplot that is beautiful and communicates effectively. 

<!--chapter:end:data-viz.Rmd-->


# Develop a Custom Theme to Keep Your Data Viz Consistent 

Placeholder


## Enter bbplot {-}
## Code is the Catalyst for Culture Change {-}

<!--chapter:end:custom-theme.Rmd-->

# R is a Full-Fledged Map-Making Tool 


<!--chapter:end:maps.Rmd-->

# Make Tables That Look Good and Share Results Effectively 

https://clauswilke.com/dataviz/figure-titles-captions.html#tables

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

