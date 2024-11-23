---
title: "Minimal Reproducible Code"
teaching: 40
exercises: 35
---

::: questions
- Why can't I just post my whole script?
- Which parts of my code are directly relevant to my problem?
- Which parts of my code are necessary in order for the problem area to run correctly?
- I feel overwhelmed by this script--where do I even start?
:::

::: objectives
- Explain the value of a minimal code snippet.
- Simplify a script down to a minimal code example.
- Identify the problem area of the code.
- Identify supporting parts of the code that are essential to include.
- Identify pieces of code that can be removed without affecting the central functionality.
- Have a road map to follow to simplify your code.
:::

You're excited by how much progress you're making in your research. You've made a lot of descriptive plots and gained some interesting insights into your data. Now you're excited to investigate whether the k-rat exclusion plots are actually working. You set to work writing a bunch of code to do this, using a combination of descriptive visualizations and linear models.

So far, you've been saving all of your analysis in a script called "krat-analysis.R". At this point, it looks something like this:

``` r
# Kangaroo rat analysis using the Portal data
# Created by: Research McResearchface
# Last updated: 2024-11-22

# Load packages to use in this script
library(readr)
library(dplyr)
library(ggplot2)
library(stringr)

# Read in the data
rodents <- read_csv("scripts/data/surveys_complete_77_89.csv")

### DATA WRANGLING ####
glimpse(rodents) # or click on the environment
str(rodents) # an alternative that does the same thing
head(rodents) # or open fully with View() or click in environment

table(rodents$taxa)

# Abundance distribution of taxa
rodents %>%
  ggplot(aes(x=taxa))+
  geom_bar()
  
# Examine NA values
## How do we find NAs anyway? ----
head(is.na(rodents$taxa)) # logical--tells us when an observation is an NA (T or F)

# Not very helpful. BUT
sum(is.na(rodents$taxa)) # sum considers T = 1 and F = 0

# Simplify down to just rodents
rodents <- rodents %>%
  filter(taxa == "Rodent")
glimpse(rodents)

# Just kangaroo rats because this is what we are studying
krats <- rodents %>%
  filter(genus == "Dipodomys")
dim(krats) # okay, so that's a lot smaller, great.
glimpse(krats)

# Prep for time analysis
# To examine trends over time, we'll need to create a date column
krats <- krats %>%
  mutate(date = lubridate::ymd(paste(year, month, day, sep = "-")))
  
# Examine differences in different time periods
krats <- krats %>%
  mutate(time_period = ifelse(year < 1988, "early", "late"))

# Check that this went through; check for NAs
table(krats$time_period, exclude = NULL) # learned how to do this earlier

### QUESTION 1: How many k-rats over time in the past? ###
# How many kangaroo rats of each species were found at the study site in past years (so you know what to expect for a sample size this year)?

# Numbers over time by plot type
krats %>%
  ggplot(aes(x = date, fill = plot_type)) +
  geom_histogram()+
  facet_wrap(~species)+ 
  theme_bw()+
  scale_fill_viridis_d(option = "plasma")+
  geom_vline(aes(xintercept = lubridate::ymd("1988-01-01")), col = "dodgerblue")
  
# Oops we gotta get rid of the unidentified k-rats
krats <- krats %>%
  filter(species != "sp.")
  
# Re-do the plot above
krats %>%
  ggplot(aes(x = date, fill = plot_type)) +
  geom_histogram()+
  facet_wrap(~species)+ 
  theme_bw()+
  scale_fill_viridis_d(option = "plasma")+
  geom_vline(aes(xintercept = lubridate::ymd("1988-01-01")), col = "dodgerblue")
  
# How many individuals caught per day?
krats_per_day <- krats %>%
  group_by(date, year, species) %>%
  summarize(n = n()) %>%
  group_by(species)

krats_per_day %>%
  ggplot(aes(x = species, y = n))+
  geom_boxplot(outlier.shape = NA)+
  geom_jitter(width = 0.2, alpha = 0.2, aes(col = year))+
  theme_classic()+
  ylab("Number per day")+
  xlab("Species")
  
#### QUESTION 2: Do the k-rat exclusion plots work? #####
# Do the k-rat exclusion plots work? (i.e. Does the abundance of each species differ by plot?)
# If the k-rat plots work, then we would expect:
# A. Fewer k-rats overall in any of the exclusion plots than in the control, with the fewest in the long-term k-rat exclusion plot
counts_per_day <- krats %>%
  group_by(year, plot_id, plot_type, month, day, species_id) %>%
  summarize(count_per_day = n())

counts_per_day %>%
  ggplot(aes(x = plot_type, y = count_per_day, fill = species_id, group = interaction(plot_type, species_id)))+
  geom_boxplot(outlier.size = 0.5)+
  theme_minimal()+
  labs(title = "Kangaroo rat captures, all years",
       x = "Plot type",
       y = "Individuals per day",
       fill = "Species")

# B. For Spectabilis-specific exclosure, we expect a lower proportion of spectabilis there than in the other plots.
control_spectab <- krats %>%
  filter(plot_type %in% c("Control", "Spectab exclosure"))

prop_spectab <- control_spectab %>%
  group_by(year, plot_type, species_id) %>%
  summarize(total_count = n(), .groups = "drop_last") %>%
  mutate(prop = total_count/sum(total_count)) %>%
  filter(species_id == "DS") # keep only spectabilis

prop_spectab %>%
  ggplot(aes(x = year, y = prop, col = plot_type))+
  geom_point()+
  geom_line()+
  theme_minimal()+
  labs(title = "Spectab exclosures did not reduce proportion of\nspectab captures",
       y = "Spectabilis proportion",
       x = "Year",
       color = "Plot type")

#### MODELING ####
counts_mod <- lm(count_per_day ~ plot_type + species_id, data = counts_per_day)
summary(counts_mod)

# with interaction term: 
counts_mod_interact <- lm(count_per_day ~ plot_type*species_id, data = counts_per_day)
summary(counts_mod_interact)

summary(counts_mod)
summary(counts_mod_interact)
```

