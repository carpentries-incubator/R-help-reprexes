# We are researchers working on the Portal dataset.
# MOTIVATION:
# - You are a PhD student studying kangaroo rats.
# - In preparation for some fieldwork this year, you are analyzing an old dataset from your lab between 1977 and 1989. Your new fieldwork will attempt to replicate some of this, and you want to make sure you have a good handle on your focal organisms, several species of kangaroo rat.
# - You're somewhat familiar with this dataset, but this is your first time doing a deep dive on visualizing and analyzing it. You already know that the dataset contains information from rodent captures in various types of study plots. Body measurements were taken and many of the rodents were sexed.
# Some things you want to find out:
# 1. How many kangaroo rats of each species were found at the study site in past years (so you know what to expect for a sample size this year)?
# 2. What are the general morphological characteristics of the species? Can they be identified or even sexed by their body measurements?
# 3. What is the distribution of species in the different types of study plots?

# ``XOR: we need something at some point that becomes more complicated and requires more careful consideration of the code and errors within the code and how to replicate the code in a more minimal way. Here is an idea: 4. Run a simulation (?) to predict how many Krats will be caught next year given current competition for food.``

# Here are some packages we're going to need ----
library(readr)
library(dplyr)
library(ggplot2)
library(stringr)

# We can start by reading in our dataset from file ----
  # Instructor note: While this dataset now exists as a package we wanted to walk
  # through the concept that your data lives on your computer and is not accessible.

rodents <- read_csv("scripts/data/surveys_complete_77_89.csv")

# this spits out some information about the dataset already

# STEP 1: Identify the error ----

## Let's examine the dataset ----
# When we were out in the field, we recorded genus, species, the day, and each individual's weight and hindfoot length. Let's take a look at these to remind ourselves of what our dataset looks like:

glimpse(rodents) # or click on the environment
str(rodents) # an alternative that does the same thing
head(rodents) # or open fully with View() or click in environment

# Whoops, when I look at the data, I remember that we actually recorded data about more than just rodents. I can tell this because there's a `taxa` column that includes "Rodent" as an option. It also has other options.

table(rodents$taxa) # we have other stuff here too.

# ``XOR: why not visualize this too?``

## Plot: abundance distribution of taxa ----

ggplot(x=taxa) +
  geom_bar()

# "Error: object 'taxa' not found"

# Oops, we didn't tell ggplot where to get "taxa" from, since it is not an object (not in the environment)

rodents %>%
  ggplot(x=taxa)+
  geom_bar()

# Error in `geom_bar()`: --> where the error is
#   ! Problem while computing stat. --> why the error is happening
# ℹ Error occurred in the 1st layer.
# Caused by error in `setup_params()`: --> where the error is
#   ! `stat_count()` requires an x or y aesthetic. --> why the error is happening
# Run `rlang::last_trace()` to see where the error occurred.

# So where did we go wrong? What is the error message telling us?

# We forgot to give ggplot the aesthetics! "`stat_count()` requires an x or y aesthetic"

rodents %>%
  ggplot(aes(x=taxa))+
  geom_bar()

# Success! Except...

## Why are there NAs in the graph when there were no NAs in the table? ----
# Remember:
table(rodents$taxa)

# If we have NAs we want to know about them and we want to know how many!

# Troubleshoot: check the documentation for table()
?table

# The documentation is a bit confusing (aaahh!!), but don't fret, I often find an example of what I need at the bottom, under "Examples". Find the example that includes NAs.

table(rodents$taxa, exclude = NULL) # prevent it from excluding anything, so includes NAs

# OR

table(rodents$taxa, useNA="ifany")

## How do we find NAs anyway? ----

is.na(rodents$taxa) # logical--tells us when an observation is an NA (T or F)

# Not very helpful. BUT

sum(is.na(rodents$taxa)) # sum considers T = 1 and F = 0

## What to do with NAs ----
## - determine where they are being generated and why
## - determine whether they should be zeros or NAs
## - determine whether they should be removed

# Why do we have NAs? Shouldn't they have known at least the taxon??
# Were these actual NAs in the raw data, were they blank, or should they be zeros?

# ``XOR: I reckon they should be zeros, indicating that the plot was surveyed but no animals were found...

# ``XOR: another potential question is: were all plots sampled each sample day? Were all plots sampled the same number of times?

# STEP 2: Create a minimal reproducible dataset ----

# Back to our plot

rodents %>%
  ggplot(aes(x=taxa))+
  geom_bar()

# we have now decided we want to either get rid of the NAs, but we don't know how. We want to ask for help. We need a reprex. How do we create a minimal reproducible dataset for this question?

## What structural elements do we need to include? ----
## - 5 levels, (one with markedly fewer observations), some with NAs

## Dummy data from scratch ----

## Dummy data from a subset ----

## Use your actual data ----

## CHALLENGE: how do I make the Reptiles factor in the plot not look like zero?

## More story/more examples ----

### Maybe unnecessary ###
# Let's simplify it down to just the rodents!
rodents <- rodents %>%
  filter(taxa == "Rodent")
glimpse(rodents)
### ---

# We're interested in studying kangaroo rats. Let's see if we can find a way to filter down the data just to kangaroo rats.
# Kangaroo rats belong to the genus Dipodomys, so let's filter to that.
krats <- rodents %>%
  filter(genus == "Dipodomys")
dim(krats) # okay, so that's a lot smaller, great.
glimpse(krats)

# ``XOR: We can also investigate further and look at what else is there `table(rodents$genus)` and maybe add another visual like `geom_bar`. Note: "Rodent" comes up as a genus. What does this mean? Should we do something with that?

