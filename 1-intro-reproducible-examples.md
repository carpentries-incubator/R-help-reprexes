---
title: "What is a reprex and why is it useful?"
teaching: 15
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How is the process of getting help in R different from getting help with other things?
- Why is a minimal reproducible example an important tool for getting help in R?
- What will we be learning in the rest of the course?
  
::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Recognize what it takes to debug someone else's code.
- Define a minimal reproducible example.
- Describe the general workflow that we will cover in the rest of this lesson.

::::::::::::::::::::::::::::::::::::::::::::::::

#### Welcome and introductions
- Welcome to "RRRR, I'm Stuck!" We're glad you're here! Let's first take care of a few setup steps. You should have all followed the setup instructions on the [workshop website](kaijagahm.github.io/R-help-reprexes/), and you should have both R and RStudio installed.
 
- You should also have the following packages installed: {**reprex**}, {**ratdat**}, {**tidyverse**}.

- We have a range of levels of experience here. This workshop assumes that you are researcher in ecology/biology who has some prior experience working with R in RStudio.

- We won't be spending a lot of time going over [concepts]. Here's a handy reference guide to lessen some of the cognitive load... [to be continued.]

- You don't have to be an expert. But we also know that even more experienced R coders might be less familiar with how to get unstuck, so we hope this workshop will be useful to you too.

:::::::::::::::::::::::::::::::::::::: challenge 

## Think, pair, share

When you're coding in R and you get stuck, what are some things that you do to get help or get unstuck?

::::::::::::::::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::::::::::::::: challenge 

## Think, pair, share

Think about a time that you helped someone else with their code. What information did you need to know in order to help?
(If you have never helped someone else with their code, think about a time that someone helped you--what information did they  need to know in order to help?)

::::::::::::::::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::::::::::::::: callout

## Minimal Reproducible Example (aka "reprex")

```
"Your code examples should be...
Minimal: Use as little code as possible that still produces the same problem
Complete: Provide all parts someone else needs to reproduce your problem in the question itself
Reproducible: Test the code you're about to provide to make sure it reproduces the problem" - [StackOverflow](https://stackoverflow.com/help/minimal-reproducible-example)
```

```
"The goal of a reprex is to package your problematic code in such a way that other people can run it and feel your pain. Then, hopefully, they can provide a solution and put you out of your misery." - [Get help! (Tidyverse)](https://www.tidyverse.org/help/)
```

```
"The habit of making little, rigorous, self-contained examples also has the great side effect of making you think more clearly about your programming problems." - [Jenny Bryan](https://posit.co/resources/videos/help-me-help-you-creating-reproducible-examples/)
```

::::::::::::::::::::::::::::::::::::::::::::::::

These steps might seem simple, but they can be challenging to put into practice. In this lesson, we will be guiding you through the process of creating a minimal reproducible example. By the end, you will have a workflow to follow next time you get stuck.

## Overview of this lesson

[Visual: screenshot or diagram of someone else's educational resource where they explain what a minimal reproducible example is (with appropriate credit given of course)] --> use this to motivate how we're going to be going through each step of that in this lesson.

[Visual: diagram of the general process, with questions along the way]--to draw ourselves
### Understand your code
### Apply "first aid" debugging strategies
### Create minimal reproducible data
### Simplify your code and make it minimal
### Prepare to share your reproducible example with others.

----

**Motivating examples**

[Screenshots of real requests for help]

----  



::::::::::::::::::::::::::::::::::::: keypoints 

- Mentors and helpers usually need to run your code in order to help debug it.
- Minimal reproducible examples make it possible for helpers to run your code, which lets them "feel your pain" and figure out what's wrong.
- Making a minimal reproducible example helps you understand your own problem and often leads to finding the answer yourself!
- You can use the {reprex} package to test whether your example is reproducible.
  
::::::::::::::::::::::::::::::::::::::::::::::::
