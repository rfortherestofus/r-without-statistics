[Code etc](https://github.com/AbdoulMa/TidyTuesday/tree/main/2022/2022_w1)

## Intro
- You can make maps with R too
- Excel can only make limited maps
	- "Map charts can only plot high-level geographic details, so latitude/longitude, and street address mapping isn’t supported." ([source](https://support.microsoft.com/en-us/office/create-a-map-chart-in-excel-f2cfed55-d622-42cd-8ec9-ec8a358b593b))
- ArcGIS is expensive and requires learning a whole new tool
- There is QGIS but why learn another tool when R can do the same things?
- You don't have to be a GIS expert to make nice maps (Aboul isn't but does)


## Working with geospatial data in R

- We're only working with vector data
- geometry column
	- Geometry types: In this chapter we will focus on the seven most commonly used types: POINT, LINESTRING, POLYGON, MULTIPOINT, MULTILINESTRING, MULTIPOLYGON and GEOMETRYCOLLECTION ([source](https://geocompr.robinlovelace.net/spatial-class.html#geometry))
- Projections
	- Show a few from [albersusa](https://github.com/hrbrmstr/albersusa)
	- "Therefore, some properties of the Earth’s surface are distorted in this process, such as area, direction, distance, and shape. A projected coordinate system can preserve only one or two of those properties. Projections are often named based on a property they preserve: equal-area preserves area, azimuthal preserve direction, equidistant preserve distance, and conformal preserve local shape." ([source](https://geocompr.robinlovelace.net/spatial-class.html#projected-coordinate-reference-systems))
	- [crssuggest](https://github.com/walkerke/crsuggest)
	- [Advice on choosing a good projection](https://geocompr.robinlovelace.net/reproj-geo-data.html?q=wgs#which-crs)
		- "When selecting geographic CRSs, the answer is often WGS84. It is used not only for web mapping, but also because GPS datasets and thousands of raster and vector datasets are provided in this CRS by default. WGS84 is the most common CRS in the world, so it is worth knowing its EPSG code: 4326. This ‘magic number’ can be used to convert objects with unusual projected CRSs into something that is widely understood."
- You can use dplyr stuff same as with basic data wrangling
	- Show how Abdoul brings in NYT data

References
- [Geocomputation with R](https://geocompr.robinlovelace.net/) 
- [Charlie video on simple features](https://muse.ai/e/Uyc3rwL)


## How to make good maps (walk-through of Abdoul's code)
- Choose good projection
- Colors
	- Uses same rocket palette as in data viz chapter
- Legend
- Theme stuff
- Small multiples

## Conclusion

Nuts and bolts
- Show we can use tidyverse stuff along with sf
- How to find and use good projections
- Where to find geo data

Conceptual
- Use the tool you're already using (same as making tables in R Markdown files) 
- But it's not just that you should use R because you're using it for other things. It's better than other tools.
- You can do more flexible things than with Excel
- You have the flexibility of ArcGIS without the cost
- You can apply data viz principles (and code) to make your maps shine
