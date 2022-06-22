---
output: html_document
editor_options: 
  chunk_output_type: console
---
# (PART\*) Illuminate {-}

# Use General Principles of High-Quality Data Viz in R {-}

In the spring of 2021, [nearly all of the American West was in a drought](https://droughtmonitor.unl.edu/DmData/TimeSeries.aspx). In April of that year, [officials in Southern California declared a water emergency](https://www.cbsnews.com/news/west-climate-change-water/), citing unprecedented conditions. 

This wouldn't have come as news to those living in California and other Western states. In addition to the direct impact of drought (leading areas of California to implement water use restrictions), people could see the indirect impact of drought in increased wildfires. With forests dried out by years of drought conditions, wildfires became more frequent, filling skies in the West with smoke. 

TODO: Add personal story

While more and more people are able to see the increase in drought conditions, communicating the extent of this change remains a challenge. How can we show the data in a way that accurately represents the data while is also compelling enough to have lay people take notice? 

This was the challenge that freelance data visualization designers Cédric Scherer and Georgios Karamanis took on in November 2021. Commissioned by the magazine Scientific American to create a data visualization that would highlight the extent to which droughts in the United States have become common, they turned to the ggplot2 package to turn what could be (pardon the pun) dry data on droughts into a set of impactful data visualizations. 

There was nothing unique about the data that Cédric and Georgios used. It was the same data from the National Drought Center that news organizations used in their stories. But what these two information designers did was present the data in a way that it both grabs attention and communicates clearly the scale of the phenomenon. 







<img src="data-viz_files/figure-html/unnamed-chunk-3-1.png" width="672" />




Let's take a look at how they made their visualization. 

## Close read of data viz

TODO: Add something about how there was post-production so my viz is slightly different (e.g. missing 0% and 100% on y axis text). 

Looking at the visualization as a whole, what we see is a chart broken down in multiple ways:

1. The x axis is used to show the week in a single year. 
2. The y axis shows the percentage of each region at different drought levels. 
3. Color is used to show the drought levels in each region. 
4. The chart uses small multiples so that what appears to be one large chart is actually make up of many individual charts. 

To show how the chart works, let's look at one year (2000) for one region (Southeast). 



<img src="data-viz_files/figure-html/unnamed-chunk-4-1.png" width="672" />

Looking at this simplified version, we can see the structure of the chart much more clearly. The bars for each week are visible, with each color indicating a different drought level. 

TODO: Add annotated image with it showing one bar

While the weeks in the first half of the year have very low percentages in the exceptional drought level, the darkest color begins to appear in the second half of the year as a higher percentage of the region enters this category. 

TODO: Add annotated image

To understand how the code that creates this chart works, let's recreate a simplified version of it. In this code, we take our `dm_perc_cat_hubs` data frame, filter it to only include 2000 data from Southeast, and then pipe this into ggplot. In the `ggplot()` function, we do what's called setting our aesthetic properties by telling R to put week on the x axis, percentage on the y axis, and use the category variable (i.e. drought level) for our fill. This last piece sets the color of the bars that are created when we use `geom_col()` to create a bar chart. 

<img src="data-viz_files/figure-html/unnamed-chunk-5-1.png" width="672" />


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

<img src="data-viz_files/figure-html/unnamed-chunk-6-1.png" width="672" />


### Small multiples

[The data from the National Drought Center comes divided by region](https://droughtmonitor.unl.edu/DmData/DataDownload/ComprehensiveStatistics.aspx). These regions, known technically as [USDA Climate Hubs](https://www.climatehubs.usda.gov/), include the Pacific Northwest, California, the Southwest, the Northern Plains, the Southern Plains, the Midwest, the Southeast, the Northeast, the Northern Forests, and the Caribbean (data for the latter two regions was not included in the final visualization). 

While drought has become more common in all regions (TODO: is this true?), certain regions have been hit harder than others. Using the  

### Well-chosen colors

