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
5. Misc
		1. coord_cartesian()
		2. 
6.  Wrap up
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
