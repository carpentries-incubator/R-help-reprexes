---
title: "Minimal Reproducible Code"
teaching: 40
exercises: 35
---

::: questions
- Why is it important to make a minimal code example?
- Which part of my code is causing the problem?
- Which parts of my code should I include in a minimal example?
- How can I tell whether a code snippet is reproducible or not?
- How can I make my code reproducible?
:::

::: objectives
- Explain the value of a minimal code snippet.
- Identify the problem area of a script.
- Identify supporting parts of the code that are essential to include.
- Simplify a script down to a minimal code example.
- Evaluate whether a piece of code is reproducible as is or not. If not, identify what is missing.
- Edit a piece of code to make it reproducible
- Have a road map to follow to simplify your code.
- Describe the {reprex} package and its uses
:::


``` r
library(tidyverse)
```

``` output
── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
✔ dplyr     1.1.4     ✔ readr     2.1.5
✔ forcats   1.0.0     ✔ stringr   1.5.1
✔ ggplot2   3.5.1     ✔ tibble    3.2.1
✔ lubridate 1.9.3     ✔ tidyr     1.3.1
✔ purrr     1.0.2     
── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

``` r
library(ratdat)
library(here)
```

``` output
here() starts at /home/runner/work/R-help-reprexes/R-help-reprexes/site/built
```

``` r
source(here("scripts/krat-analysis.R"))
```

``` warning
Warning in file(filename, "r", encoding = encoding): cannot open file
'/home/runner/work/R-help-reprexes/R-help-reprexes/site/built/scripts/krat-analysis.R':
No such file or directory
```

``` error
Error in file(filename, "r", encoding = encoding): cannot open the connection
```


You're happy with the progress you've made in exploring your data, and you're excited to move on to your second research question: Do the k-rat exclusion plots actually exclude k-rats?

You start by making a couple predictions. 

Prediction 1: If the k-rat plots work, then we would expect to see fewer k-rats in the k-rat exclusion plots than in the control, with the fewest in the long-term k-rat exclosure plot.

Second, if the k-rat plots work, then we would expect a lower proportion of *spectabilis* in the *spectabilis*-specific exclosure than in the control plot, regardless of the absolute number of k-rats caught.

You start by computing summary counts of the number of k-rats per day in the control and the two k-rat exclosure plots, and then using boxplots to show the differences between daily counts in each plot type. 


``` r
# Prediction 1: expect fewer k-rats in exclusion plots than in control plot
# Count number of k-rats per day, per plot type
counts_per_day <- krats %>%
  filter(plot_type %in% c("Control", "Long-term Krat Exclosure", "Short-term Krat Exclosure")) %>%
  group_by(year, plot_id, plot_type, month, day) %>%
  summarize(count_per_day = n(), .groups = "drop")
```

``` error
Error: object 'krats' not found
```

``` r
# Visualize
counts_per_day %>%
  ggplot(aes(x = plot_type, y = count_per_day, fill = plot_type))+
  geom_boxplot(outlier.size = 0.5)+
  theme_minimal()+
  labs(title = "Kangaroo rat captures, all years",
       x = "Plot type",
       y = "Individuals per day")+
  theme(legend.position = "none")
```

``` error
Error: object 'counts_per_day' not found
```

This is a coarse analysis that doesn't compare numbers on the same day against each other, but even so, our prediction is supported. The fewest k-rats are caught per day in the Long-term Krat Exclosure plots, followed by the Short-term Krat Exclosure. The Control plots have the largest number of Krats.

Next, you decide to test the second prediction: that there will be proportionally fewer *spectabilis* caught in the *spectabilis* exclusion plots than in the control plot.

You restrict the data to just the control and *spectabilis* exclosure plots. Then you calculate the number and proportion of each species of k-rat caught in each plot and visualize the proportions for *spectabilis.*


``` r
# Focus in on the control and spectab exclosure plots
control_spectab <- krats %>%
  filter(plot_type %in% c("Control", "Spectab exclosure"))
```

``` error
Error: object 'krats' not found
```

``` r
# Calculate proportion of spectabilis caught
head(control_spectab)
```

``` error
Error: object 'control_spectab' not found
```

``` r
prop_spectab <- control_spectab %>%
  group_by(year, plot_type, species_id) %>%
  summarize(total_count = n(), .groups = "drop") %>%
  mutate(prop = total_count/sum(total_count)) %>%
  filter(species_id == "DS") # keep only spectabilis
