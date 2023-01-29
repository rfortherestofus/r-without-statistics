# References

[Presentation](https://spcanelon.github.io/xaringan-basics-and-beyond/index.html) 

[Basics slides](https://spcanelon.github.io/xaringan-basics-and-beyond/slides/day-01-basics.html#1) 

[Basics slides code](https://github.com/spcanelon/xaringan-basics-and-beyond/blob/main/slides/day-01-basics.Rmd) 

# Intro

You don't always want a report, sometimes you want a slide deck

Stop going to an external too: R can do it all

# Overview of presentations

You can make multiple types of presentations (PPT, beamer, etc), but xaringan is best

xaringan produces html docs 

## How xaringan works

Familiar markdown pieces (headings, bold, italics, etc)

Unique syntax of xaringan (--- for new slides, -- for incremental slides, ??? for presenter notes)

Background images

Aligning things with CSS class center/middle

Columns with .left[] and .right[]

Add tables

Add plots

Change fonts

Custom CSS (colors and fonts)

# Extra packages to customize fonts, colors, etc more easily

- xaringanthemer
- xaringanExtra
- existing themes (e.g. R-Ladies)

# Advantages of xaringan

- It's where you're already working with data so no copy-paste issues
	- Can copy in code from anywhere else and reuse it
	- Silvia: "And then of course there's like the really nice aspects of using, sharing again about using code and then being able to produce a figure and have that already be in your slides and not having to worry about which version of this table or figure did I make and what do I need to edit?"
	- Silvia: "And you know, all that mental work you don't have to do if you are just using, if you're generating the output using code, which is awesome also."
- You can post your HTML and link to it
- Accessibility
	- "And, and so audience members have in general, and you know, obviously not just people that use screen readers, but audience members, when they have the HTML version of the slides, they have some control over what it looks like."

# Conclusion

- Quarto now available too
- Can update presentations at any point