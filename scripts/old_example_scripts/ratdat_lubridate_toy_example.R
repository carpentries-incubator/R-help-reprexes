library(dplyr)
library(ggplot2)
library(lubridate)
library(ratdat)
library(reprex)
library(lme4)
rat_data <- ratdat::complete
rat_data <- rat_data %>% mutate(time = mdy(paste(month, day, year)))

# Question #1: messing up filtering ------------------------------------------
dips <- rat_data %>% filter(species == "Dipodomys") # problem: wrote species instead of genus
dim(dips) # problem: why is this empty??
ggplot(dips) + geom_point(aes(time, weight, color=plot_type)) + facet_wrap(~species) # problem: shows up as empty and you have to figure out why
# solution:
dips <- rat_data %>% filter(genus == "Dipodomys")

# Question 2: Linear model ------------------------------------------------
krat_numbers <- dips %>%
  group_by(year, month, species, plot_type) %>%
  summarize(n = n())

library(lme4) # note: can present this as a non-reproducible example by just including lmer and not loading the package
lmer(n ~ species + month + plot_type + (1|year))
reprex(lmer(n ~ species + month + plot_type + (1|year))
) # this is an error because it can't find the function

reprex({library(lme4)
       lmer(n ~ species + month + plot_type + (1|year))})  # Error in eval(predvars, data, env): object 'n' not found. This is a problem because they haven't told it what dataset to use.

reprex({
  library(lme4)
  lmer(n ~ species + month + plot_type + (1|year), data = krat_numbers)
}) # now the data is specified but the reprex won't work because you haven't defined the dataset here.

# I'm going to move away from reprexes now to just some code, assuming we have the rest of the script as context...
mod <- lmer(n ~ species + month + plot_type + (1|year), data = krat_numbers)
plot(mod) # well, this violates the assumptions horribly, but at least the model worked?
summary(mod)

# linear model predicting weight instead ----------------------------------
mod_weight <- lm(weight ~ hindfoot_length + species + plot_type + month + (1|year), data = dips)
summary(mod_weight)


# Linear model predicting hindfoot length with NA problem for sex ---------

mod_wt <- lm(weight ~ sex + species - 1, data = dips)
summary(mod_wt)
dips %>%
  filter(species != "sp.") %>%
  ggplot(aes(x = species, y = weight, col = sex))+
  geom_boxplot()

# Question #2: time breaks for histogram ----------------------------------
dips <- rat_data %>% filter(genus == "Dipodomys")

# time plots
ggplot(dips, aes(time, fill = plot_type)) + geom_histogram()  + facet_wrap(~species) + theme_bw() + scale_fill_viridis_d(option="plasma")
#month
ggplot(dips, aes(time, fill = plot_type)) + geom_histogram(binwidth = 30)  + facet_wrap(~species) + theme_bw() + scale_fill_viridis_d(option="plasma")
#year
ggplot(dips, aes(time, fill = plot_type)) + geom_histogram(binwidth = 365)  + facet_wrap(~species) + theme_bw() + scale_fill_viridis_d(option="plasma")

# year plots
#year
ggplot(dips, aes(year, fill = plot_type)) + geom_histogram() + facet_wrap(~species) + theme_bw() + scale_fill_viridis_d(option="plasma")
#year -- corrected
ggplot(dips, aes(year, fill = plot_type)) + geom_histogram(binwidth=1)  + facet_wrap(~species) + theme_bw() + scale_fill_viridis_d(option="plasma")
# quarterly?
ggplot(dips, aes(year, fill = plot_type)) + geom_histogram(binwidth = 0.25)  + facet_wrap(~species) + theme_bw() + scale_fill_viridis_d(option="plasma")