```

``` error
Error: object 'control_spectab' not found
```

``` r
# Visualize proportions
prop_spectab %>%
  ggplot(aes(x = year, y = prop, col = plot_type))+
  geom_point()+
  geom_line()+
  theme_minimal()+
  labs(title = "Spectab exclosures reduced the proportion of spectab captures",
       y = "Spectabilis proportion",
       x = "Year",
       color = "Plot type")
```

``` error
Error: object 'prop_spectab' not found
```

Interesting! In this analysis, we do see, as expected, that the *spectabilis* exclosure seems to have a consistently lower proportion of *spectabilis* than we see in the control plots. This supports our second prediction, and it also does a better job of getting at our research question because it's looking at proportions, not raw numbers.

But speaking of proportions... looking closer at the y-axis, we can see that something looks wrong. You remember from the previous plot that *merriami* was generally more common than the other two species, but you don't remember that *spectabilis* was quite this rare! Could it really be true that only 3% of the k-rats caught were *spectabilis* at the absolute highest? 

# XXX FIXME:
Here, I've presented this as though part of the mystery is figuring out whether there's something wrong with the data. That type of data sleuthing (is my code bad, or is my data bad??) is a really important skill, but I think it might be a bit tangential for us to focus on here. The easy way to have this stick to the LOs would be to have some ground truth that shows us for absolutely sure that <3% is wrong, which means it's the code that's bad, not the original data.

This seems wrong. But your code is running fine, so you're not really sure where your error is or how to start fixing it.

You're feeling overwhelmed, so you decide to ask your labmate, Jordan, for help. 
> Hi Jordan,
> I ran into a problem with my code today, and I'm wondering if you can help. I made this plot about kangaroo rat abundance in different plot types, but the proportions look weirdly low. I don't know what's wrong--can you help me figure it out? I'm attaching my script to this email.
> Thanks,
> Mishka
> Attachment: krat-analysis.R

You know that Jordan is a very experienced coder. If they look through your script, surely they'll be able to figure out what's going on much more quickly than you can!

::::::::::::::::::::::::::::::::::::::::::: challenge
## Making sense of someone else's code

Imagine you are Jordan, and you've in the middle of your own analysis when you receive this email. What reaction do you have? How do you feel about helping your lab mate? How would you feel if it were a complete stranger asking you for help instead?

Now, reflect on a time when you have had to look through and run someone else's code, or a time when you've opened your own coding project after a long time away from it. (If you have easy access to one of your past projects, maybe try opening it now and taking a look through it right now!)

How do situations like this make you feel? Turn to the person next to you and discuss for a minute (or write some reflections on the Etherpad).

This exercise should take about 3 minutes.
:::solution
FIXME: I think this is way too long and needs to be more targeted. We are trying to get them to realize that this is a frustrating/overwhelming/scary experience for the person in the helper role.

I am worried that people are going to use this time to start reflecting on the substance of the actual error. Maybe that's a reason to just focus it on a general time you've dealt with someone else's code, instead of "put yourself in Jordan's shoes"? I feel like I need to demo it with people to find out, though.

Suggestions for revising this challenge are welcome!
:::
:::::::::::::::::::::::::::::::::::::::::::

Jordan wants to help their labmate, but they are really busy. They've looked through enough code in the past to know that it will take a long time to make sense of yours. They email you back:

> Hi Mishka,
> I'd be happy to help, but this is a lot of code to go through without much context. Could you just show me the part that's most relevant? Maybe make a minimal example?
> Thanks,
> Jordan

## Why is it important to simplify code?

In order to get help from Jordan, we're going to need to do some work up front to make things easier for them. In general, learning how to simplify your code is one of the most important parts of making a minimal reproducible example, asking others for help, and helping yourself.

Debugging is a time when it's common to have to read through long and complex code (either your own or someone else's). The more we can reduce their frustration and overwhelm and make the experience of solving errors easy and painless, the more likely that others will want to take the time to help us. Helpers are doing us a favor--why put barriers in their way?

## A road map for simplifying your code

Sometimes, it can be challenging to know where to start simplifying your code. In this episode, we're going to walk through a road map for breaking your code down to its simplest form while making sure that 1) it still runs, and 2) it reproduces the problem you care about solving.

For now, we'll go through this road map step by step. At the end, we'll review the whole thing. One takeaway from this lesson is that there is a step by step process to follow, and you can refer back to it if you feel lost in the future.

### Step 0. Create a separate script

To begin creating a simpler piece of code to show Jordan, let's create a separate script. We can separate out small pieces of the code and craft the perfect minimal example while still keeping the original analysis intact.

Create and save a new, blank R script and give it a name, such as "reprex-script.R"


``` r
# This script will contain my minimal reproducible example.
# Created by Mishka on 2024-12-17
```

:::::::::::::::::::::::::::::::::::::callout
## Creating a new R script
There are several ways to make an R script
- File > New File > R Script
- Click the white square with a green plus sign at the top left corner of your RStudio window
- Use a keyboard shortcut: Cmd + Shift + N (on a Mac) or Ctrl + Shift + N (on Windows)
::::::::::::::::::::::::::::::::::::::::::: 

### Step 1. Identify the problem area

Now that we have a script, let's zero in on what's broken.

First, we should use some of the techniques we learned in the "Identify the Problem" episode and see if they help us solve our error.

XXX FIXME: Peter, let's make sure this follows nicely from your lesson. 
- Look for error messages or warnings --> there aren't any
- Google it --> not really informative

In this case, the debugging tips we learned weren't enough to help us figure out what was wrong with our code.

This is quite common, especially when you're faced with a **semantic error** (your code runs, but it doesn't produce the correct result).

In this case, we can start by identifying the piece of code that *showed us there was a problem*. We noticed the problem by looking at the plot, so that would be an obvious place to start. But is the plot code really the problem area? Maybe, or maybe not. We know that some weird values are showing up on the plot. That means that either there are weird values in the data that created the plot, or the values in the data looked okay and something happened when we created the plot.

To distinguish between those possibilities, let's take a look at the plot again:


``` r
# Visualize proportions
prop_spectab %>%
  ggplot(aes(x = year, y = prop, col = plot_type))+
  geom_point()+
  geom_line()+
  theme_minimal()+
  labs(title = "Spectab exclosures did not reduce proportion of\nspectab captures",
       y = "Spectabilis proportion",
       x = "Year",
       color = "Plot type")
