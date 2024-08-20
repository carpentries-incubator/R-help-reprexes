# We are researchers working on the Portal dataset.
# MOTIVATION:
# - You are a PhD student studying kangaroo rats.
# - In preparation for some fieldwork this year, you are analyzing an old dataset from your lab between 1977 and 1989. Your new fieldwork will attempt to replicate some of this, and you want to make sure you have a good handle on your focal organisms, several species of kangaroo rat.
# - You're somewhat familiar with this dataset, but this is your first time doing a deep dive on visualizing and analyzing it. You already know that the dataset contains information from rodent captures in various types of study plots. Body measurements were taken and many of the rodents were sexed.
# Some things you want to find out:
# 1. How many kangaroo rats of each species were found at the study site in past years (so you know what to expect for a sample size this year)?
# 2. What are the general morphological characteristics of the species? Can they be identified or even sexed by their body measurements?
# 3. What is the distribution of species in the different types of study plots?

# Here are some packages we're going to need.
library(readr)
library(dplyr)
library(ggplot2)
library(stringr)

# We can start by reading in our dataset from file
rodents <- read_csv("scripts/data/surveys_complete_77_89.csv")

# Let's examine the dataset.
# When we were out in the field, we recorded genus, species, the day, and each individual's weight and hindfoot length. Let's take a look at these to remind ourselves of what our dataset looks like:
glimpse(rodents)
str(rodents)
head(rodents, 3)

# Whoops, when I look at the data, I remember that we actually recorded data about more than just rodents. I can tell this because there's a `taxa` column that includes "Rodent" as an option. It also has other options.
table(rodents$taxa) # we have other stuff here too.

# Let's simplify it down to just the rodents!
rodents <- rodents %>%
  filter(taxa == "Rodent")
glimpse(rodents)

# We're interested in studying kangaroo rats. Let's see if we can find a way to filter down the data just to kangaroo rats.
# Kangaroo rats belong to the genus Dipodomys, so let's filter to that.
krats <- rodents %>%
  filter(genus == "Dipodomys")
dim(krats) # okay, so that's a lot smaller, great.
glimpse(krats)

# 1. How many kangaroo rats of each species were found at the study site in past years (so you know what to expect for a sample size this year)?
# We'd like to start by visualizing the numbers of each species captured over time
# [INSERT PETER'S EXAMPLE WITH THE WEIRD YEARS/DATE FORMATS HERE].
# (at some point in that example we end up creating a date column, so i'll do that here for now:)
krats <- krats %>%
  mutate(date = lubridate::ymd(paste(year, month, day, sep = "-")))

# After plotting, you also want to get some summary stats. How many individuals per day? Average number per year/per month, etc.? Cumulative change from year to year? Are we seeing declines over the years etc?

krats_per_day <- krats %>%
  group_by(date, species) %>%
  summarize(n = n()) %>%
  group_by(species)

krats_per_day %>%
  ggplot(aes(x = species, y = n))+
  geom_boxplot()+
  geom_jitter(width = 0.2, alpha = 0.2)+
  theme_classic()+
  ylab("Number per day")+
  xlab("Species")
##############################
# XXX potential error/question opportunity/exercise: why do the outliers show up twice: one in the boxplot layer and once jittered in the points layer? How do we get that to go away?

# XXX solution: add outlier.shape = NA
krats_per_day %>%
  ggplot(aes(x = species, y = n))+
  geom_boxplot(outlier.shape = NA)+
  geom_jitter(width = 0.2, alpha = 0.2)+
  theme_classic()+
  ylab("Number per day")+
  xlab("Species")
##############################

# Year-to-year change
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
