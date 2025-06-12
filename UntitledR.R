library(tidyverse)
surveys <- read_csv("https://raw.githubusercontent.com/carpentries-incubator/R-help-reprexes/refs/heads/main/episodes/data/surveys_complete_77_89.csv")
glimpse(surveys)
min(surveys$year)
max(surveys$year)
# Read in the data
ggplot(surveys, aes(x = taxa)) + geom_bar()
table(surveys$taxa)
?table
table(surveys$taxa, exclude = NULL)
rodents <- surveys %>% filter(taxa == "Rodent")
rodents_summary <- rodents %>% group_by(plot_type, month) %>% summarize(count=n())
ggplot(rodents_summary) + geom_tile(aes(month, plot_type, fill=count))
krats <- rodents %>% filter(genus == "Dipodomys") #kangaroo rat genus
dim(krats)

ggplot(krats, aes(year, fill=plot_type)) +
  geom_histogram() +
  facet_wrap(~species)
ggplot(rodents, aes(x = species, fill = sex))+
  geom_bar()
rodents_subset <- rodents %>%
  filter(species == c("ordii", "spectabilis"),
         sex == c("F", "M"))
## Adding common names
common_names <- data.frame(species = sort(unique(rodents_subset$species)), common_name = c("Ord's", "Banner-Tailed"))
rodents_subset <- left_join(rodents_subset, common_names, by = "species")
weight_model <- lm(weight ~ common_name + sex, data = rodents_subset)
summary(weight_model)
rodents_subset %>%
  ggplot(aes(y = weight, x = common_name, fill = sex)) +
  geom_boxplot()
table(rodents_subset$sex, rodents_subset$species)
table(rodents$sex, rodents$species)