```

``` error
Error: object 'prop_spectab' not found
```

...and then at the data used to generate that plot

``` r
head(prop_spectab)
```

``` error
Error: object 'prop_spectab' not found
```

Aha! The `prop` column of `prop_spectab` shows very small values, and those values correspond to the plot we created.

So it looks like the problem is in the data, not in the plot code itself. The plot was just what allowed us to see the problem in our data. This is often the case. Visualizations are important!

So instead of focusing on the plot, let's zoom in on the step right before the plot as our "problem area": the code that created the `prop_spectab` object. Let's copy and paste that section of code into the new script that we just created.


``` r
# This script will contain my minimal reproducible example.
# Created by Mishka on 2024-12-17

# Calculate proportion of spectabilis caught
head(control_spectab)
```

``` error
Error: object 'control_spectab' not found
```

``` r
prop_spectab <- control_spectab %>%
  group_by(year, plot_type, species_id) %>%
  summarize(total_count = n(), .groups = "drop") %>%
  mutate(prop = total_count/sum(total_count)) %>%
  filter(species_id == "DS") # keep only spectabilis
```

``` error
Error: object 'control_spectab' not found
```

Now the code is much smaller and easier to dig through! You decide to send this updated script along to Jordan. 

> Hi Jordan,
> Sorry about that! You're right, that was a lot of code to dig through. I've narrowed it down now to just focus on the part of the code that was causing the problem. The proportions of k-rats in the prop_spectab data frame are too small to make sense. Can you help me figure out why the proportions are wrong?
> Thank you,
> Mishka
> Attachment: reprex-script.R

Jordan gets your email and opens the script. They try to run your code, but they immediately run into some problems. They write back,

> Hey Mishka,
> This is almost there, but I can't run your code because I don't have the objects and packages it relies on. Can you elaborate on your example to make it runnable?
> Jordan

### Step 2. Identify dependencies

Jordan is right, of course--you gave them a minimal example of your code, but you didn't provide the context around that code to make it runnable for someone else. You need to provide the *dependencies* for your code, including the functions it uses and the datasets it relies on.

R code consists primarily of **functions** and **variables**. Making sure that we give our helpers access to all the functions and variables we use in our minimal code will make our examples truly reproducible.

Let's talk about **functions** first. When we code in R, we use a lot of different functions. Functions in R typically come from packages, and you get access to them by loading the package into your environment. (Some packages, such as `{base}` and `{stats}`, are loaded in R by default, so you might not have realized that a lot of functions, such as `dim`, `colSums`, `factor`, and `length` actually come from those packages!)

::: callout
You can see a complete list of the functions that come from the `{base}` and `{stats}` packages by running `library(help = "base")` or `library(help = "stats")`.
:::

To make sure that your helper has access to the functions necessary for your reprex, you can include a `library()` call in your reprex. 

Let's do this for our own reprex. We can start by identifying all the functions used, and then we can figure out where each function comes from to make sure that we tell our helper to load the right packages.

Here's what our script looks like so far.


``` r
# This script will contain my minimal reproducible example.
# Created by Mishka on 2024-12-17

