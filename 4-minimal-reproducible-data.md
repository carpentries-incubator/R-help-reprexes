---
title: "Minimal Reproducible Data"
teaching: 40
exercises: 4
---

:::::::::::::::::::::::::::::::::::::: questions 

- What is a minimal reproducible dataset and why do I need it?
- What do I need to include in a minimal reproducible dataset?
- How do I create a minimal reproducible dataset?
- How do I make my own dataset reproducible?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

After completing this episode, participants should be able to...

- Describe a minimal reproducible dataset
- List the requirements for a minimal reproducible dataset
- Identify the important aspects of the dataset that are necessary to reproduce your coding problem
- Create a dataset from scratch to reproduce a given piece of code
- Subset an existing dataset to reproduce a given piece of code
- Share your own dataset in a way that is accessible and reproducible

::::::::::::::::::::::::::::::::::::::::::::::::

## 4.1 What is a minimal reproducible dataset and why do I need it?

- Now that we understand some basic errors and how to fix them, let’s look at what to do when we can’t figure out a solution to our coding problem
- This is when you really need to know how to create a minimal reproducible example (MRE) as we talked about in episode 1
- In general, an MRE will need:
* A minimal dataset that can reproduce the error (or access to a such a dataset)
* Minimal runnable code that can reproduce the error using the minimal dataset
* Basic information about the system, R version, and packages being used
* In case of random functions, a seed that will produce the same results each time (e.g., use set.seed())
- The first step in creating an MRE is to set up some data **for your helper to be able to reproduce your error and play around with the code in order to fix it.**

Why? Remember our IT problem? It would be a lot easier for the IT support person to fix your computer if they could actually touch it, see the screen, and click around.

Another *example:* you're knitting a sweater and one of the sleeves looks wonky. You call a friend and ask why it's messed up. They can't possibly help without being able to hold the sweater and look at the stitches themselves. 

It would be great if we were able to give the helper the entire dataset, but usually, we can't.

::::::::::::::::::::::: callout

There are several reasons why you might need to create a separate dataset that is minimal and reproducible instead of trying to use your actual dataset. The original dataset may be:

- too large: the Portal dataset is ~35,000 rows with 13 columns and contains data for decades. That's a lot!
- private - your dataset might not be published yet, or maybe you're studying an endangered species whose locations can't easily be shared. Another example: many medical datasets cannot be shared publically. 
- hard to send - on most online forums, you can't attach supplemental files (more on this later). Even if you are just sending data to a colleague, file paths can get complicated, the data might be too large to attach, etc.
- complicated - it would be hard to locate the relevant information. One example to steer away from are needing a 'data dictionary' to understand all the meanings of the columns (e.g. what is "plot type" in `ratdat`?) We don't our helper to waste valuable time to figure out what everything means.
- highly derived/modified from the original file. As an example, you may have already done a bunch of preliminary data wrangling and you don't want to include all that code when you send the example (see later: the minimal code section), so you need to provide the intermediate dataset directly to your helper.

::::::::::::::::::::::::::

It's useful to strip the dataset to its essential parts to identify where exactly the problem is. A minimal dataset is a dataset that includes the information necessary to run the code, but removes all other unnecessary parts (extra columns/rows, extra context, etc.)

We need minimal reproducible datasets to make it easy/simple/fast for the helper to focus in on the problem at hand and "get their hands dirty" tinkering with the dataset.

## 4.2 What do I need to include in a minimal reproducible dataset?

What needs to be included in a reproducible dataset (wait for audience)?

It's actually all in the name:
- it needs to be minimal, which means it only contains the necessary information to run the piece of code with which you are struggling.
- it needs to be reproducible. The data you provide must consistently reproduce the output or error with which you are struggling. 
- Can alternatively think of this as "relevant" to the problem. Maybe a silly example but–if you're struggling with the behavior of a column that's a factor, it wouldn't be useful to make a dataset that contains only numeric data, no matter how simple and elegant that dataset might appear to be.
- It needs to be complete and accessible. Remember, your helper may not be in the room with you or have access to your computer, therefore the data must be able to stand on its own, it must be complete and free of dependencies. Alternatively, you must ensure your helper has access to the dataset you provide. More on this later.