## Why is it important to simplify code?

Learning how to simplify your code is one of the most important parts of making a minimal reproducible example, asking others for help, and helping yourself.

::::::::::::::::::::::::::::::::::::::::::: challenge
## Making sense of code

Reflect on a time when you opened a coding project after a long time away from it. Or maybe you had to look through and try to run someone else's code.

(If you have easy access to one of your past projects, maybe try opening it now and taking a look through it right now!)

How do situations like this make you feel? Write some reflections on the Etherpad.

This exercise should take about 5 minutes.
::::::::::::::::::::::::::::::::::::::::::: 

Debugging is a time when it's common to have to read through long and complex code (either your own or someone else's). That means that the person doing the debugging is likely to experience some of the emotions we just talked about.

The more we can reduce the negative emotions and make the experience of solving errors easy and painless, the likelier you are to find solutions to your problems (or convince others to take the time to help you). Helpers are doing us a favor--why put barriers in their way?

Let's illustrate the importance of simplifying our code by focusing on an error in the big long analysis script we created, shown above. Let's imagine we're getting ready to show these preliminary results to our advisor, but when we re-run the whole script, we realize there's a problem.

[DESCRIPTION OF PROBLEM HERE]

## A road map for simplifying your code

In this episode, we're going to walk through a road map for breaking your code down to its simplest form while making sure that 1) it still runs, and 2) it reproduces the problem you care about solving.

For now, we'll go through this road map step by step. At the end, we'll review the whole thing. One takeaway from this lesson is that there is a step by step process to follow, and you can refer back to it if you feel lost in the future.

### Step 0. Create a separate script

When we know there's a problem with our script, it helps to start solving it by examining smaller parts of the code in a separate script, instead of editing the original.

:::::::::::::::::::::::::::::::::::::challenge
## A separate place for minimal code

Create a new, blank R script and give it a name, such as "reprex-script.R"

There are several ways to make an R script
- File > New File > R Script
- Click the white square with a green plus sign at the top left corner of your RStudio window
- Use a keyboard shortcut: Cmd + Shift + N (on a Mac) or Ctrl + Shift + N (on Windows)

Once you've created the script, click the Save button to name and save it.

This exercise should take about 2 minutes.
::::::::::::::::::::::::::::::::::::::::::: 

### Step 1. Identify the problem area

Now that we have a script, let's zero in on what's broken.

First, we should use some of the techniques we learned in the "Identify the Problem" episode and see if they help us solve our error.