# Calculate proportion of spectabilis caught
head(control_spectab)
```

``` error
Error: object 'control_spectab' not found
```

``` r
prop_spectab <- control_spectab %>%
  group_by(year, plot_type, species_id) %>%
  summarize(total_count = n(), .groups = "drop") %>%
  mutate(prop = total_count/sum(total_count)) %>%
  filter(species_id == "DS") # keep only spectabilis
```

``` error
Error: object 'control_spectab' not found
```

You look through the script and list out the following functions:
`head()`
`group_by()`
`summarize()`
`n()`
`mutate()`
`sum()`
`filter()`

:::callout
`%>%` is technically an operator, not a function...
FIXME note: `%>%` is an operator that also needs dplyr to be loaded. It might be relevant because the literal error that Jordan will get first is one about %>% if they don't have that loaded. But it's also exhausting to talk about and it might confuse people. By the time they finish loading {dplyr} for the sake of the other functions, the %>% will be included with {dplyr} and it will no longer be a problem. Hmm...
:::

You remember from your introductory R lesson that `group_by()` and `summarize()` are both functions that come from the `{dplyr}` package, so you can go ahead and add `library(dplyr)` to the top of your script.


``` r
# This script will contain my minimal reproducible example.
# Created by Mishka on 2024-12-17

# Load packages needed for the analysis
library(dplyr)

# Calculate proportion of spectabilis caught
head(control_spectab)
```

``` error
Error: object 'control_spectab' not found
```

``` r
prop_spectab <- control_spectab %>%
  group_by(year, plot_type, species_id) %>%
  summarize(total_count = n(), .groups = "drop") %>%
  mutate(prop = total_count/sum(total_count)) %>%
  filter(species_id == "DS") # keep only spectabilis
```

``` error
Error: object 'control_spectab' not found
```

You're pretty sure that `mutate()` and `filter()` also come from `{dplyr}`, but you're not sure. And you don't know where `n()` and `sum()` come from at all!

Some functions might be created, or "defined", in your code itself, instead of being contained in a package.  

It's pretty common not to remember where functions come from, especially if they belong to packages you use regularly. Let's try searching for the `sum()` function in the documentation.

In the "Help" tab of your RStudio window (which should be next to the "Packages" and "Viewer" tabs in the bottom right pane of RStudio if you have the default layout), search for "sum".

[INCLUDE SCREENSHOT OF SUM HELP DOCS HERE]

The top of the help file says `sum {base}`, which means that `sum()` is a function that comes from the `{base}` package. That's good for us--everyone has `{base}` loaded by default in R, so we don't need to tell our helper to load any additional packages in order to be able to access sum.

Let's confirm that we remembered correctly about `mutate()` and `filter()` by searching for the documentation on those as well.

Searching for "mutate" quickly shows us the help file for `mutate {dplyr}`, but searching for "filter" gives a long list of possible functions, all called `filter`. You look around a little bit and realize that the `filter` function you're using is also from the `{dplyr}` package. It might be a good idea to explicitly declare that in your code, in case your helper already has one of these other packages loaded.

::: callout
Maybe something about functions masking other functions? Or is that too much?
:::

You can explicitly declare which package a function comes from using a double colon `::`--for example, `dplyr::filter()`. (Declaring the function with a double colon also allows you to use that function even if the package is not loaded, as long as it's installed.)

Let's add that to our script, so that it's really clear which `filter()` we're using.


``` r
# This script will contain my minimal reproducible example.
# Created by Mishka on 2024-12-17