::::::::::::::::::::::: callout

Remember that helpers do not have access to files on your computer!

You might be used to always reading data in as separate files, but helpers can't access those files. Even if you sent someone a file, they would need to put it in the right directory, make sure to load it in exactly the same way, make sure their computer can open it, etc. Since the goal is to make everyone's lives as easy as possible, we need to think about our data in a different way–as a dummy object created in the script itself.

::::::::::::::::::::::::::


:::::::::::::::::::::::: callout 

It can be helpful to simply look at the ?help section. Scroll down to where they have examples. These will usually be minimal and reproducible.

For example, let's look at the function `mean`:
```r
?mean
```

We see examples that can be run directly on the console, with no additional code.

```r
x <- c(0:10, 50)
xm <- mean(x)
c(xm, mean(x, trim = 0.10))
```

:::::::::::::::::::::::






:::::::::::::::::::::::::::::::::::::: challenge

### Exercise 1

These datasets are not well suited for use in a reprex. For each one, try to reproduce the dataset, explain what’s wrong with it, and suggest how to fix it. (Hint: imagine you are a helper and someone has asked you to work on a problem with each of these datasets. Think through the steps you would take and how easy/difficult it would be to use each one.)

A) (A screenshot of our dataset -- need to upload images to repo)
B) `sample_data <- read_csv(“/Users/kaija/Desktop/RProjects/ResearchProject/data/sample_dataset.csv”)`
C) `dput(complete_old[1:100,])`
D) `sample_data <- data.frame(species = species_vector, weight = c(10, 25, 14, 26, 30, 17))`


:::::::::::::: solution

### Solution

A) Not reproducible because it is a screenshot.  
B) Not reproducible because it is a path to a file that only exists on someone else’s computer and therefore you do not have access to it using that path.
C) Not minimal, it has far too many columns and probably too many rows. It is also not reproducible because we were not given the source for “complete_old.”
D) Not reproducible because we are not given the source for “species_vector.”


:::::::::::::::::::::::::

For an extra challenge, can you edit the above datasets to make them minimal and reproducible?


::::::::::::::::::::::::::::::::::::::::::::::::::



:::::::::::::::::::::::::::::::::::::: challenge

### Exercise 2

Here is a piece of code that is throwing me a simple error:

```r
> library(ratdat)
> mean(complete$weight)
> [1] NA
```

Which of the following represents a minimal reproducible dataset for this code? Can you describe why the other ones are not?



A) `sample_data <- data.frame(month = rep(7:9, each = 2), hindfoot_length = c(10, 25, 14, 26, 30, 17))`
B) `sample_data <- data.frame(weight = rnorm(10))`
C) `sample_data <- data.frame(weight = c(100, NA, 30, 60, 40, NA))`
D) `sample_data <- sample(complete$weight, 10)`
E) `sample_data <- complete_modified[1:20,]`


:::::::::::::: solution

### Solution

The correct answer is C!


A) does not include the variable of interest (weight). 
B) does not produce the same problem (NA result with a warning message)--the code runs just fine. 
D) is not reproducible. Sample randomly samples 10 items; sometimes it may include NAs, sometime it may not (not guaranteed to reproduce the error). It can be used if a seed is set (see next section for more info). 
E) uses a dataset that isn't accessible without previous data wrangling code–the object complete_modified doesn't exist.


:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

## 4.3 How do I create a minimal reproducible dataset?

This is where I often get stuck: how do I recreate the key elements on my dataset in order to reproduce my error?? That seems really hard! If you are like me and find this initially overwhelming, don’t worry. We will break it down into smaller steps. First, there are two approaches to providing a dataset. You can create one from scratch or you can use an already available dataset.

