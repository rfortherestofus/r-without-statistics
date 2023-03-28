{{TOC}}


# Intro

You've got your ggplot theme and you now don't have to copy the raw code, but you still have to copy the function definition across projects. Not good! What to do? Make a package.

Can also run into issues because people don't have packages installed or have different versions of packages

Background on their work at Moffett
- Sensitive data so have to have it in secure places
- Accessing secure places is hard
- So made a package

Value of packages
- Code in one place
- Easy to manage dependencies
- Documentation

# Code walkthrough

## Creating functions

- You make a theme in one project and someone else would like to use it
- If you have a functions.R file you pass around, you're ready for a package 
> Travis: Yeah, functions.R screams, "make a package"

## Starting the package

- Install devtools and usethis
- usethis::create_package() or through RStudio menu

## Create function within package

- usethis::use_r()  

## Package dependencies

- usethis::use_package()
- Show description file

## package::function syntax

- Do it because you don't want to have people have to load multiple packages each time to use your package

## Running check()

- Can do with check button or devtools::check()
  
## Adding documentation for this function

Code > Insert roxygen skeleton

- #' syntax
- title (like email subject line)
- description
- roxygen

- devtools::document
	- Create helps files that users can access

## Pushing the package to GitHub

- use_github()

## Run check() again

## Showing how others can install and use the package

- Use remotes::install_github()

# Conclusion

Package is packaging up of various things needed to run code

> it's kind of obvious, but I never really thought about it until we talked today, realizing that the term package like refers to the idea of packaging up, not just code. I mean, I assume this is what it refers to not just code, but documentation, uh, information about, you know, other packages that have to be imported. Like it's a whole collection of things that enables people to run it, um, in a way that if you were to just pass around, like our, you know, in our script file, people would be like, oh, I can't run it. Cause I don't have this package installed. Or how does that work? I wish there were some documentation, like a package just kind of handles all that really elegantly, which I think is, uh, pretty handy.

Making packages is not as scary as it sounds (use Malcolm quote?)

Refer to chapter 2 of R Packages book for more info

Accessing database as more complicated use case

> Um, so yeah, I mean that, that's one, one key area where we're just having a package that would take take away the overhead of like, just setting up your session. And then, so the people got actually write code and, and kind of do the data queries day to day job instead of like handling administrative silliness.

More advanced users can bring along less experienced users

> So another, another advantage of, um, of having a packages that you're not just sharing, like with, uh, among colleagues, but somebody who, who maybe is a higher level of developer. Can kind of lead the way and, and, um, and kind of bring everyone else with them.
> Yeah, it for me, I think it, it creates a number. a number. of gradual on ramps for people who are, who are learning or are working on, uh, getting more skills in, in particular around coding.

Can encourage greater R use

> And, and then, you know, it's. So like very sneakily and you have these on ramps towards getting people to use code more and to, uh, and to, to, you know, solve their problems and, and, um, and see the value of, of using code. And, and you get that from writing a package. 
> reduce the amount of time it takes for someone to start kicking ass.

Can encourage best practices

> This is my, definitely my favorite part about writing packages is that, uh, you, you get to define the workflow a little bit. 
> And so you can kind of, um, coerce people into doing things the way that you, you, uh, you feel is best, but the, so that that's the sort of sneaky version, but the more, um, Collaborative way of framing.

