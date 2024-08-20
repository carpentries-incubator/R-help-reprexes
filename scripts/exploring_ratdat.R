# Exploring the ratdat dataset
library(ratdat)
library(tidyverse)
head(complete_old)
summary(complete_old)

# Examples of basic plots -------------------------------------------------
complete_old %>%
  ggplot(aes(x = plot_type, y = weight, col = sex))+
  geom_boxplot()
# use for this: "create a dataset that can be used to reproduce this plot"

complete_old %>%
  filter(!is.na(sex)) %>%
  ggplot(aes(x = hindfoot_length, y = weight, col = sex))+
  geom_point(alpha = 0.2)+
  geom_smooth(method = "lm")+
  theme(legend.position = "none")+
  facet_wrap(~species, scales = "free")
# use for this: "aaah why are some of them blank?"
# this is too much, let's just pick one of them

complete_old %>%
  filter(genus == "Dipodomys") %>%
  ggplot(aes(x = hindfoot_length, y = weight))+
  geom_point()+
  geom_smooth(method = "lm")+
  facet_wrap(~species, scales = "free")
# use for this: "why is the plot blank"?
# target: either they wanted a scatterplot for the sps, or they wanted only three panels. Either way, they need to figure out what's causing this to not work

# introduce a misspelling

complete_old %>%
  filter(month == "July")
# this returns no results because month is encoded as an integer

complete_old %>%
  mutate(date = lubridate::ymd(paste(month, day, year)))
# all date formats failed to parse, because you put these in the wrong format

# Filtering down to just Dipodomys
dips <- complete %>%
  filter(species == "Dipodomys")
dips %>%
  ggplot(aes(x = hindfoot_length, y = weight, col = species))+
  geom_point()+
  theme_minimal() # problem: Why is this blank??

# section -----------------------------------------------------------------

glimpse(complete)