We then need to know which elements of your dataset are necessary.
- How many variables?
- What data type is each variable?
- How many levels or observations are necessary?
- How many of the values need to be the same/different?

### 4.3.1 Create a dummy dataset from scratch

You can create vectors using 

```
vector <- c(1,2,3,4) 
```

You can add some randomness by sampling from a vector using sample()

For example you can sample numbers 1 through 10 in a random order
```
	x <- sample(1:10)
```

Or you can use a random normal distribution
```
	x <- rnorm(10)
```

You can also use letters to create factors.
```
x <- sample(letters[1:4], 20, replace=T)

```

You can create a dataframe using `data.frame` (or `tibble` in the `dplyr` package). 
```
	data <- data.frame (x = sample(letters[1:3], 20, replace=T]), y = rnorm(1:20))
```

Make sure you name your variables and keep it simple. 

::::::::::::: callout 

Callout
For more handy functions for creating data frames and variables, see the cheatsheet.
For some questions, specific formats can be needed. For these, one can use any of the provided as.someType functions: `as.factor`, `as.integer`, `as.numeric`, `as.character`, `as.Date`, `as.xts`.

::::::::::::::

Example:

We want to quantify presence/absence of three rodent species in a particular treatment plot after 12 days of sampling.
Let’s think about what variables we would need.

A variable for species, how many? Let’s say 3 species, and call them A, B, and C.

```r
species <- c(‘A’,’B’,’C’)
```

We then need a variable that tells us whether or not the species is present in that treatment plot.

```r
present <- c(‘yes’,’no’)
```

If we are only looking at one treatment plot then we don’t need a “treatment” variable. Keep it minimal!
Ok, now we need to randomly sample from these to generate our dataset after 12 days of sampling and make a new variable “day” with numbers 1-12

```r
day <- c(1:12)
```

We can then sample our first two variables 12 times.

```r
sample_data <- data.frame(
  Species = sample(species, 12, replace=T),
  Present = sample(present, 12, replace=T),
  Day = day
)
```

Now what is wrong with this?
→ we sampled 12 times, but what we needed was to sample each species 12 times.

```r
sample_data <- data.frame(
  Species = species,
  Present = sample(present, 36, replace=T)
  Day = day
)
```

We also didn’t set a seed. Remember: sample() creates a random dataset! This will not be consistently reproducible.
```r
set.seed(1)
sample_data <- data.frame(
  Species = species,
  Present = sample(present, 36, replace=T)
  Day = day
)
```

Instead of creating the original variables we can also do it all at once when creating the data frame:
```r
set.seed(1)
data <- data.frame(
		Species = c(‘A’,’B’,’C’),
		Present = sample(c(‘yes’, ‘no’), 36, replace=T),
		Day = c(1:12)
) 
```

:::::::::::::::::::::::::::::::::::::: challenge

### Exercise 3
Now practice doing it yourself. Create a data frame with: 
A. One categorical variable with 5 levels. One continuous variable.
B. One continuous variable normally distributed
C. First name, last name, sex, age, and treatment type.

:::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::: challenge

### Exercise 4
For each of the following, identify the necessary data type to create a minimal reproducible dataset.
A. We have data representing whether someone voted for a candidate from party A or party B. 
B. We have housing data of zipcodes, home prices, number of bedrooms and bathrooms for each house. Some of the data may be missing

::::::::::::::::::::::::: solution

A. We just need a T/F vector of whether someone voted for A (T) or B (F). 
B. We need a dataframe with separate columns for zipcodes (int), home prices (double), number of bedrooms (int), and bathrooms (double). Some NA’s should be included. 

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::

:::::: keypoints
 - A minimal reproducible dataset contains the minimum number of lines and variables to reproduce a certain problem and can be fully reproduced by someone else using only the information provided 
 - You can create a dataset from scratch using `as.data.frame`, you can use available datasets like `iris` or you can use a subset of your own dataset
 - You can share your data by...
::::::