## Question 1: Annual abundance ----
## How many kangaroo rats of each species were found at the study site in past years
## (so you know what to expect for a sample size this year)?

# We'd like to start by visualizing the numbers of each species captured over time

# [INSERT PETER'S EXAMPLE WITH THE WEIRD YEARS/DATE FORMATS HERE].

# (at some point in that example we end up creating a date column, so i'll do that here for now:)
krats <- krats %>%
  mutate(date = lubridate::ymd(paste(year, month, day, sep = "-")))

# ?? STEP 3: Creating minimal reproducible code ?? ----
# Can Peter's example produce enough code to generate a more obscure error that requires the use of a reprex in order to ask for help?

# After plotting, you also want to get some summary stats. How many individuals per day? Average number per year/per month, etc.? Cumulative change from year to year? Are we seeing declines over the years etc? --> XOR: this is a lot

## Plot: how many individuals? ----
krats %>%
  ggplot(aes(x = species))+
  geom_bar()

## Plot: how many individuals per day? -- BUT WHY? ----

### Side quest ####
### How do I create a graph that shows density plots, vertically?

# box plot of species abundance over the years --> I want this as density plots
krats %>%
  ggplot(aes(x = species, y = date))+
  geom_boxplot() # adds box plot

krats %>%
  ggplot(aes(x = species, y = date))+
  geom_violin()

krats %>%
  filter(species != "sp.") %>%
  ggplot(aes(x = date, color=species, fill=species))+
  geom_density(alpha=0.5) + # adds box plot
  facet_grid(species ~ .) +
  theme_classic()

### End quest ----

# First we need to count how many krats were caught each day

krats_per_day <- krats %>%
  group_by(date, species) %>%
  summarize(n = n()) %>%
  group_by(species)

# Then we can plot it
krats_per_day %>%
  ggplot(aes(x = species))+
  geom_boxplot()+
  geom_jitter(width = 0.2, alpha = 0.2)+
  theme_classic()+
  ylab("Number per day")+
  xlab("Species")

# This throws an error because we are missing y (identify error)

# Now let's try again and add a y
krats_per_day %>%
  ggplot(aes(x = species, y = n))+
  geom_boxplot()+
  geom_jitter(width = 0.2, alpha = 0.2)+
  theme_classic()+
  ylab("Number per day")+
  xlab("Species")

## Potential error/question opportunity/exercise: ----
## why do the outliers show up twice: one in the boxplot layer and once jittered in the points layer? How do we get that to go away?

### For Episode 4 ----
### How do we create a minimal reproducible dataset for this question?

### What structural elements do we need to include? ----
## - 5 levels, (one with markedly fewer observations), some with NAs

### Dummy data from scratch ----

### Dummy data from a subset ----

### Use your actual data ----

## Solution: add outlier.shape = NA ----

krats_per_day %>%
  ggplot(aes(x = species, y = n))+
  geom_boxplot(outlier.shape = NA)+
  geom_jitter(width = 0.2, alpha = 0.2)+
  theme_classic()+
  ylab("Number per day")+
  xlab("Species")


# Year-to-year change ----
captures_per_year <- krats %>%
  group_by(species, year) %>%
  summarize(total_captures = n()) %>%
  arrange(year, .by_group = T) %>%
  mutate(diff = total_captures-lag(total_captures))

captures_per_year %>%
  ggplot(aes(x = year, y = total_captures, col = species))+
  geom_line()+
  theme_classic() # this is a more aggregated version of Peter's histograms with bins by year

captures_per_year %>%
  ggplot(aes(x = year, y = diff, fill = species))+
  geom_col(position = position_dodge())+
  theme_classic() # eh, not that informative

# In all of this, we're still including the unidentified Dipodomys sp. Let's take those out.
krats_species <- krats %>%
  filter(!str_match(species, "sp")) # organic error--str_match does not return a logical, which is what kaija expected. Instead we need str_detect.

krats_species <- krats %>%
  filter(!str_detect(species, "sp")) # organic error--str_match does not return a logical, which is what kaija expected. Instead we need str_detect.
table(krats_species$species) # oh no! we accidentally removed spectabilis too!

# Could fix this by using "sp.":
krats_species <- krats %>%
  filter(!str_detect(species, "sp.")) # another organic error! the . is being interpreted using regex to mean "anything" which is the opposite of what we want.
table(krats_species$species)

# Fix this by using "sp\\.":
krats_species <- krats %>%
  filter(!str_detect(species, "sp\\."))
table(krats_species$species) # yay!
# note: maybe this is a little too complicated, but it doesn't even matter if they don't know regex or how to solve it; what matters is being able to make a reprex.

# Note from Peter here: maybe this will become clear as we flesh out LOs, but the learners seemed a bit confused as to whether we were teaching debugging or just question-asking.
# Kaija: Original idea is to teach some debugging but then have question-asking as a backstop. If they can't solve it, at least they should be able to ask the question. In the extreme case, if it's literally a bug and therefore not solvable without developer intervention, at least they can post an issue on github, or formulate the reprex so that it would be postable.

krats <- krats %>%
  filter(species != "sp.") # alternative and better way to do this hehe

# ``XOR: what about captures per plot per month?

# We now need something more complicate errors for the reprex code


# Making linear models
## It's not clear that weight or hindfoot length can predict sex, but maybe the combination of them can? Let's make a linear model to find out!

mod1 <- lm(sex ~ hindfoot_length + weight + species, data = krats)
