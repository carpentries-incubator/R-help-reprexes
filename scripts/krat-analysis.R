# Kangaroo rat analysis using the Portal data
# Created by: Mishka
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
