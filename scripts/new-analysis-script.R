# New script with lesson flow, created after April 11 meeting
# Kaija Gahm

library(ratdat)
library(reprex)
library(tidyverse) # changed from individual packages

# Load in the data # XXX not actually currently included in our website render!
rodents <- read.csv("data/surveys_complete_77_89.csv") # NOTE: we will have to include this code or similar to download and read in the csv in the intro for them to follow, but then also will have to include code chunks (hidden) that include reading in the data for subsequent episodes, otherwise things will not run.

# explaining the columns that we'll be using

# Exploring data (visually) -----------------------------------------------

# Taxa barplot --> error, no data provided to ggplot2
ggplot(x = taxa) + geom_bar() # error
ggplot(aes(x = rodents$taxa)) + geom_bar() # error

ggplot(rodents, aes(x = taxa)) + geom_bar() # works. We notice the NAs here and we would like to remove them. How many are there?

# Check the breakdown of taxa
table(rodents$taxa) # notice that NAs don't show up in the table
?table
table(a)                 # does not report NA's
table(a, exclude = NULL) # reports NA's
table(rodents$taxa, exclude = NULL)

# filter to taxa == "Rodent" to include only the rodents
rodents <- rodents %>% filter(taxa == "Rodent")

# # filter to k-rats only (genus == "Dipodomys")
# krats <- rodents %>% filter(genus == "Dipydomis")
# head(krats) # notice that this has 0 rows--we misspelled Dipodomys
# krats <- rodents %>% filter(genus == "Dipodomys")
# head(krats) # that's better
# dim(krats)
# XXX can't use krats because it has an odd number of rows--need to use rodents so that the error won't trigger a warning message.

# Can add or change any of these examples as needed for PL's lesson.

# Investigating by species and sex ----------------------------------------
# look at the distribution of observations by species and sex
rodents %>% # option 1: stacked
  ggplot(aes(x = species, fill = sex))+
  geom_bar()

rodents %>% # option 2: dodged
  ggplot(aes(x = species, fill = sex))+
  geom_bar(position = position_dodge())

# Whoa, this is really overwhelming, we only want to focus on two species of kangaroo rats, called Dipodomys ordii and Dipodomys spectabilis. We also notice that we have some NA values for sex, so we would like to only include females and males.
# Let's filter the data down to focus only on the species we care about and only on the sexes "M" and "F.
rodents_subset <- rodents %>%
  filter(species == c("ordii", "spectabilis"),
         sex == c("F", "M")) # does not give us a warning--important to use rodents here rather than krats bc rodents has an even number of rows

dim(rodents)
dim(rodents_subset) # good, it looks like we removed a lot of other species, yay!

# It was really annoying typing all those latin names, so let's add common names to our dataset for the future.
# We do some research, and we learn that the common name for ordii is "Ord's" and the common name for spectabilis is "Banner-Tailed" kangaroo rat.
common_names <- data.frame(species = unique(krats_subset$species), common_name = c("Ord's", "Banner-Tailed"))
common_names # oops, semantic error! these are in the wrong order.

sort(unique(krats_subset$species))
common_names <- data.frame(species = sort(unique(krats_subset$species)), common_name = c("Ord's", "Banner-Tailed"))
common_names # that's better. Now these line up correctly.

# attach the common names
krats_subset <- left_join(krats_subset, common_names)
unique(krats_subset$common_name) # yay!

# We know we're going to have to do some date manipulations later on, so let's make a date column
# XXX can insert another error in here if need be
krats_subset <- krats_subset %>%
  mutate(date = lubridate::ymd(paste(year, month, day))) # correct code

# Model: weight by species and sex -------------------------------
# Now that you've done that data cleanup, you can finally move on to answering your research question, which is about weight.

weight_model <- lm(weight ~ species + sex, data = krats_subset)
summary(weight_model) # this looks weird! why are there NA's for sexM?
# Maybe we should visualize the data before we model it. Let's look at weight by species and sex.

krats_subset %>%
  ggplot(aes(y = weight, x = species, fill = sex)) +
  geom_boxplot() # umm, this is weird! We seem to have only females for ordii and only males for spectabilis. But we expect to have two sexes for both species. What's going on?

# This is a semantic error.
table(krats_subset$sex, krats_subset$species) # sure enough, we somehow ended up with only female ordii and only male spectabilis
table(krats$species, krats$sex) # here was the original breakdown of species and sex--removing NAs should not have removed that many! Why are we missing so many rows?
nrow(krats)
nrow(krats_subset) # we decreased our dataset by waaaaaay too much. Removed far too many rows.

# Here we move on to simplifying the data and the rest of the less --------