[MORE CONTENT THAT CALLS BACK TO PL'S EPISODE HERE]

In this particular case, though, we weren't able to completely resolve our error.

[WHY? maybe because it's not an error but a case of "the plot isn't returning what we want"? Or maybe it's an extra difficult error message that we can't find an easy answer to?

I need to figure out what error to introduce into the script in the first place... that will determine the justification to use here.]

(*Using the plot example for now*)

Okay, so we know that the plot doesn't look the way we want it to. Which part of the code created that plot? One way to figure this out if we're not sure is to step through the code line by line.

:::::::::::::::::::::::::::::::::::::callout
## Stepping through code, line by line

Placing your cursor on a line of code and using the keyboard shortcut Cmd + Enter (Mac) or Ctrl + Enter (Windows) will run that line of code *and* it will automatically advance your cursor to the next line. This makes it easy to "step through" your code without having to click or highlight.
::::::::::::::::::::::::::::::::::::::::::: 

Yay, we found the trouble spot! Let's go ahead and copy that line of code and paste it over into the empty script we created, "reprex-script.R".

### Step 2. Give context: functions and packages

R code consists primarily of *variables* and *functions*. 

::::::::::::::::::::::::::::::::::::::::::: challenge
## Where do functions come from?

When coding in R, we use a lot of different functions. Where do those functions come from? How can we make sure that our helpers have access to those sources? Take a moment to brainstorm.

This exercise should take about 3 minutes.
::::::::::::::::::::::::::::::::::::::::::: 
::: solution
Functions in R typically come from packages. Some packages, such as `{base}` and `{stats}`, are loaded in R by default, so you might not have realized that they are packages too.

You can see a complete list of functions in `{base}` and `{stats}` by running `library(help = "base")` or `library(help = "stats")`.

Some functions might be user-defined. In that case, you'll need to make sure to include the function definition in your reprex.
:::

::::::::::::::::::::::::::::::::::::::::::: callout
## Finding functions

Sometimes it can be hard to figure out where a function comes from. Especially if a function comes from a package you use frequently, you might not remember where it comes from!

You can search for a function in the help docs with `??fun` (where "fun" is the name of the function). To explicitly declare which package a function comes from, you can use a double colon `::`--for example, `dplyr::select()`. Declaring the function with a double colon also allows you to use that function even if the package is not loaded, as long as it's installed.
:::::::::::::::::::::::::::::::::::::::::::

The quickest way to make sure others have access to the functions contained in packages is to include a `library()` call in your reprex, so they know to load the package too.

::::::::::::::::::::::::::::::::::::::::::: challenge
## Which packages are essential?

In each of the following code snippets, identify the necessary packages (or other code) to make the example reproducible.

- [Example (including an ambiguous function: `dplyr::select()` is a good one because it masks `plyr::select()`)]
- [Example where you have to look up which package a function comes from]
- [Example with a user-defined function that doesn't exist in any package]

This exercise should take about 5 minutes.
::::::::::::::::::::::::::::::::::::::::::: 
::: solution
FIXME
:::

Looking through the problem area that we isolated, we can see that we'll need to load the following packages: FIXME
- `{package}`
- `{package}`
- `{package}`

Let's go ahead and add those as `library()` calls to the top of our script.

::::::::::::::::::::::::::::::::::::::::::: callout
## Installing vs. loading packages

But what if our helper doesn't have all of these packages installed? Won't the code not be reproducible?

Typically, we don't include `install.packages()` in our code for each of the packages that we include in the `library()` calls, because `install.packages()` is a one-time piece of code that doesn't need to be repeated every time the script is run. We assume that our helper will see `library(specialpackage)` and know that they need to go install "specialpackage" on their own.

Technically, this makes that part of the code not reproducible! But it's also much more "polite". Our helper might have their own way of managing package versions, and forcing them to install a package when they run our code risks messing up our workflow. It is a common convention to stick with `library()` and let them figure it out from there.
FIXME this feels over-explained... pare it down!
:::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::: callout
## Installing packages conditionally

There is an alternative approach to installing packages [insert content/example of the if(require()) thing--but note that explaining this properly requires explaining why require() is different from library(), why it returns a logical, etc. and is kind of a rabbit hole that I don't want to go down here.]
::::::::::::::::::::::::::::::::::::::::::: 

### Step 3. Give context: variables and datasets

Isolating the problem area and loading the necessary packages and functions was an important step to making our example code self-contained. But we're still not done making the code minimal and reproducible. Almost certainly, our code snippet relies on variables, such as datasets, that our helper won't have access to.

The piece of code that we copied over came from line [LINE NUMBER] of our analysis script. We had done a lot of analyses before then, including modifying datasets and creating intermediate objects/variables. 

Our code snippet depends on all those previous steps, so when we isolate it in a new script, it might not be able to run anymore. More importantly, when a helper doesn't have access to the rest of our script, the code might not run for them either.

To fix this, we need to provide some additional context around our reprex so that it runs. 

::::::::::::::::::::::::::::::::::::::::::: challenge
## Identifying variables

For each of the following code snippets, identify all the variables used

- [Straightforward example]
- [Example where they use a built-in dataset but it contains a column that that dataset doesn't actually contain, i.e. because it's been modified previously. Might be good to use the `date` column that we put into `krats` for this]

This exercise should take about 5 minutes.
::::::::::::::::::::::::::::::::::::::::::: 
::: solution
FIXME
:::

As you might have noticed, identifying these variables isn't always straightforward. Sometimes variables depend on other variables, and before you know it, you end up needing the entire script.

Let's work together as a group to sketch out which variables depend on which others. A helpful way to do this is to start with the variables included in our code snippet and ask, for each one, "Where did this come from?"

[Make a big dependency graph. The point is to illustrate that it gets very long and you can't always rely on this process to identify a simple way to include the needed variables.]

How can we make sure that helpers can access these objects too, without providing them the entire long script?

Theoretically, we could meticulously trace each object back and make sure to include the code to create all of its predecessors from the original data, which we would provide to our helper. But pretty soon, we might find that we're just giving the helper the original (long, complicated) script!

As with other types of writing, creating a good minimal reprex takes hard work and time.

> "I would have written a shorter letter, but I did not have the time."
>
> - Blaise Pascal, *Lettres Provinciales*, 1657


::::::::::::::::::::::::::::::::::::::::::: callout
## Computational reproducibility

Every object should be able to map back to either a file, a built-in dataset in R, or another intermediate step. If you found any variables where you weren't able to answer the "Where did this come from?" question, then that's a problem! Did you build a script that mistakenly relied on an object that was in your environment but was never properly defined?

Mapping exercises like this can be a great way to check whether entire script is reproducible. Reproducibility is important in more cases than just debugging! More and more journals are requiring full analysis code to be posted, and if that code isn't reproducible, it will severely hamper other researchers' efforts to confirm and expand on what you've done.

Various packages can help you keep track of your code and make it more reproducible. Check out the [`{targets}`](https://books.ropensci.org/targets/) and [`{renv}`](https://rstudio.github.io/renv/articles/renv.html) packages in particular if you're interested in learning more.
::::::::::::::::::::::::::::::::::::::::::: 

Luckily, we can make our lives easier if we realize that helpers don't always need the exact same variables and datasets, just reasonably good stand-ins. Let's think back to the last episode, where we talked about different ways to create minimal reproducible datasets. We can lean on those skills here to make our example reproducible and greatly reduce the amount of code that we need to include.

:::::::::::::::::::::::::::::::::::::::::::challenge
## Incorporating minimal datasets

Brainstorm some places in our reprex where you could use minimal reproducible data to make your problem area code snippet reproducible.

Which of the techniques from the [data episode](LINK TO DATA EPISODE) will you choose in each case, and why?

This exercise should take about 5 minutes.
::::::::::::::::::::::::::::::::::::::::::: 
::: solution
FIXME
:::

_**Using a minimal dataset simplifies not just your data but also your code, because it lets you avoid including data wrangling steps in your reprex!**_

### Step 4. Simplify

We're almost done! Now we have code that runs because it includes the necessary `library()` calls and makes use of minimal datasets that still allow us to showcase the problem. Our script is almost ready to send to our helpers.

But reading someone else's code can be slow! We want to make it very, very easy for our helper to see which part of the code is important to focus on. Let's see if there are any places where we can trim code down even more to eliminate distractions.

Often, analysis code contains exploratory steps or other analyses that don't directly relate to the problem, such as calls to `head()`, `View()`, `str()`, or similar functions. (Exception: if you're using these directly to show things like dimension changes that help to illustrate the problem).

Some other common examples are exploratory analyses, extra formatting added to plots, and [ANOTHER EXAMPLE].

When cutting these things, we have to be careful not to remove anything that would cause the code to no longer reproduce our problem. In general, it's a good idea to comment out the line you think is extraneous, re-run the code, and check that the focal problem persists before removing it entirely.

:::::::::::::::::::::::::::::::::::::::::::challenge
## Trimming down the bells and whistles

[Ex: removing various things, observing what happens, identifying whether or not we care about those things. (Need to include at least one that's tricky, like maybe it does change the actual values but it doesn't change their relationship to each other)]

This exercise should take about 5 minutes.
::::::::::::::::::::::::::::::::::::::::::: 
::: solution
FIXME
:::

Great work! We've created a minimal reproducible example. In the next episode, we'll learn about `{reprex}`, a package that can help us double-check that our example is reproducible by running it in a clean environment. (As an added bonus, `{reprex}` will format our example nicely so it's easy to post to places like Slack, GitHub, and StackOverflow.)

More on that soon. For now, let's review the road map that we just practiced.

## Road map review
### Step 0. Create a separate script
  - It helps to have a separate place to work on your minimal code snippet.
  
### Step 1. Identify the problem area
  - Which part of the code is causing the problem? Move it over to the reprex script so we can focus on it.
  
### Step 2. Give context: functions and packages
  - Make sure that helpers have access to all the functions they'll need to run your code snippet.
  
### Step 3. Give context: variables and datasets
  - Make sure that helpers have access to all the variables they'll need to run your code snippet, or reasonable stand-ins.
  
### Step 4. Simplify
  - Remove any extra code that isn't absolutely necessary to demonstrate your problem.

:::::::::::::::::::::::::::::::::::::::::::challenge
## Reflection

Let's take a moment to reflect on this process.

- What's one thing you learned in this episode? An insight; a new skill; a process?

- What is one thing you're still confused about? What questions do you have?

This exercise should take about 5 minutes.
::::::::::::::::::::::::::::::::::::::::::: 
