
# Intro

- Matt Herman wants to make site, but doesn't want to spend all day updating it
- He moved to Westchester County in summer 2020 where they didn't have as good data as in NYC

# Create website with Distill
- Simpler than blowdown
- "Seems pretty straightforward and simple, which again, as not a web developer, I really like"
- It brings everything together
- Our HTML docs up to this point haven't had any navigation
- Pages
- Layouts
- Custom css

# Different pieces in website
- Charts
	- Tooltips
	- But have to think about accessibility so maybe try Highcharts
- Maps
- Interactive tables
- Dynamic text (e.g. [this](https://github.com/mfherman/westchester-covid/blob/master/site/index.Rmd#L49-L53))

# Overview of files
- Show how Matt did it, then make simpler version
- Scripts to import data broken into files so he can debug individual pieces if necessary
	- "it makes it easier for me to know if something's going wrong with the CDC data, I can pull up the CDC, like the place where I pull in and clean the CDC data."

# Hosting
- How to host your website
- Explain static vs database hosting

# CI/CD
- Matt did it locally
- How to automate updating of website

# Conclusion
- When to do static vs when you need Shiny
- Quarto websites now too
- Can use Netlify to host private repos and add password-protection

# Quotes

- And so for me as like a pretty strong R user, I was doing all of my data collection and manipulation and wrangling and visualization and R. Then I could also just stay in R to create the website and to create stuff that I couldn't make myself in HTML or JavaScript.
- And so I don't really know JavaScript, but I know R and so I can write our code and use these R packages that have wrapped the JavaScript libraries to write the JavaScript for me, that I couldn't do myself.