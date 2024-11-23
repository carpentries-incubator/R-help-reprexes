
---
title: "Identify the problem and make a plan"
teaching: 0
exercises: 0
---

:::::::::::::::::::::::::::::::::::::: questions 

- What do I do when I encounter an error?
- What do I do when my code outputs something I don’t expect?
- Why do errors and warnings appear in R? 
- Which areas of code are responsible for errors? 
- How can I fix my code? What other options exist if I can't fix it? 


::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

After completing this episode, participants should be able to...

- decode/describe what an error message is trying to communicate
- Identify specific lines and/or functions generating the error message
- Lookup function syntax, use, and examples using R Documentation (?help calls)
- Describe the general category of error message (e.g. syntax error, semantic errors, package-specific errors, etc.)
- Describe the output of code you are seeking
- Identify and quickly fix commonly-encountered R errors
- Identify which problems are better suited for asking for further help, including online help and reprex

::::::::::::::::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::::::::::::::: challenge

### Predict the output from a base R function call

Which of the following results when running the following line of code:

```r
length(5, 6, 7)
```

a. 3
b. Error in length(5, 6, 7) :
   3 arguments passed to 'length' which requires 1
c. NULL
d. 1, 1, 1

:::::::::::::: solution

### Solution Title

b. Error in length(5, 6, 7) :
   3 arguments passed to 'length' which requires 1

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::
