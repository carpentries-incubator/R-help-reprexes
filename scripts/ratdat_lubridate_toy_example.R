library(tidyverse)
library(lubridate)
library(ratdat)
rat_data <- ratdat::complete
rat_data <- rat_data %>% mutate(time = mdy(paste(month, day, year)))

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