# Load packages needed for the analysis
library(dplyr)

# Calculate proportion of spectabilis caught
head(control_spectab)
```

``` error
Error: object 'control_spectab' not found
```

``` r
prop_spectab <- control_spectab %>%
  group_by(year, plot_type, species_id) %>%
  summarize(total_count = n(), .groups = "drop") %>%
  mutate(prop = total_count/sum(total_count)) %>%
  dplyr::filter(species_id == "DS") # keep only spectabilis
```

``` error
Error: object 'control_spectab' not found
```

The last function we need to find a source for is `n()`. Searching that in the Help files shows that it also comes from `{dplyr}`. Great! We don't need to consider any other packages, and the `library(dplyr)` line in our reprex script will tell our helper that the `{dplyr}` package is necessary to run our code. 

::::::::::::::::::::::::::::::::::::::::::: callout
## Installing vs. loading packages

But what if our helper doesn't have all of these packages installed? Won't the code not be reproducible?

Typically, we don't include `install.packages()` in our code for each of the packages that we include in the `library()` calls, because `install.packages()` is a one-time piece of code that doesn't need to be repeated every time the script is run. We assume that our helper will see `library(specialpackage)` and know that they need to go install "specialpackage" on their own.

Technically, this makes that part of the code not reproducible! But it's also much more "polite". Our helper might have their own way of managing package versions, and forcing them to install a package when they run our code risks messing up our workflow. It is a common convention to stick with `library()` and let them figure it out from there.
:::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::: challenge
## Which packages are essential?

In each of the following code snippets, identify the necessary packages (or other code) to make the example reproducible.

- [Example (including an ambiguous function: `dplyr::select()` is a good one because it masks `plyr::select()`)]
- [Example where you have to look up which package a function comes from]
- [Example with a user-defined function that doesn't exist in any package]

This exercise should take about 10 minutes.
:::solution
FIXME
:::
:::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::: callout
## Installing packages conditionally

There is an alternative approach to installing packages [insert content/example of the if(require()) thing--but note that explaining this properly requires explaining why require() is different from library(), why it returns a logical, etc. and is kind of a rabbit hole that I don't want to go down here.]
::::::::::::::::::::::::::::::::::::::::::: 

Including `library()` calls will definitely help Jordan be able to run your code. But another reason that your code still won't work as written is that Jordan doesn't have access to the same *objects*, or *variables*, that you used in the code.

The piece of code that we copied over to "reprex-script.R" from  "krat-analysis.R" came from line 117. We had done a lot of analyses before then, starting from the raw dataset and creating and modifying new objects along the way. 

You realize that Jordan doesn't have access to `control_spectab`, the dataset that the reprex relies on.

One way to fix this would be to add the code that creates `control_spectab` to the reprex, like this:


``` r
# This script will contain my minimal reproducible example.
# Created by Mishka on 2024-12-17

# Load packages needed for the analysis
library(dplyr)

# B. For Spectabilis-specific exclosure, we expect a lower proportion of spectabilis there than in the other plots.
control_spectab <- krats %>%
  filter(plot_type %in% c("Control", "Spectab exclosure"))
```

``` error
Error: object 'krats' not found
```

``` r
# Calculate proportion of spectabilis caught
head(control_spectab)
```

``` error
Error: object 'control_spectab' not found
```

``` r
prop_spectab <- control_spectab %>%
  group_by(year, plot_type, species_id) %>%
  summarize(total_count = n(), .groups = "drop") %>%
  mutate(prop = total_count/sum(total_count)) %>%
  dplyr::filter(species_id == "DS") # keep only spectabilis
```

``` error
Error: object 'control_spectab' not found
```

But that doesn't fix the problem either, because now Jordan doesn't have access to `krats`. Let's go back to where `krats` was created, on line 40:


``` r
# Just kangaroo rats because this is what we are studying
krats <- rodents %>%
  filter(genus == "Dipodomys")
