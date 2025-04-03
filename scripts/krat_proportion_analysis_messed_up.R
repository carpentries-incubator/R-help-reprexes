# Peter's analysis to come up with spurious errors
# Feb 25, 2025

library(dplyr)
library(tidyr)
library(ratdat)
library(ggplot2)
library(scales)

get_proportions <- function(df){
  plot_props <- df %>%
    count(plot_type, species) %>%
    group_by(plot_type) %>%
    mutate(prop = n / sum(n)) %>%
    ungroup()

  species_props <- df %>%
    count(species) %>%
    transmute(species, species_prop = n / sum(n)) %>%
    ungroup()

  props <- left_join(plot_props, species_props,by = "species")
  return(props)

}

permutation_test <- function(dataset){
  mixed_data <- dataset %>% mutate(species = sample(species))
  rv <- get_proportions(mixed_data)
  return(rv)
}

plot_means <- function(df){

  krats_colors <- c("merriami"="#E3D120", "ordii" = "#506412", "spectabilis" = "#ad6042")

  p <- ggplot(df,aes(plot_type, prop, fill=species,group=species)) + geom_point(size=3, shape = 21, color='black') +
    geom_hline(aes(yintercept=species_prop,color=species)) +
    geom_text(aes(y=species_prop+0.02, x = 3, label = paste0(species," mean"), color=species)) +
    scale_color_manual(values = krats_colors) + scale_fill_manual(values = krats_colors) + theme_classic() +
    theme(legend.position='none') + scale_x_discrete(labels = label_wrap(10))
  return(p)
}

add_shuffled_data <- function(p, shuffle_df){
  p_new <- p + geom_jitter(aes(color=species),alpha=0.02, data=shuffle_df, inherit.aes = T)
  return(p_new)
}

add_critical_points <- function(p, stat_df){
  p_new <- p + geom_point(aes(color=species),size = 7, shape = 95, data=stat_df, inherit.aes = T)
  return(p_new)
}


krats <- ratdat::complete_old %>% filter(genus == "Dipodomys")

# see what type of exclosures exclude which species
krats[krats$sex == "","sex"] <- NA
krats[krats$species == "sp.","species"] <- NA

krats <- krats %>% filter(!is.na(species))

# get proportions of species in each plot type
krat_proportions <- get_proportions(krats)

plot_init <- plot_means(krat_proportions)
plot_init


# we're interested in the question of whether plot types meaningfully change the proportion
# of species observed, or whether there is simply sampling error

# To do so, we can resample all data and reassign them randomly to different plots
# if we do this a lot of times, we can see how likely it is to have observed our
# data under a random shuffle

get_proportions(krats)
get_proportions(krats %>% mutate(species = sample(species)))

n_reps <- 1000
permuted_replicates <- matrix(nrow=nrow(krat_proportions), ncol=10000)
for(i in 1:n_reps){
  permuted_replicates[i] <- permutation_test(krats)
}

shuffled_obs <- cbind(krat_proportions %>% select(-n, -prop), permuted_replicates)
shuffled_obs <- shuffled_obs %>% pivot_longer(cols = c(-plot_type, -species), names_to = "replicate", values_to = "prop")

# let's just focus on merriami for now
merriami_proportions <- krat_proportions %>% filter(species == "merriami")
merriami_shuffle_obs <- shuffled_obs %>% filter(species == "merriami")


m_plot <- plot_means(merriami_proportions)
m_plot
add_shuffled_data(m_plot, merriami_shuffle_obs)

# If all our observations were randomly assigned to plots, we wouldn't see matching krat proportions
# therefore, the plot type does seem to affect merriami proportion


# What about the rest of the species?


all_species_sh_plot <- add_shuffled_data(plot_init, shuffled_obs)
all_species_sh_plot

# In general, can see some plots change which species are caught
# for example, long term seems to raise the proportion of
# merriami and lower proportion of the other two


# if we want to explicitly test this, let's add add points so we can say it's significant

shuffled_obs_stat <- shuffled_obs %>% group_by(plot_type, species) %>%
  summarize(two.5 = quantile(prop, 0.025), nine.5 = quantile(prop, 0.975))
shuffled_obs_stat <- shuffled_obs_stat %>% pivot_longer(cols=-c(species, plot_type),names_to="bound_type",values_to="prop")

add_critical_points(all_species_sh_plot, shuffled_obs_stat)




