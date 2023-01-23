# References

- https://urban-institute.medium.com/iterated-fact-sheets-with-r-markdown-d685eb4eafce (old article)
- https://urban-institute.medium.com/using-r-markdown-to-track-and-publish-state-data-d1291bfa1ec0 (new article)
- [State Fiscal briefs](https://www.urban.org/policy-centers/cross-center-initiatives/state-and-local-finance-initiative/projects/state-fiscal-briefs) 

# Outline

## Intro
- Urban situation of having to produce 51 reports
- Having to do multiple reports is something many people have to do

## How Parameterized Reporting Works

- Make COVID reports for all states

Work in Rmd
- Adding params in YAML
- Using params in text
- Use `if_else()` to alter text
- Make 1 report by knitting
- But you don't want to do this for all 51 states

Work in render.R
- Show how you can render 1 document with render() function
- Create reports tibble 
- Create all reports using `pwalk()` 
	- https://twitter.com/christophcsmith/status/1616585865601626112
		- "When you include the parentheses, you're telling R to execute the function and pass the output to pwalk. When you exclude the parentheses, you're telling R to pass the function itself. Remember: innermost parentheses are always evaluated first."

## Best Practices

- Think about outliers
	- Livia: "Well, one thing I, I don't think we've talked a lot about is kind of, um, making sure that you're aware of exceptions. Um, and in the state pages, uh, one really big one, for example, is Washington, dc So technically not a state, but we include it, uh, as a part of our pages. So there's 51 in total, and that because DC you know, it's not the state isn."
	- Aaron: "Uh, definitely. So, I mean, the first thing is if for any parameter that you have, um, definitely try sort of the shortest value and the longest value. So look at Iowa, look at the District of Columbia or Massachusetts, right? Even when you don't have page breaks, titles can get clipped in data visualizations and things like that."

## Conclusion
- You can use parameterized reporting for any output format (Urban Institute has done this before to make PDF reports)
- Working with parameterized reporting makes it possible to make multiple reports in a way that simply isn't possible with other tools
	- You might never think to do this kind of thing with multi-tool workflow
		- Urban makes county-level reports this way. Aaron: "So 3,142, I mean, that by hand would just be entirely impossible. But there's this, then there's this sort of question of like, oh, well what do we do with these? And so working with comms, we have all of that templated now. We have the US map landing page where you can pick a state. We have a US map with a landing page where you can pick a county, and we've worked out some of this backend stuff."
	- Using parameterized reporting is also more accurate because no copy paste
- Reproducibility isn't just making same report next month, it's also making same report for multiple states etc
- It takes a while to do initial work to make report in Rmd, but parameterized reporting shows where it pays off

## To classify

- How to make things different for different states
- Safia: "And so, using our markdown made it not only quicker, but much more accurate, and we were able to pull in more information because of that and make more interesting calculations and observations."
- Aaron: "It makes it something that's more sustainable. You're not having to plug the data index cell, make sure your cell references are correct. There's always a cell reference error. Um, and then, you know, copy that as a p and g or whatever into the document. Maybe you have to do that eight times per state. Right? That's just not sustainable."
- Livia: " I think there's a, um, uh, you know, upfront there's a lot more, uh, labor and time that's put into it because you're, you know, writing all the code, you're cleaning out the data. So that you have everything that you need. Um, but in the long run it's a lot faster."
- Your template can be dynamic enough to include some differences (see `state_text`). 