```

``` error
Error: object 'rodents' not found
```

``` r
dim(krats) # okay, so that's a lot smaller, great.
```

``` error
Error: object 'krats' not found
```

``` r
glimpse(krats)
```

``` error
Error: object 'krats' not found
```

But there are several other places in the code where we modified `krats`, and we need to include those as well if we want our code to be truly reproducible. For example, on line 47, a date column was added, and on line 70 we removed unidentified k-rats. And even after including those, we would need to go back even farther, because the `rodents` object also isn't something that Jordan has access to! We called the raw data `rodents` after reading it in, and we also made several modifications, such as when we removed non-rodent taxa on line 35.
XXX This example would be better illustrated if we could actually show it breaking... like, if we think we've succeeded in tracing back far enough, and then it doesn't run because e.g. an essential column is missing/different.
XXX This is definitely too much detail... but I do want this section to at least partially feel like "aaaah information overload, too complicated!" because the point is to show how hard it is to trace every object backwards and convince them of the value of using minimal data.

::::::::::::::::::::::::::::::::::::::::::: challenge
## Identifying variables

For each of the following code snippets, identify all the variables used

- [Straightforward example]
- [Example where they use a built-in dataset but it contains a column that that dataset doesn't actually contain, i.e. because it's been modified previously. Might be good to use the `date` column that we put into `krats` for this]

This exercise should take about 5 minutes.
::: solution
TBH maybe we don't need this exercise at all, since we want to just redirect them to minimal data anyway?
:::
::::::::::::::::::::::::::::::::::::::::::: 

This process is confusing and difficult! If you keep tracing each variable back through your script, before you know it, you end up needing to include the entire script to give context, and then your code is no longer minimal.

We can make our lives easier if we realize that helpers don't always need the exact same variables and datasets that we were using, just reasonably good stand-ins. Let's think back to the last episode, where we talked about different ways to create minimal reproducible datasets. We can lean on those skills here to make our example reproducible and greatly reduce the amount of code that we need to include.

:::::::::::::::::::::::::::::::::::::::::::challenge
## Incorporating minimal datasets

What are some ways that you could use a minimal dataset to make this reprex better? What are the advantages and disadvantages of each approach?

This exercise should take about 5 minutes.
::: solution
Could provide the `control_spectab` file directly to Jordan, e.g. via email attachment. 
Advantages: less work, keeps the context, Jordan is a coworker so they probably understand it. 
Disadvantages: file might be large, relies on ability to email file, won't be able to use this method if you post the question online, file contains extra rows/columns that aren't actually necessary to this problem and might therefore be confusing.
  
Could create a new dataset from scratch. 
Advantages:
Disadvantages:
  
Could take a minimal subset of the `control_spectab` data and use `dput` or similar to include it directly
Advantages:
Disadvantages:

Could use a built-in dataset from R
Advantages:
Disadvantages:
:::
::::::::::::::::::::::::::::::::::::::::::: 

You decide that the easiest way to approach this particular problem would be to use a sample dataset to reproduce the problem.

Let's think about how to create a sample dataset that will accurately reproduce the problem.
What columns are needed to create `prop_spectab`, and what do we know about those columns?


``` r
head(control_spectab)
```

``` error
Error: object 'control_spectab' not found
```

``` r
length(unique(control_spectab$year)) # 13 years
```

``` error
Error: object 'control_spectab' not found
```

``` r
length(unique(control_spectab$species_id)) # three species
```

``` error
Error: object 'control_spectab' not found
```

``` r
length(unique(control_spectab$plot_type)) # two plot types
```

``` error
Error: object 'control_spectab' not found
```

Looks like we use `year`, which is numeric, and `plot_type` and `species_id`, which are both character types but have discrete levels like a factor. We have data from 13 years across two plot types, and there are three species that might occur.

Let's create some vectors. I'm only going to use four years here because 13 seems a little excessive.

I'm going to arbitrarily decide how many species records are present for each year, assign every other row to treatment or control, and randomly select species for each row.

``` r
years <- 1:4
species <- c("Species A", "Species B", "Species C")
plots <- c("Control", "Treatment")

total_records_per_year <- c(10, 12, 3, 30) # I chose these arbitrarily 
total_rows <- sum(total_records_per_year) # how many total rows will we have?

# Create the fake data using `rep()` and `sample()`.
minimal_data <- data.frame(year = rep(years, times = total_records_per_year),
                      plot_type = rep(plots, length.out = total_rows),
                      species_id = sample(species, size = total_rows, replace = TRUE))
