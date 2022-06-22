# Outline

1.  Intro
    1.  How viz came about
    2.  Goal: create something accurate but also compelling
2.  Close read of viz to show why it's effective
    1.  Pattern over time
    2.  Choice of chart
    3.  Well-chosen colors
    4.  Small multiples
    5.  Lil' tweaks
3.  ggplot background
    1.  People think of data viz as being made up of distinct types
        1.  Give example of how you choose chart types in Excel, which encourages this type of thinking
        2.  Give example of chart types that are the same ([Hadley talks about pie chart as stacked bar with polar coordinates](https://qz.com/1007328/all-hail-ggplot2-the-code-powering-all-those-excellent-charts-is-10-years-old/))
    2.  [Wilkinson comes up with idea of grammar of graphics](https://www.tandfonline.com/doi/full/10.1080/09332480.2022.2066422)
        1.  "A language consisting of words and no grammar (statement = word) expresses only as many ideas as there are words. ... The grammar of graphics takes us beyond a limited set of charts (words) to an almost unlimited world of graphical forms (statements)." - [Grammar of Graphics page 1](https://www.google.com/books/edition/The_Grammar_of_Graphics/NRyGnjeNKJIC?hl=en&gbpv=1&dq=grammar+of+graphics&printsec=frontcover)
        2.  "... most charting packages channel user requests into a rigid array of chart types. To atone for this lack of flexibility, they offer a kit of post-creation editing tools to return the image to what the user originally envisioned." - Page 2
    3.  [Hadley implements it in ggplot2](https://vita.had.co.nz/papers/layered-grammar.html)
        1.  He talks about *layered* grammar of graphics
        2.  "Instead of a huge, conceptually flat list of options for setting every aspect of a plot's appearance at once, ggplot breaks up the task of making a graph into a series of distinct tasks, each bearing a well-defined relationship to the structure of the plot." - [Kieran Healy](https://socviz.co/lookatdata.html#think-clearly-about-graphs)
        3.  "All data visualizations map data values into quantifiable features of the resulting graphic. We refer to these features as *aesthetics.*" - [Claus Wilke](https://clauswilke.com/dataviz/aesthetic-mapping.html)
    4.  Show example with simple chart built up over time using gapminder
4.  Return to plot and show how code works
    1.  Pattern over time (map data to aesthetic properties)
    2.  Choice of chart (geoms)
        1.  Show geom_col() first
        2.  Then explain geom_rect()
    3.  Well-chosen colors (scales)
        1.  scale_fill_viridis_d()
        2.  Also mention that we use scales for x + y axes
    4.  Small multiples (facetting)
        1.  facet_grid()
        2.  Also mention facet_wrap()?
    5.  Themes (tweaks that makes everything shine)
        1.  Complete themes
        2. theme() function
    6. Misc
        1. coord_cartesian()
        2. guides()
5.  Wrap up
    1.  Don't try to do everything in R!
        1.  Post processing on this piece done outside of R
    2.  ggplot is great for high-quality data viz
        1.  ggplot has a branding problem because nobody knows how many plots are made with it ([but everyone uses it](https://priceonomics.com/hadley-wickham-the-man-who-revolutionized-r/))
        2.  Learn how it works, make tons of changes all the time
        3.  Look at others' code to learn how to improve your own
        4.  Finish with mention of BBC to transition into next chapter

### ggplot references

-   <https://pkg.garrickadenbuie.com/gentle-ggplot2/#1>
-   <https://vita.had.co.nz/papers/layered-grammar.html>
-   <https://cfss.uchicago.edu/notes/grammar-of-graphics/>
-   <https://www.science-craft.com/2014/07/08/introducing-the-grammar-of-graphics-plotting-concept/>
-   <https://clauswilke.com/dataviz/aesthetic-mapping.html>
-   <https://socviz.co/lookatdata.html#think-clearly-about-graphs>

# From first draft

## Show chart and explain why it's effective

Do this all at a high level before later using technical language

- Pattern over time (map data to aesthetic properties)
- Choice of chart (geoms)
	- Show geom_col() first
	- Then explain geom_rect()
- Well-chosen colors (scales)
	- scale_fill_viridis_d()
	- Also mention that we use scales for x + y axes
- Small multiples (facetting)
	- facet_grid()
	- Also mention facet_wrap()? 
- Themes (tweaks that makes everything shine)
	- Complete themes
	- theme() function

## Then transition to showing how they made such an effective chart

## Then talk about ggplot generally (grammar of graphics)

- Intro with Wilkinson's article
- Then talk about Hadley picking it up and running with it

- Data mapped to ...
- ... aesthetic properties
- Scales
- Facets
- Themes




```{r}
library(tidyverse)
library(lubridate)
library(sf)
library(albersusa)
library(colorspace)
library(shades)
```

```{r}
## Color palette hubs
greys <- c(0, 60, 40, 60, 0, 40, 60, 0)
pal1 <- paste0("grey", greys)

## Set up hubs map
hub_northwest <- c("AK", "OR", "ID", "WA")
hub_california <- "CA"
hub_southwest <- c("AZ", "HI", "NM", "NV", "UT")
hub_northern_plains <- c("CO", "MT", "ND", "NE", "SD", "WY")
hub_southern_plains <- c("KS", "OK", "TX")
hub_midwest <- c("IL", "IN", "MN", "IA", "MI", "MO", "OH", "WI")
hub_southeast <- c("AL", "AR", "LA", "MS", "TN", "KY", "GA", "NC", "FL", "GA", "SC", "VA")
hub_northeast <- c("CT", "DE", "ME", "MA", "MD", "NH", "NJ", "NY", "PA", "RI", "VT", "WV")

hubs_order <- c("Northwest", "California", "Southwest", "Northern Plains", 
                "Southern Plains", "Midwest", "Southeast", "Northeast")


## Read in DroughMonitor hub data
dm_perc_cat_hubs_raw <- rio::import(here::here("data", "dm_export_20000101_20210909_perc_cat_hubs.json"))

## Wrangle
dm_perc_cat_hubs <-
  dm_perc_cat_hubs_raw %>%
  ## Remove Northern Forest as it combines Midwest + Northeast
  filter(Name != "Northern Forests\\n") %>%
  ## Remove Carribean which shows no distinct drought patterns anyway
  filter(Name != "Caribbean") %>%
  mutate(
    across(c(MapDate, ValidStart, ValidEnd), as_date),
    across(None:D4, ~as.numeric(.x) / 100),
    Name = stringr::str_remove(Name, "\\\\n"),
    Name = str_replace(Name, "Nothern", "Northern")
  ) %>%
  rename("date" = "MapDate", "hub" = "Name") %>%
  pivot_longer(
    cols = c(None:D4),
    names_to = "category",
    values_to = "percentage"
  ) %>%
  filter(category != "None") %>%
  mutate(category = factor(category)) %>%
  dplyr::select(-ValidStart, -ValidEnd, -StatisticFormatID) %>%
  mutate(
    year = year(date),
    week = week(date),
    hub = factor(hub, levels = hubs_order, labels = hubs_order)
  ) %>%
  group_by(year) %>%
  mutate(max_week = max(week)) %>% ## for var
  ungroup() %>% 
  filter(percentage > 0)
```



```{r}
dm_perc_cat_hubs %>% 
  ggplot(aes(x = week, y = percentage)) +
  geom_rect(aes(xmin = .5, 
                xmax = max_week + .5,
                ymin = -0.005, 
                ymax = 1),
    fill = "#f4f4f9", 
    color = NA, 
    size = 0.4, 
    show.legend = FALSE  #9d9ca7, 99a4be, 8696bd
  ) + 
  geom_col(
    aes(fill = category, 
        fill = after_scale(addmix(darken(fill, .05, space = "HLS"), "#d8005a", .15)), 
        color = after_scale(darken(fill, .2, space = "HLS"))),
    width = .9, size = 0.12
  ) + 
  facet_grid(rows = vars(year), cols = vars(hub), switch = "y") +
  coord_cartesian(clip = "off") +
  scale_x_continuous(expand = c(.02, .02), guide = "none", name = NULL) +
  scale_y_continuous(expand = c(0, 0), position = "right", labels = NULL, name = NULL) + 
  scale_fill_viridis_d(
    option = "rocket", name = "Category:", 
    direction = -1, begin = .17, end = .97,
    labels = c("Abnormally Dry", "Moderate Drought", "Severe Drought", 
               "Extreme Drought", "Exceptional Drought")
  ) +
  guides(fill = guide_legend(override.aes = list(size = 1))) +
  theme_light(base_size = 12, base_family = "Roboto") +
  theme(
    axis.title = element_text(size = 14, color = "black"),
    axis.text = element_text(family = "Roboto Mono", size = 11),
    axis.line.x = element_blank(),
    axis.line.y = element_line(color = "black", size = .2),
    axis.ticks.y = element_line(color = "black", size = .2),
    axis.ticks.length.y = unit(2, "mm"),
    legend.position = "top",
    legend.title = element_text(color = "#2DAADA", size = 18, face = "bold"),
    legend.text = element_text(color = "#2DAADA", size = 16),
    strip.text.x = element_text(size = 16, hjust = .5, face = "plain", color = "black", margin = margin(t = 20, b = 5)),
    strip.text.y.left = element_text(size = 18, angle = 0, vjust = .5, face = "plain", color = "black"),
    strip.background = element_rect(fill = "transparent", color = "transparent"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    panel.spacing.x = unit(0.3, "lines"),
    panel.spacing.y = unit(0.25, "lines"),
    panel.background = element_rect(fill = "transparent", color = "transparent"),
    panel.border = element_rect(color = "transparent", size = 0),
    plot.background = element_rect(fill = "transparent", color = "transparent", size = .4),
    plot.margin = margin(rep(18, 4))
  )
```

Let's take a look at how they made their visualization. 

## Close read of data viz

TODO: Add something about how there was post-production so my viz is slightly different (e.g. missing 0% and 100% on y axis text). 

Looking at the visualization as a whole, what we see is a chart broken down in multiple ways:

1. The x axis is used to show the week in a single year. 
2. The y axis shows the percentage of each region at different drought levels. 
3. Color is used to show the drought levels in each region. 
4. The chart uses small multiples so that what appears to be one large chart is actually make up of many individual charts. 

To show how the chart works, let's look at one year (2000) for one region (Southeast). 



```{r}
dm_perc_cat_hubs %>% 
  filter(year == 2000) %>% 
  filter(hub == "Southeast") %>% 
  ggplot(aes(x = week, y = percentage)) +
  geom_rect(aes(xmin = .5, 
                xmax = max_week + .5,
                ymin = -0.005, 
                ymax = 1),
    fill = "#f4f4f9", 
    color = NA, 
    size = 0.4, 
    show.legend = FALSE  #9d9ca7, 99a4be, 8696bd
  ) + 
  geom_col(
    aes(fill = category, 
        fill = after_scale(addmix(darken(fill, .05, space = "HLS"), "#d8005a", .15)), 
        color = after_scale(darken(fill, .2, space = "HLS"))),
    width = .9, size = 0.12
  ) + 
  # facet_grid(rows = vars(year), cols = vars(hub), switch = "y") +
  coord_cartesian(clip = "off") +
  scale_x_continuous(expand = c(.02, .02), guide = "none", name = NULL) +
  scale_y_continuous(expand = c(0, 0), position = "right", labels = NULL, name = NULL) + 
  scale_fill_viridis_d(
    option = "rocket", name = "Category:", 
    direction = -1, begin = .17, end = .97,
    labels = c("Abnormally Dry", "Moderate Drought", "Severe Drought", 
               "Extreme Drought", "Exceptional Drought")
  ) +
  guides(fill = guide_legend(override.aes = list(size = 1))) +
  theme_light(base_size = 18, base_family = "Roboto") +
  theme(
    axis.title = element_text(size = 14, color = "black"),
    axis.text = element_text(family = "Roboto Mono", size = 11),
    axis.line.x = element_blank(),
    axis.line.y = element_line(color = "black", size = .2),
    axis.ticks.y = element_line(color = "black", size = .2),
    axis.ticks.length.y = unit(2, "mm"),
    legend.position = "none",
    legend.title = element_text(color = "#2DAADA", size = 18, face = "bold"),
    legend.text = element_text(color = "#2DAADA", size = 16),
    strip.text.x = element_text(size = 16, hjust = .5, face = "plain", color = "black", margin = margin(t = 20, b = 5)),
    strip.text.y.left = element_text(size = 18, angle = 0, vjust = .5, face = "plain", color = "black"),
    strip.background = element_rect(fill = "transparent", color = "transparent"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    panel.spacing.x = unit(0.3, "lines"),
    panel.spacing.y = unit(0.25, "lines"),
    panel.background = element_rect(fill = "transparent", color = "transparent"),
    panel.border = element_rect(color = "transparent", size = 0),
    plot.background = element_rect(fill = "transparent", color = "transparent", size = .4),
    plot.margin = margin(rep(18, 4))
  )
```

Looking at this simplified version, we can see the structure of the chart much more clearly. The bars for each week are visible, with each color indicating a different drought level. 

TODO: Add annotated image with it showing one bar

While the weeks in the first half of the year have very low percentages in the exceptional drought level, the darkest color begins to appear in the second half of the year as a higher percentage of the region enters this category. 

TODO: Add annotated image

To understand how the code that creates this chart works, let's recreate a simplified version of it. In this code, we take our `dm_perc_cat_hubs` data frame, filter it to only include 2000 data from Southeast, and then pipe this into ggplot. In the `ggplot()` function, we do what's called setting our aesthetic properties by telling R to put week on the x axis, percentage on the y axis, and use the category variable (i.e. drought level) for our fill. This last piece sets the color of the bars that are created when we use `geom_col()` to create a bar chart. 

```{r}
dm_perc_cat_hubs %>% 
  
  # Filter to only use 2000 data
  filter(year == 2000) %>% 
  
  # Filter to only use Southeast data
  filter(hub == "Southeast") %>%
  
  # Pipe our data into ggplot, with week on the x axis and percentage on the y axis
  ggplot(aes(x = week, 
             y = percentage,
             fill = category)) +
  
  geom_col()
```


The visualization that Cédric and Georgios ended up making is a stacked bar chart
Set of stacked bars

### Shows pattern over time

The goal of the piece is to show, [as the final article in Scientific American puts it](https://www.scientificamerican.com/article/climate-change-drives-escalating-drought/), that "the past two decades have seen some of the most extreme dry periods in U.S. history." To demonstrate this trend, Cédric and Georgios  used longitudinal data. After a bit of data wrangling, the data ended up looking like this: 

TODO: Add image: https://show.rfor.us/IDq8ug

The variables in this data are:

- **date**: start date of the week of the observation
- **hub**: region
- **category**: level of drought (D0 = lowest level of drought; D5 = highest level) TODO: check that my interpretation is correct
- **percentage**: percentage of that region that is in that category of drought
- **year**: observation year
- **week**: week number (i.e. first week is week 1)
- **max_week**: TODO check what it means

With the data ready, Cédric and Georgios began the process of plotting. 

### Choice of chart (not line chart)

Show how you could do it as a line chart

```{r}
dm_perc_cat_hubs %>% 
  filter(year == 2000) %>% 
  filter(hub == "Southeast") %>% 
  ggplot(aes(x = week, y = percentage)) +
  geom_rect(aes(xmin = .5, 
                xmax = max_week + .5,
                ymin = -0.005, 
                ymax = 1),
    fill = "#f4f4f9", 
    color = NA, 
    size = 0.4, 
    show.legend = FALSE  #9d9ca7, 99a4be, 8696bd
  ) + 
  geom_line(
    aes(fill = category, 
        fill = after_scale(addmix(darken(fill, .05, space = "HLS"), "#d8005a", .15)), 
        color = after_scale(darken(fill, .2, space = "HLS"))),
    width = .9, size = 0.12
  ) + 
  # facet_grid(rows = vars(year), cols = vars(hub), switch = "y") +
  coord_cartesian(clip = "off") +
  scale_x_continuous(expand = c(.02, .02), guide = "none", name = NULL) +
  scale_y_continuous(expand = c(0, 0), position = "right", labels = NULL, name = NULL) + 
  scale_fill_viridis_d(
    option = "rocket", name = "Category:", 
    direction = -1, begin = .17, end = .97,
    labels = c("Abnormally Dry", "Moderate Drought", "Severe Drought", 
               "Extreme Drought", "Exceptional Drought")
  ) +
  guides(fill = guide_legend(override.aes = list(size = 1))) +
  theme_light(base_size = 18, base_family = "Roboto") +
  theme(
    axis.title = element_text(size = 14, color = "black"),
    axis.text = element_text(family = "Roboto Mono", size = 11),
    axis.line.x = element_blank(),
    axis.line.y = element_line(color = "black", size = .2),
    axis.ticks.y = element_line(color = "black", size = .2),
    axis.ticks.length.y = unit(2, "mm"),
    legend.position = "none",
    legend.title = element_text(color = "#2DAADA", size = 18, face = "bold"),
    legend.text = element_text(color = "#2DAADA", size = 16),
    strip.text.x = element_text(size = 16, hjust = .5, face = "plain", color = "black", margin = margin(t = 20, b = 5)),
    strip.text.y.left = element_text(size = 18, angle = 0, vjust = .5, face = "plain", color = "black"),
    strip.background = element_rect(fill = "transparent", color = "transparent"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    panel.spacing.x = unit(0.3, "lines"),
    panel.spacing.y = unit(0.25, "lines"),
    panel.background = element_rect(fill = "transparent", color = "transparent"),
    panel.border = element_rect(color = "transparent", size = 0),
    plot.background = element_rect(fill = "transparent", color = "transparent", size = .4),
    plot.margin = margin(rep(18, 4))
  )
```


### Small multiples

[The data from the National Drought Center comes divided by region](https://droughtmonitor.unl.edu/DmData/DataDownload/ComprehensiveStatistics.aspx). These regions, known technically as [USDA Climate Hubs](https://www.climatehubs.usda.gov/), include the Pacific Northwest, California, the Southwest, the Northern Plains, the Southern Plains, the Midwest, the Southeast, the Northeast, the Northern Forests, and the Caribbean (data for the latter two regions was not included in the final visualization). 

While drought has become more common in all regions (TODO: is this true?), certain regions have been hit harder than others. Using the  

### Well-chosen colors

### Little tweaks that make the chart really shine

