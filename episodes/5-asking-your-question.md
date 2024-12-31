---
title: "Asking your question"
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 
- How can I make sure my minimal reproducible example will actually run correctly for someone else?
- How can I easily share a reproducible example with a mentor or helper, or online?
- How do I ask a good question?
::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives
- Use the reprex package to test whether an example is reproducible.
- Use the reprex package to format reprexes for posting online.
- Understand the benefits and drawbacks of different places to get help.
- Have a road map to follow when posting a question to make sure it's a good question.
- Understand what the {reprex} package does and doesn't do.
::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: keypoints
- The {reprex} package makes it easy to format and share your reproducible examples.
- The {reprex} package helps you test whether your reprex is reproducible, and also helps you prepare the reprex to share with others.
- Following a certain set of steps will make your questions clearer and likelier to get answered.
::::::::::::::::::::::::::::::::::::::::::::::::

Congratulations on making it this far. Creating a good reproducible example is a lot of work! In this episode, we'll talk about how to finish up your reprex, make sure it's ready to send to your helper or post online, and make absolutely double sure that it actually runs.

There are three principles to remember when you think about sharing your reprex with other people:

1. Reproducibility
2. Formatting
3. Context

## 1. Reproducibility

You might be thinking, *Haven't we already talked a lot about reproducibility?* We have! We discussed variables and packages, minimal datasets, and making sure that the problem is meaningfully reproduced by the data that you choose. But there are some reasons that a code snippet that appears reproducible in your own R session might not actually be runnable by someone else.

Some possible reasons:

- You forgot to account for the origins of some functions and/or variables. We went through our code methodically, but what if we missed something? It would be nice to confirm that the code is as self-contained as we thought it was.

- Your code accidentally relies on objects in your R environment that won't exist for other people. For example, imagine you defined a function `my_awesome_custom_function()` in a project-specific `functions.R` script, and your code calls that function. 

![A function called `"my_awesome_custom_function"` is lurking in my R environment. I must have defined it a while ago and forgotten! Code that includes this function will not run for someone else unless the function definition is also included in the reprex.](fig/custom_function.png)

```
my_awesome_custom_function("rain")
# [1] "rain is awesome!"
```

I might conclude that this code is reproducible--after all, it works when I run it! But unless I include the function defintion in the reprex itself, nobody who doesn't already have that custom function defined in their R environment will be able to run the code.

A corrected reprex would look like this:

```
my_awesome_custom_function <- function(x){print(paste0(x, " is awesome!"))}
my_awesome_custom_function("rain")
#[1] "rain is awesome!"
```

Wouldn't it be nice if we had a way to check whether any traps like this are lurking in our draft reprex?

Luckily, there's a package that can help you test out your reprexes in a clean, isolated environment to make sure they're actually reproducible. Introducing `{reprex}`!

The most important function in the `{reprex}` package is called `reprex()`. Here's how to use it.

First, install and load the `{reprex}` package.

```
#install.packages("reprex")
library(reprex)
```

Second, write some code. This is your reproducible example.

```
(y <- 1:4)
mean(y)
```

Third, highlight that code and copy it to your clipboard (e.g. `Cmd + C` on Mac, or `Ctrl + C` on Windows). 

Finally, type `reprex()` into your console.

```
# (with the target code snippet copied to your clipboard already...)
# In the console:
reprex()
```

`{reprex}` will grab the code that you copied to your clipboard and _run that code in an isolated environment_. It will return a nicely formatted reproducible example that includes your code and and any results, plots, warnings, or errors generated.

The generated output will be on your clipboard by default, so all you have to do is paste it into GitHub, StackOverflow, Slack, or another venue.

::: callout
This workflow is unusual and takes some getting used to! Instead of copying your code *into* the function, you simply copy it to the clipboard (a mysterious, invisible place to most of us) and then let the blank, empty `reprex()` function go over to the clipboard by itself and find it.

And then the completed, rendered reprex replaces the original code on the clipboard and all you need to do is paste, not copy and paste. 

Try to practice this workflow a few times with very simple reprexes so you can get a sense for the steps.
:::

Let's practice this one more time. Here's some very simple code:

```
library(ggplot2)
library(dplyr)
mpg %>% 
  ggplot(aes(x = factor(cyl), y = displ))+
  geom_boxplot()
```

Let's highlight the code snippet, copy it to the clipboard, and then run `reprex()` in the console. 

```
# In the console:
reprex()
```

