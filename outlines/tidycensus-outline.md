# References

https://web.descript.com/276658cf-2ebd-44f3-9774-cf3190273c2d/74679

# Intro

Kyle struggled with accessing Census data all the time

> Frankly, if even if the package weren't successful, I would've still saved so much time because it is literally software that I use every single day.

It was tedious

> It was on, on Twitter again, and someone had tweeted out kind of, I, I wish there were a package. That brought in census shape files into our, and automatically did that. And, um, a friend of mine, Eli NA who's, um, working out at the, uh, at UC Riverside, uh, said, well, Kyle, why don't you do that? And so I thought, sure, this has always been tedious. I don't like going to the census website every time and pulling the shape files.

# What is an API?

You can access data by downloading it

You can access data if it's online with a direct link

You can access data in multiple formats, groupings, etc using an API (`googlesheets4` is also an API package)

`tidycensus` does a ton of work so you don't have to:

> It will go to the appropriate endpoint, which is typically the data set, um, from which you're requesting data. It will communicate with that. The census website bring the data back. The data comes back in JSON format. So JavaScript, object notation, and then tidy census does all the work of tidying up that JSON for you.

# How tidycensus works

- Get API key
- `get_decennial()` and `get_acs()`
	- mention there are other endpoints

## Census data
- See all variables
- Work with Census data (Hispanic/Latino population by state)
- Name variables in `get_decennial()`
- Calculate percentages
- Calculate percentages with a summary variable

## ACS data
- How to see all variables
- Median age by Census tract
- Median age by state
- Get geospatial data
- Map results (mention how `tigris` works with `tidycensus`)

## Wide data

- Use `wide` argument
- Can also use `pivot_wider()`

# Conclusion

Additional datasets you can work with in `tidycensus` beyond ACS and Census

[Packages for other countries](https://twitter.com/kyle_e_walker/status/1633843404269580292). See also [Chapter 12 of his book](https://walker-data.com/census-r/working-with-census-data-outside-the-united-states.html).

Best of open source: a developer writes a package so that end users can focus on working with data, not all of the API stuff

> You can work with APIs without having to know the details: "I've heard R described as  the ultimate user interface, you know, R is, it allows us to interact with these other technologies that if you're learning each of those technologies by themselves can quickly get overwhelming."

> So. I need to get my spatial data. So I'm gonna go to the tiger line, shape files website. I navigate through the menus. I'm gonna pull down the data that I need. I'm gonna unzip it. I'm gonna load it into RGIS. Now I need to get my demographic data. So I'm gonna go to what was then American fact finder, find the right tabulation, pull that down as a CSV, load that into RGIS.
> Now I need to join the tables together. Oh, but the sort of ID column in the shape file and the ID column in the CSV file, one is coded character and one is coded integer and I can't make the join. So I need to modify that. And this was sort of the process. And I wrote a lab for my introductory GIS students to do this.
> Cuz I knew it was important that they learned how to work with census data and they, it. The amount of time that they were spending on it, I would feel bad about it because it was a laborious process to get through.

# To categorize

- "I found a job in New York city doing GIS for a pension fund. And, uh, I was just doing point and click RGIS work, uh, which was valuable, but it wasn't reproducible. And I had a colleague, um, who worked with me and he would look over it at my screen. He would say, you know, how, how do you remember anything that you did? And I didn't have a good answer for that because I wasn't documenting any of my work. The point and click software was sort of pushing me into. I would say bad habits."
	- "And it just light bulb goes off. Why, I guess, I don't know. I just sort of remember it. And then I started writing down in a word document step by step, the steps I was taking. But at the end of the day was still pretty limiting. I mean, I remember talking to my boss, he asked me to do something and I don't remember what the specific task was, but there wasn't a tool in R J I S to do it."
- He got into R to learn to make interactive graphics
- "I was very much constrained by what the software could do. And frankly, desktop GIS software is very powerful software. You can do a lot with it. And if you do learn a script with it, you can extend it. But at the end of the day, you're still more limited. You're, you're constrained to a degree by what the software can do."
- "What tidy census tries to do is all of the tedious aspects of getting census data. It tries to do that for you. So that you can focus on the fun aspects of census data. So making maps is fun, analyzing data and finding out insights about your community is fun and interesting, but setting up a connector to an API or figuring out how to align columns in emerge, it's, it's more tedious."


