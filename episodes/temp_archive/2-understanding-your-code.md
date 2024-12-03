---
title: "Understanding your code"
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- TODO

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Describe in general terms what you want your code to do, and what it is currently doing.
- Break down your code into conceptual steps (pseudocode, or a narrative of what you're doing)
- Identify relevant variables/objects

::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::: challenge

### Order the conceptual steps of code

Here is a block of code that creates an example data visualization.

```r
library(dplyr)
library(ggplot2)
fuel_efficient <- mtcars %>%
    filter(mpg > 30) %>%
    select(hp, mpg)
p <- ggplot(fuel_efficient, aes(x = hp, y = mpg))+
    geom_point()
p
```

Reorder the following conceptual steps so that they accurately reflect what this code is trying to accomplish.

```
A. Set up a visualization that will show the relationship between horsepower and fuel efficiency
B. Choose only the most fuel efficient cars
C. Display the plot that was just created
D. Load necessary packages
E. Simplify the dataset to show fewer columns
F. Add points to the initial plot
```

:::::::::::::: solution

### Solution

```
D. Load necessary packages
B. Choose only the most fuel efficient cars
E. Simplify the dataset to show fewer columns
A. Set up a visualization that will show the relationship between horsepower and fuel efficiency
F. Add points to the initial plot
C. Display the plot that was just created
```

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::