The result, which was automatically placed onto my clipboard and which I pasted here, looks like this:

``` r
library(ggplot2)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
mpg %>% 
  ggplot(aes(x = factor(cyl), y = displ))+
  geom_boxplot()
```

![](https://i.imgur.com/bOA0BAS.png)<!-- -->

<sup>Created on 2024-12-29 with [reprex v2.1.1](https://reprex.tidyverse.org)</sup>

Nice and neat! It even includes the plot produced, so I don't have to take screenshots and figure out how to attach them to an email or something.

The formatting is great, but `{reprex}` really shines when you treat it as a helpful collaborator in your process of building a reproducible example (including all dependencies, providing minimal data, etc.)

Let's see what happens if we forget to include `library(ggplot2)` in our small reprex above.

```
library(dplyr)
mpg %>% 
  ggplot(aes(x = factor(cyl), y = displ))+
  geom_boxplot()
```

As before, let's copy that code to the clipboard, run `reprex()` in the console, and paste the result here.

```
# In the console:
reprex()
```

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
mpg %>% 
  ggplot(aes(x = factor(cyl), y = displ))+
  geom_boxplot()
#> Error in ggplot(., aes(x = factor(cyl), y = displ)): could not find function "ggplot"
```

<sup>Created on 2024-12-29 with [reprex v2.1.1](https://reprex.tidyverse.org)</sup>

Now we get an error message indicating that R cannot find the function `ggplot`! That's because we forgot to load the `ggplot2` package in the reprex.

This happened even though we had `ggplot2` already loaded in our own current RStudio session. `{reprex}` deliberately "plays dumb", running the code in a clean, isolated R session that's different from the R session we've been working in. This keeps us honest and makes sure we don't forget any important packages or function definitions.

Let's return to our previous example with the custom function.

```
my_awesome_custom_function("rain")
```

```
# In the console:
reprex()
```

``` r
my_awesome_custom_function("rain")
#> Error in my_awesome_custom_function("rain"): could not find function "my_awesome_custom_function"
```

<sup>Created on 2024-12-29 with [reprex v2.1.1](https://reprex.tidyverse.org)</sup>

By contrast, if we include the function definition:

```
my_awesome_custom_function <- function(x){print(paste0(x, " is awesome!"))}
my_awesome_custom_function("rain")
```

```
# In the console:
reprex()
```

``` r
my_awesome_custom_function <- function(x){print(paste0(x, " is awesome!"))}
my_awesome_custom_function("rain")
#> [1] "rain is awesome!"
```

<sup>Created on 2024-12-29 with [reprex v2.1.1](https://reprex.tidyverse.org)</sup>

## Other features of `{reprex}`

### Session Info
Another nice thing about `{reprex}` is that you can choose to include information about your R session, in case your error has something to do with your R settings rather than the code itself. You can do that using the `session_info` argument to `reprex()`.

For example:

```
library(ggplot2)
library(dplyr)
mpg %>% 
  ggplot(aes(x = factor(cyl), y = displ))+
  geom_boxplot()
```

```
# In the console:
reprex(session_info = TRUE)
```

``` r
library(ggplot2)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
mpg %>% 
  ggplot(aes(x = factor(cyl), y = displ))+
  geom_boxplot()
```

![](https://i.imgur.com/kHBf9Zr.png)<!-- -->

<sup>Created on 2024-12-29 with [reprex v2.1.1](https://reprex.tidyverse.org)</sup>

<details style="margin-bottom:10px;">
<summary>
Session info
</summary>

``` r
sessioninfo::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.4.2 (2024-10-31)
#>  os       macOS Monterey 12.7.6
#>  system   aarch64, darwin20
#>  ui       X11
#>  language (EN)
#>  collate  en_US.UTF-8
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2024-12-29
#>  pandoc   3.2 @ /Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools/aarch64/ (via rmarkdown)
#> 
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package     * version date (UTC) lib source
#>  cli           3.6.3   2024-06-21 [1] CRAN (R 4.4.0)
#>  colorspace    2.1-1   2024-07-26 [1] CRAN (R 4.4.0)
#>  curl          6.0.1   2024-11-20 [1] https://jeroen.r-universe.dev (R 4.4.2)
#>  digest        0.6.37  2024-08-19 [1] CRAN (R 4.4.1)
#>  dplyr       * 1.1.4   2023-11-17 [1] CRAN (R 4.4.0)
#>  evaluate      1.0.1   2024-10-10 [1] CRAN (R 4.4.1)
#>  fansi         1.0.6   2023-12-08 [1] CRAN (R 4.4.0)
#>  farver        2.1.2   2024-05-13 [1] CRAN (R 4.4.0)
#>  fastmap       1.2.0   2024-05-15 [1] CRAN (R 4.4.0)
#>  fs            1.6.5   2024-10-30 [1] CRAN (R 4.4.1)
#>  generics      0.1.3   2022-07-05 [1] CRAN (R 4.4.0)
#>  ggplot2     * 3.5.1   2024-04-23 [1] CRAN (R 4.4.0)
#>  glue          1.8.0   2024-09-30 [1] CRAN (R 4.4.1)
#>  gtable        0.3.6   2024-10-25 [1] CRAN (R 4.4.1)
#>  htmltools     0.5.8.1 2024-04-04 [1] CRAN (R 4.4.0)
#>  knitr         1.49    2024-11-08 [1] CRAN (R 4.4.1)
#>  labeling      0.4.3   2023-08-29 [1] CRAN (R 4.4.0)
#>  lifecycle     1.0.4   2023-11-07 [1] CRAN (R 4.4.0)
#>  magrittr      2.0.3   2022-03-30 [1] CRAN (R 4.4.0)
#>  munsell       0.5.1   2024-04-01 [1] CRAN (R 4.4.0)
#>  pillar        1.9.0   2023-03-22 [1] CRAN (R 4.4.0)
#>  pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.4.0)
#>  R6            2.5.1   2021-08-19 [1] CRAN (R 4.4.0)
#>  reprex        2.1.1   2024-07-06 [1] CRAN (R 4.4.0)
#>  rlang         1.1.4   2024-06-04 [1] CRAN (R 4.4.0)
#>  rmarkdown     2.29    2024-11-04 [1] CRAN (R 4.4.1)
#>  rstudioapi    0.17.1  2024-10-22 [1] CRAN (R 4.4.1)
#>  scales        1.3.0   2023-11-28 [1] CRAN (R 4.4.0)
#>  sessioninfo   1.2.2   2021-12-06 [1] CRAN (R 4.4.0)
#>  tibble        3.2.1   2023-03-20 [1] CRAN (R 4.4.0)
#>  tidyselect    1.2.1   2024-03-11 [1] CRAN (R 4.4.0)
#>  utf8          1.2.4   2023-10-22 [1] CRAN (R 4.4.0)
#>  vctrs         0.6.5   2023-12-01 [1] CRAN (R 4.4.0)
#>  withr         3.0.2   2024-10-28 [1] CRAN (R 4.4.1)
#>  xfun          0.49    2024-10-31 [1] CRAN (R 4.4.1)
#>  xml2          1.3.6   2023-12-04 [1] CRAN (R 4.4.0)
#>  yaml          2.3.10  2024-07-26 [1] CRAN (R 4.4.0)
#> 
#>  [1] /Library/Frameworks/R.framework/Versions/4.4-arm64/Resources/library
#> 
#> ──────────────────────────────────────────────────────────────────────────────
```

</details>

### Formatting

The output of `reprex()` is markdown, which can easily be copied and pasted into many sites/apps. However, different places have slightly different formatting conventions for markdown. `{reprex}` lets you customize the output of your reprex according to where you're planning to post it.

The default, `venue = "gh"`, gives you "[GitHub-Flavored Markdown](https://github.github.com/gfm/)". Another format you might want is "r", which gives you a runnable R script, with commented output interleaved.

Check out the formatting options in the help file with `?reprex`, and try out a few depending on the destination of your reprex!

::: callout
## `{reprex}` can't do everything for you!

People often mention `{reprex}` as a useful tool for creating reproducible examples, but it can't do the work of crafting the example for you! The package doesn't locate the problem, pare down the code, create a minimal dataset, or automatically include package dependencies.

A better way to think of `{reprex}` is as a tool to check your work as you go through the process of creating a reproducible example, and to help you polish up the result.
:::

## Testing it out

Now that we've met our new reprex-making collaborator, let's use it to test out the reproducible example we created in the previous episode.

Here's the code we wrote:

```
# This script will contain my minimal reproducible example.
# Created by Mishka on 2024-12-17

# Load packages needed for the analysis
library(dplyr)

# Provide a minimal dataset
years <- 1:4
species <- c("Species A", "Species B", "Species C")
plots <- c("Control", "Treatment")

total_records_per_year <- c(10, 12, 3, 30) # I chose these arbitrarily 
total_rows <- sum(total_records_per_year) # how many total rows will we have?

# Create the fake data using `rep()` and `sample()`.
minimal_data <- data.frame(year = rep(years, times = total_records_per_year),
                      plot_type = rep(plots, length.out = total_rows),
                      species_id = sample(species, size = total_rows, replace = TRUE)) # Because I assigned the species randomly, we should expect Species A to occur *roughly* 33% of the time.

# Calculate proportion of Species A caught
head(minimal_data)
prop_speciesA <- minimal_data %>%
  group_by(year, plot_type, species_id) %>%
  summarize(total_count = n(), .groups = "drop") %>%
  mutate(prop = total_count/sum(total_count)) %>%
  dplyr::filter(species_id == "Species A") # keep only Species A

head(prop_speciesA) # Species A only occurs 1-3% of the time in each plot type in each year. Why is this off by an order of magnitude? (This is the same problem I was seeing in my real data--the occurrence proportions were way, way too small.)
```

Time to find out if our example is actually reproducible! Let's copy it to the clipboard and run `reprex()`. Since we want to give Jordan a runnable R script, we can use `venue = "r"`.

```
# In the console:
reprex(venue = "r")
```

It worked!

```
# This script will contain my minimal reproducible example.
# Created by Mishka on 2024-12-17

# Load packages needed for the analysis
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

# Provide a minimal dataset
years <- 1:4
species <- c("Species A", "Species B", "Species C")
plots <- c("Control", "Treatment")

total_records_per_year <- c(10, 12, 3, 30) # I chose these arbitrarily 
total_rows <- sum(total_records_per_year) # how many total rows will we have?

# Create the fake data using `rep()` and `sample()`.
minimal_data <- data.frame(year = rep(years, times = total_records_per_year),
                      plot_type = rep(plots, length.out = total_rows),
                      species_id = sample(species, size = total_rows, replace = TRUE)) # Because I assigned the species randomly, we should expect Species A to occur *roughly* 33% of the time.

# Calculate proportion of Species A caught
head(minimal_data)
#>   year plot_type species_id
#> 1    1   Control  Species A
#> 2    1 Treatment  Species A
#> 3    1   Control  Species A
#> 4    1 Treatment  Species B
#> 5    1   Control  Species C
#> 6    1 Treatment  Species A
prop_speciesA <- minimal_data %>%
  group_by(year, plot_type, species_id) %>%
  summarize(total_count = n(), .groups = "drop") %>%
  mutate(prop = total_count/sum(total_count)) %>%
  dplyr::filter(species_id == "Species A") # keep only Species A

head(prop_speciesA) # Species A only occurs 1-3% of the time in each plot type in each year. Why is this off by an order of magnitude? (This is the same problem I was seeing in my real data--the occurrence proportions were way, way too small.)
#> # A tibble: 6 × 5
#>    year plot_type species_id total_count   prop
#>   <int> <chr>     <chr>            <int>  <dbl>
#> 1     1 Control   Species A            2 0.0364
#> 2     1 Treatment Species A            2 0.0364
#> 3     2 Control   Species A            1 0.0182
#> 4     2 Treatment Species A            1 0.0182
#> 5     3 Control   Species A            2 0.0364
#> 6     4 Control   Species A            4 0.0727
```

Now we have a beautifully-formatted reprex that includes runnable code and all the context needed to reproduce the problem.

It's time to send another email to Jordan to finally get help with our problem. It's important to include a brief description of the problem, including what we were hoping to achieve and what the problem seems to be.

> Hi Jordan,
> I took some time to learn how to write reproducible examples. I've simplified my problem down to a "reprex" and formatted it with the `{reprex}` package (attached). I'm using a simplified dataset here, but hopefully it illustrates the problem.
> Basically, my data has three species, and I'm trying to calculate the proportion of each species that was caught in each plot type in each of several years. In the example, I would expect each species to come up approximately one third of the time, but instead I'm seeing really tiny proportions, like 1-3%. My real data shows a similar pattern.
> I think something must be wrong with how I'm calculating the proportions, but I can't quite figure it out. Can you shed some light on what might be going on?
> Thanks so much!
> Mishka
> Attachment: reprex-script.R

XXX how should this end? Some possibilities:
- no solution! The point wasn't to find the solution, it was to create a reprex.
- Jordan writes back and solves the problem
- Mishka figures out what was wrong in the process of drafting the email
- Something else?
