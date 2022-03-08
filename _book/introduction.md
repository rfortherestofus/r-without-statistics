# (PART\*) Introduction {-}

# Why R Without Statistics? {-}

## How New Zealand Used R to Fought COVID with R {-}

TODO

## How I Came to Use R {-}

My own relationship with R goes back to 2016. At the time, I was a consultant, helping non-profits, government agencies, and educational institutions to measure how effective their work is (a field known as [program evaluation](https://www.cdc.gov/evaluation/index.htm)). A lot of my work involved conducting surveys, analyzing the resulting the data, and sharing these results with clients. 

The work itself was fine, but the tools I was using to do it were getting on my nerves. Well, one tool really: Excel. 

Now look, this is not a place for an anti-Excel rant. Excel is a fine tool that has empowered millions to work with data in ways they would never have been able to without this tool. 

But, for me, Excel was tedious. The amount of pointing and clicking I had to do when working with the amount of data I had got old fast. Each time I would conduct a survey, I’d know that it would yield an avalanche of data and that my wrists would end up exhausted after hours of pointing and clicking on Excel buttons. 

No matter what I did, analyzing data and creating charts in Excel just involved a lot of repetitive pointing and clicking. 

TODO: Add graph of clicks going up

Endless pointing and clicking was just one problem I faced using Excel. Annoying though it was, it didn’t affect the quality of my work. Or so I thought until I recalled a project I had worked on a few years earlier. 

In this project, I was looking at which school districts in the state of Oregon have [outdoor education programs known as Outdoor School](https://oregonstate.app.box.com/s/83g5sjdm88xgqdxfze0ri7qo4uff5sj7). As part of this project, I had to download data on all school districts throughout Oregon, filter to only include relevant districts with fifth or sixth graders (the ages Outdoor School takes place), and then merge this with data that I collected as part of a survey I conducted. 

I did the work in Excel, using a lot of (you guessed it!) pointing and clicking. The problem came when I was almost done with the project. I’ve blocked the details from my memory (as I’ve done with most things Excel-related), but what I do recall is that I wasn’t 100% certain I had done my filtering and joining correctly. And, to make it worse, I had no way to check. Why? Because all my pointing and clicking was ephemeral, gone in the ether as soon as I had completed it. 

I finished the Outdoor School project and submitted my report. I think the work I did was probably accurate, but maybe it wasn’t? 

Now, you may be reading this thinking: why didn’t you write down the steps you used in Excel so you could retrace them later? Sure, I could (and should) have done that. But let’s be honest: most of us don’t. 

And the reality is, we’re human. We all make mistakes. And without a straightforward way to audit your work (and keeping a list of all of your Excel points and clicks in a separate document is not, in my view, straightforward), mistakes will happen. If you’ve used Excel to work with data, I guarantee you’ve made a mistake, just like me. 

The good news is that it’s ok. There’s a solution. And that solution is called R. 

* * * 

If I were to redo that project on Outdoor School with R, here’s what would be different. Rather than watching points and clicks disappear into the ether, I’d write code that would serve as a record of everything I did. This code would: 

1. Download data on all school districts
2. Filter to only include districts with fifth or sixth graders
3. Join the filtered data on school districts with my survey data

TODO: Add pseudocode to show this in R

Code can be scary. Having to write code is one of the reasons many people never learn R. But code is just a list of things you want to do to your data. It may be written in a hard-to-parse syntax (though it quickly gets easier to make sense of it), but it’s just a set of steps. The same steps that we should write out when we’re working in Excel, but never do. 

If I had done things this way when working on the Outdoor School project, I could have looked back at any point to make sure what I thought was happening to my data was in fact happening. That nagging sensation I had near the end of the project that I may have made a mistake in one of my early points or clicks? It never would come up because I could just review my code to make sure it did what I thought it did. 

Using R won’t mean you’ll never make mistakes again (trust me, you will). But it will mean that you can easily spot your mistakes, make changes, and rerun your code to fix any issues. 

I started learning R to avoid tedious pointing and clicking. But what I found was that R improved my work in ways I never expected. It’s not just that my wrists are less tired. I now have more confidence that my work is accurate. 

### My own uncertainty about the way I use R {-}

For the longest time, I felt TK about the way I use R. I use R, a tool designed for statistical analysis, but I don't use it for complex statistical analysis. I don't do machine learning. 

### My background as an anthropologist {-}

### Never used R in grad school {-}

### I use R for three main things: {-}

1. descriptive stats
2. data viz
3. RMarkdown

### But then I realized what people get most excited about is: {-}

Interview with Sharla (statistician who doesn't do complex stats)
- Her rstudio::conf talk

Data viz (illuminate)

Websites (communicate)

Workflow (i.e. automate)

Everyone needs to:

1. Illuminate
2. Communicate
3. Automate

### Is R Just for Statistics? {-}

It was a niche language by statisticians for statisticians, now it's used by millions for a huge range of purposes. 

### So if R is a general purpose language, why use it versus any other language? {-}

Gives you data stuff first, then you can add on everything else

Remove this section? Too defensive?

## Book Overview {-}

### How each chapter works {-}

### Broad scope of book {-}
- I’ve tried to choose topics that are relevant to everyone, no matter what you do (e.g. art with R is cool but not everyone wants to do it)

### Why didn’t you cover X topic? {-} 
- That’s a great idea, but I can’t cover everything!
- The fact that R can do X is a great example of its versatility (please write your own book!)

### Book title is not to be taken literally {-}

Paul Jarvis Company of One 

