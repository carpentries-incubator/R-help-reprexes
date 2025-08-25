# Minimal reproducible example script
# Loading the tidyverse package
library(tidyverse)
# Uploading the dataset that is currently saved in the project's data folder
surveys <- read_csv("data/surveys_complete_77_89.csv")

# Take a look at the data
glimpse(surveys)

# or you can use
str(surveys)

table(surveys$taxa)

# Barplot of rodent species by sex
ggplot(surveys, aes(x = species, fill = sex)) +
  geom_bar()

# Filter to focal species and known sex
rodents_subset <- surveys %>%
  filter(species == c("ordii", "spectabilis"),
         sex == c("F", "M"))

# Add common names
# common_names <- data.frame(species = unique(rodents_subset$species), common_name = c("Ord's", "Banner-tailed"))
# common_names

# Try again, re-ordering the common names
common_names <- data.frame(species = sort(unique(rodents_subset$species)), common_name = c("Ord's", "Banner-Tailed"))
rodents_subset <- left_join(rodents_subset, common_names, by = "species")

# Explore k-rat weights
weight_model <- lm(weight ~ common_name + sex, data = rodents_subset)
summary(weight_model)

# Weight by species and sex
rodents_subset %>%
  ggplot(aes(y = weight, x = common_name, fill = sex)) +
  geom_boxplot()

# Subsetted dataset
table(rodents_subset$sex, rodents_subset$species)

# Original dataset
table(rodents$sex, rodents$species)
