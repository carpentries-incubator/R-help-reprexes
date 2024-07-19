
---
title: "De-bugging basics – what do I do when I encounter an error?"
teaching: 0
exercises: 0
---

:::::::::::::::::::::::::::::::::::::: questions 

-  Why do errors and warnings appear in R? 
-  Which areas of code are responsible for errors? 
-  How can I fix my code? What other options exist if I can't fix it? 


::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

After completing this episode, participants should be able to...

- decode/describe what an error message is trying to communicate
- Identify specific lines and/or functions generating the error message
- Describe the general category of error message (e.g. syntax error, semantic errors, package-specific errors, etc.)
- Identify which problems are better suited for asking for further help, including online help and reprex
- Adopt an initial workflow to remedy errors, including ?help lookups, identifying and quickly fixing commonly-encountered R errors, and recogizing when to stop troubleshooting and ask for help


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
