# More errors
library(readr)
library(dplyr)
library(ggplot2)

# Read in the data
rodents <- read_csv("scripts/data/surveys_complete_77_89.csv")

data(rodents) # XXX
View(rodents)

head(rodents)
summary(rodents)
hist(rodents$weight, col=rodents$species) # XXX
boxplot(rodents$weight, rodents$species) # XXX
boxplot(weight~species, data=species) # XXX
boxplot(weight~species, data=rodents)

plot(rodents$record_id, rodents$weight)

table(rodents$genus)

KRat <- subset(rodents, genus=="Dipodomys")
plot(KRat$record_id, KRat$weight)
boxplot(weight~species, data=KRat)

head(KRAT) # XXX
head(Krat) # XXX
head(KRat)
WeightMod <-lm(weight~species+sex+hindfoot_length, data=KRat)
summary(WeightMod)

NewDF <- data.frame(species=unique(Krat$species), CommonName = c("Merriam's", "Ord's", "Banner-Tailed"))
NewDF <- data.frame(species=unique(KRat$species), CommonName = c("Merriam's", "Ord's", "Banner-Tailed")) # XXX
NewDF
unique(KRat$species)
#we didn't notice the "sp." species in the boxplot, probably because those ones didn't have weights, either
NewDF <- data.frame(species=unique(KRat$species), CommonName = c("Merriam's", "Ord's", "Banner-Tailed", "Unknown/Other"))
NewDF # XXX
#we gotta reorder!
NewDF <- data.frame(species=sort(unique(KRat$species)), CommonName = c("Merriam's", "Ord's", "Unknown/Other", "Banner-Tailed"))
NewDF

DFplusCommonName <-left_join(x=KRats, y=NewDF, by="species") # XXX spelling
DFplusCommonName <-left_join(x=KRat, y=NewDF, by="species")
dim(KRat)
dim(DFplusCommonName)

# Alternative idea: join failing because wrong column name
dummy <- data.frame(Species=sort(unique(KRat$species)), CommonName = c("Merriam's", "Ord's", "Unknown/Other", "Banner-Tailed"))
dummy

test <-left_join(x=KRat, y=dummy, by="species") # this is helpful # XXX
test <- left_join(x = KRat, y = dummy) # this is another error # XXX

# back to our regularly scheduled programming (hah)

head(DFplusCommonName)
boxplot(weight~year, data=DFplusCommonName)
DFplusCommonName %>% ggplot(aes(x = year, y = weight))+geom_boxplot() # this is an error in ggplot but NOT in base! interesting. We could either get into that or we could not bother pointing out the difference, just do it in ggplot from the start.

DFplusCommonName %>% ggplot(aes(x = as.factor(year), y = weight))+geom_boxplot() # this is an error in ggplot but NOT in base! interesting. We could either get into that or we could not bother pointing out the difference, just do it in ggplot from the start.

df <- data.frame(number = rep(c(1, 11, 2), each = 100), values = c(rnorm(100, 1, 3), rnorm(100, 3, 2), rnorm(100, 1, 1.5)))

df %>%
  ggplot(aes(x = number, y = values))+
  geom_boxplot() # numbers are continuous


df %>%
  ggplot(aes(x = as.factor(as.character(number)), y = values))+
  geom_boxplot() # factors in the wrong order--but this is too contrived to actually use as an example

MinMaxMean <-function(SPECIES){
  MIN = min(SPECIES)
  MAX = max(SPECIES)
  MEAN = mean(SPECIES)
  return(MIN, MAX, MEAN)
}

MinMaxMean <-function(SPECIES){
  MIN = min(SPECIES)
  MAX = max(SPECIES)
  MEAN = mean(SPECIES)
  return(c(MIN, MAX, MEAN))
}
MinMaxMean(KRat$weight)
MinMaxMean(KRat$weight, na.omit=TRUE)

MinMaxMean <-function(SPECIES){
  MIN = min(SPECIES, na.rm = T)
  MAX = max(SPECIES, na.rm = T)
  MEAN = mean(SPECIES, na.rm = T)
  return(c(MIN, MAX, MEAN))
}
MinMaxMean(KRat$weight)

SummaryStats <- c(unique(KRat$species),MinMaxMean(unique(KRat$species)))
SummaryStats




