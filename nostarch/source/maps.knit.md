---
output: html_document
editor_options: 
  chunk_output_type: console
---



# Creating Maps {#maps-chapter}

When I first started learning R, I considered it a tool for working with numbers, not shapes, so I was surprised when I saw people using it to make maps. Abdoul Madjid, a developer, has been creating maps with R for several years. Recently, he used one to visualize rates of COVID-19 in the United States in 2021. 

You might think you need specialized mapmaking software like ArcGIS to make maps, but this tool is expensive, and while Excel has added support for map-making in recent years, its features are limited (for example, you can’t use it to make maps based on street addresses). Even QGIS, an open source tool similar to ArcGIS, still requires learning new skills. 

Using R for map-making has benefits. It lets you perform all of your data manipulation tasks with one tool and apply the principles of high-quality data visualization discussed in Chapter \@ref(data-viz-chapter). For example, Madjid used R to obtain his data, analyze it, and make his COVID-19 map, which you can see in Figure \@ref(fig:madjid-covid-map).

[F04001.png]

![(\#fig:madjid-covid-map)Abdoul Madjid's map of COVID in the United States in 2021](../../assets/covid-map.png){width=100%}



In this chapter, we’ll explore principles of working with geospatial data, then walk through Madjid’s code to understand how he created this high-quality map. We’ll also discuss where to find geospatial data and how to use it to make your own maps. 

## The Briefest of Primers on Geospatial Data {-}

You don’t need to be a GIS expert to make maps. But you do need to understand a few things about how geospatial data works, starting with its two main types: vector and raster. *Vector* data uses points, lines, and polygons to represent the world. *Raster* data, which often comes from digital photographs, ties each pixel in an image to a specific geographic location. Vector data tends to be easier to work with, and we’ll be using it exclusively in this chapter.

In the past, working with geospatial data meant mastering competing standards, each of which required learning a different approach. Today, though, most people use the *simple features* model for working with vector geospatial data (often abbreviated as *sf*), which is way easier to understand. For example, take a look at some simple features geospatial data that represents the US state of Wyoming:




You can see that the data has two columns, one for the state name (NAME) and another called geometry. This data looks like the data frames you’re used to encountering, aside from two major differences: There’s a bunch of metadata above the data frame, and our simple features data contains geographical data in a variable called `geometry.` The metadata begins with the text “Simple feature collection with 1 feature and 1 field” (because the `geometry` column must be present in order for a data frame to be geospatial data it is not counted as a field). The feature referenced here is the row, and the field is the `NAME` variable, which contains non-spatial data (the `geometry` column will be discussed below). This line, and the lines that follow, are metadata about the geospatial data in the `wyoming` object. Let’s look at each part of this simple features data.

### Geometry Type {-}

The geometry type represents the shape of the geospatial data we’re working with. These types are typically written in all caps. In this case, the relatively simple `POLYGON` type represents a single polygon. We can use ggplot to display this data by calling `geom_sf()`, a special geom designed to work with simple features data:


```r
wyoming <- read_sf("https://data.rwithoutstatistics.com/wyoming.geojson")

wyoming %>%
  ggplot() +
  geom_sf()
```

Figure \@ref(fig:wyoming-map-plot) shows the resulting map of Wyoming. It may not look like much, but, hey, I wasn’t the one who chose to make Wyoming a nearly perfect rectangle!

[F04002.pdf]

![(\#fig:wyoming-map-plot)A map of Wyoming](maps_files/figure-docx/wyoming-map-plot-1.png){width=100%}



`POLYGON` is one of several geometry types that `sf` data can be used to represent. 



Other geometry types used in simple feature data include `POINT`, to display elements such as a pin on a map that represents a single location. Figure \@ref(fig:ev-stations-map) is a map showing the location of a single electric vehicle charging station in Wyoming.

[F04003.pdf]

![(\#fig:ev-stations-map)A map of a single electric vehicle charging station in Wyoming](maps_files/figure-docx/ev-stations-map-1.png){width=100%}






The `LINESTRING` geometry type is for set of points that can be connected with lines, often used to represent roads. The `LINESTRING` in Figure \@ref(fig:wy-roads-map) shows a section of US Highway 30 that runs through Wyoming.

[F04004.pdf]



























































































