```

We can go ahead and paste that into our reprex script. 


``` r
# Provide a minimal dataset
years <- 1:4
species <- c("Species A", "Species B", "Species C")
plots <- c("Control", "Treatment")

total_records_per_year <- c(10, 12, 3, 30) # I chose these arbitrarily 
total_rows <- sum(total_records_per_year) # how many total rows will we have?

# Create the fake data using `rep()` and `sample()`.
minimal_data <- data.frame(year = rep(years, times = total_records_per_year),
                      plot_type = rep(plots, length.out = total_rows),
                      species_id = sample(species, size = total_rows, replace = TRUE))
```

And finally, let's change our code to use `minimal_data` instead of `control_spectab`. (While we're at it, let's remove the piece of code that creates `control_spectab`--including a minimal dataset directly means that we don't need that code.)

Let's calculate the proportion of Species A caught, instead of spectabilis.


``` r
# Calculate proportion of Species A caught
head(minimal_data)
```

``` output
  year plot_type species_id
1    1   Control  Species B
2    1 Treatment  Species B
3    1   Control  Species C
4    1 Treatment  Species B
5    1   Control  Species A
6    1 Treatment  Species B
```

``` r
prop_speciesA <- minimal_data %>%
  group_by(year, plot_type, species_id) %>%
  summarize(total_count = n(), .groups = "drop") %>%
  mutate(prop = total_count/sum(total_count)) %>%
  dplyr::filter(species_id == "Species A") # keep only Species A
```

And now let's check to make sure that the code actually reproduces our problem. Remember, the problem was that the proportions of Species A caught seemed to be way too low based on what we knew about the frequency of occurrence of each k-rat species.

When we created our sample data, we randomly allocated species A, B, and C to each row. Even after accounting for the stratification of the years and plot types, we would expect the proportion of Species A caught to be somewhere vaguely around 0.33 in each plot type and year. If we've reproduced our problem correctly, we would see values much lower than 0.33.


``` r
head(prop_speciesA)
```

``` output
# A tibble: 5 × 5
   year plot_type species_id total_count   prop
  <int> <chr>     <chr>            <int>  <dbl>
1     1 Control   Species A            3 0.0545
2     1 Treatment Species A            2 0.0364
3     2 Control   Species A            2 0.0364
4     4 Control   Species A            6 0.109 
5     4 Treatment Species A            5 0.0909
```

Indeed, those proportions look way too low! 3%, 1%... that's an order of magnitude off from what we expect to see here. I think we have successfully reproduced the problem using a minimal dataset. To make things extra easy for Jordan, let's add some comments in the script to point out the problem.


``` r
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
```

``` output
  year plot_type species_id
1    1   Control  Species A
2    1 Treatment  Species C
3    1   Control  Species A
4    1 Treatment  Species A
5    1   Control  Species B
6    1 Treatment  Species C
```

``` r
prop_speciesA <- minimal_data %>%
  group_by(year, plot_type, species_id) %>%
  summarize(total_count = n(), .groups = "drop") %>%
  mutate(prop = total_count/sum(total_count)) %>%
  dplyr::filter(species_id == "Species A") # keep only Species A

head(prop_speciesA) # Species A only occurs 1-3% of the time in each plot type in each year. Why is this off by an order of magnitude? (This is the same problem I was seeing in my real data--the occurrence proportions were way, way too small.)
```

``` output
# A tibble: 6 × 5
   year plot_type species_id total_count   prop
  <int> <chr>     <chr>            <int>  <dbl>
1     1 Control   Species A            2 0.0364
2     1 Treatment Species A            2 0.0364
3     2 Control   Species A            2 0.0364
4     2 Treatment Species A            2 0.0364
5     3 Control   Species A            2 0.0364
6     3 Treatment Species A            1 0.0182
```

### Step 3. Simplify

We're almost done! Now we have code that runs because it includes the necessary `library()` calls and makes use of a minimal dataset that still allows us to showcase the problem. Our script is almost ready to send to Jordan. 

One last thing we can check is whether there are any other places where we can trim down the minimal example even more to eliminate distractions.

Often, analysis code contains exploratory steps or other analyses that don't directly relate to the problem, such as calls to `head()`, `View()`, `str()`, or similar functions. (Exception: if you're using these directly to show things like dimension changes that help to illustrate the problem).

Some other common examples are exploratory analyses, or extra formatting added to plots that doesn't change their interpretation.

:::callout
When cutting extra lines of code, we have to be careful not to remove anything that would cause the code to no longer reproduce our problem. In general, it's a good idea to comment out the line you think is extraneous, re-run the code, and check that the focal problem persists before removing it entirely.
:::

In our case, the code looks pretty minimal. We do have a call to `head()` at the end, but that's being used to clearly demonstrate the problem, so it should be left in. Trimming down the minimal dataset any further, for example by removing `plot_type` or `year`, would involve changing the analysis code and possibly not reproducing the problem anymore.

---
XXX @XOR @PL: I wish I had picked an example that had some extraneous parts to take out, such as a ggplot call with really long code. Would love to include that. Since I didn't, I think I can take out this entire section of the roadmap, or add it as a bonus exercise that gives a completely different example with a lot of extraneous things to remove. Another option would be to add some fluff to the original code so that we can remove that fluff now. Thoughts/preferences?
---

Great work! We've created a minimal reproducible example. In the next episode, we'll learn about `{reprex}`, a package that can help us double-check that our example is reproducible by running it in a clean environment. (As an added bonus, `{reprex}` will format our example nicely so it's easy to post to places like Slack, GitHub, and StackOverflow.)

More on that soon. For now, let's review the road map that we just practiced.

## Road map review
### Step 0. Create a separate script
  - It helps to have a separate place to work on your minimal code snippet.
  
### Step 1. Identify the problem area
  - Which part of the code is causing the problem? Move it over to the reprex script so we can focus on it.
  
### Step 2. Identify dependencies
  - Make sure that helpers have access to all the functions they'll need to run your code snippet.
  - Make sure helpers can access the variables they'll need to run the code, or reasonable stand-ins.
  
### Step 3. Simplify
  - Remove any extra code that isn't absolutely necessary to demonstrate your problem.

:::::::::::::::::::::::::::::::::::::::::::challenge
## Reflection

Let's take a moment to reflect on this process.

- What's one thing you learned in this episode? An insight; a new skill; a process?

- What is one thing you're still confused about? What questions do you have?

This exercise should take about 5 minutes.
::::::::::::::::::::::::::::::::::::::::::: 


# XXX maybe this story should end with Mishka solving their own problem.


### run an ANOVA or something
XXX Note: There's more to the analysis, and I only managed to walk through one example of an error. Is this example juicy enough? Should we just discard the rest of the analysis?
XXX Note: I actually think the analysis here is wrong and might need to be re-worked--would need to do pairwise comparisons.

#### MODELING ####
counts_mod <- lm(count_per_day ~ plot_type + species_id, data = counts_per_day)
summary(counts_mod)

# with interaction term:
counts_mod_interact <- lm(count_per_day ~ plot_type*species_id, data = counts_per_day)
summary(counts_mod_interact)

summary(counts_mod)
summary(counts_mod_interact)








:::::::::::::::::::::::::::::::::::::callout
## Stepping through code, line by line

Placing your cursor on a line of code and using the keyboard shortcut Cmd + Enter (Mac) or Ctrl + Enter (Windows) will run that line of code *and* it will automatically advance your cursor to the next line. This makes it easy to "step through" your code without having to click or highlight.
::::::::::::::::::::::::::::::::::::::::::: 


::::::::::::::::::::::::::::::::::::::::::: callout
## Computational reproducibility

Every object should be able to map back to either a file, a built-in dataset in R, or another intermediate step. If you found any variables where you weren't able to answer the "Where did this come from?" question, then that's a problem! Did you build a script that mistakenly relied on an object that was in your environment but was never properly defined?

Mapping exercises like this can be a great way to check whether entire script is reproducible. Reproducibility is important in more cases than just debugging! More and more journals are requiring full analysis code to be posted, and if that code isn't reproducible, it will severely hamper other researchers' efforts to confirm and expand on what you've done.

Various packages can help you keep track of your code and make it more reproducible. Check out the [`{targets}`](https://books.ropensci.org/targets/) and [`{renv}`](https://rstudio.github.io/renv/articles/renv.html) packages in particular if you're interested in learning more.
::::::::::::::::::::::::::::::::::::::::::: 
