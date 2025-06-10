---
title: "Minimal Reproducible Data"
teaching: 90
exercises: 6
editor_options: 
  markdown: 
    wrap: sentence
---





::: questions
-   What is a minimal reproducible dataset, and why do I need it?
-   How do I create a minimal reproducible dataset?
-   Can I just use my own data?
:::

::: objectives
-   Describe a minimal reproducible dataset
-   Identify the aspects of your data necessary to replicate your issue
-   Create a dataset from scratch to replicate your issue
-   Share your own dataset in a way that is minimal, accessible, and reproducible
-   Subset an existing dataset to replicate your issue
:::

## 3.1 What is a minimal reproducible dataset and why do I need it?

Now that you have narrowed down your problem area and stripped down your code to make it minimal we need to ensure it is reproducible; this means it needs to be accessible and runnable such that anyone else can copy-paste it into their system, run the code, and replicate your issue.
Importantly, an **example code will always require example data** in order to run!
Therefore, **every reprex requires you to provide a minimal reproducible dataset to use with the code**.

::: instructor
Development note: Sections above should talk about making the code minimal and introduce the need for it to be reproducible.
This data episode is part of being reproducible and should perhaps be followed-up with more details on reproducibility (e.g., reprex needs minimal code - check - dependencies, which include minimal data - check - and other basic information like your system and R version as well as contextual information on your data?).
:::

Furthermore, as we have seen previously, sometimes the source of the problem isn't actually your code, but rather your data!
By providing an example dataset that, when used in your example code, still replicates your issue, you also **give your helper the opportunity to better investigate and manipulate that data** to fix your issue.
It would be great if we could give the helper our entire computer so they could just take over where we left off, but usually we can't.

Just as we did with our code, when providing such an example dataset we also want to make sure we keep it minimal--free of unnecessary data.
This will allow your helper to more clearly see what the data looks like and what the source of your issue may be.
Furthermore, it will allow you to not only better understand your data but also potentially work out the source of your issue.
When extraneous information is removed and only the parts that replicate the issue are kept, we can begin to see where the issues arise.

In short, a minimal reproducible dataset must be:

-   **minimal**: it only contains the necessary information to run your minimal code. You can also think of this as being **relevant** to the problem: keep only what is necessary.
-   **reproducible**: it must be **accessible** to someone without your computer, and it must consistently replicate your output/issue. This means it also needs to be **complete**, meaning there are no dependencies that have been omitted.

::: callout
### Remember: your helper may not be in the room with you or have access to your computer and the files that are on it!

You might be used to always uploading data from separate files, but helpers can't access those files.
Even if you sent someone a file, they would need to put it in the right directory, make sure to load it in exactly the same way, make sure their computer can open it, etc.
Since the goal is to make everyone's lives as easy as possible, we need to think about our data in a different way--as a dummy object created in the script itself.
:::

::: callout
### Pro-tip

An example of what minimal reproducible examples look like can also be found in the `?help` section, in R Studio.
Just scroll all the way down to where there are examples listed.
These will usually be minimal and reproducible.

For example, let's look at the function `mean`:


``` r
?mean
```

We see examples that can be run directly on the console, with no additional code.


``` r
x <- c(0:10, 50)
xm <- mean(x)
c(xm, mean(x, trim = 0.10))
```

``` output
[1] 8.75 5.50
```

In this case, x is the dummy dataset consisting of just 1 variable.
Notice how it was created as part of the example.
:::

:::: challenge
### Exercise 1

These datasets are not well suited for use in a reprex.
For each one, try to reproduce the dataset on your own in R (copy-paste).
Does it work?
What happened?
Explain.

A)  ![](fig/data_screenshot.png){alt="Screenshot of the ratdat comple_old dataset."}
B)  `sample_data <- read_csv(“/Users/kaija/Desktop/RProjects/ResearchProject/data/sample_dataset.csv”)`
C)  `dput(complete_old[1:100,])`
D)  `sample_data <- data.frame(species = species_vector, weight = c(10, 25, 14, 26, 30, 17))`

::: solution
### Solution

A)  Not reproducible because it is a screenshot.
B)  Not reproducible because it is a path to a file that only exists on someone else’s computer and therefore you do not have access to it using that path.
C)  Not minimal, it has far too many columns and probably too many rows. It is also not reproducible because we were not given the source for `complete_old`.
D)  Not reproducible because we are not given the source for `species_vector`.
:::
::::

:::: challenge
### Exercise 2

Let's say we want to know the average weight of all the species in our `rodents` dataset.
We try to use the following code...


``` r
mean(rodents$weight)
```

``` output
[1] NA
```

...but it returns NA!
We don't know why that is happening and we want to ask for help.

Which of the following represents a minimal reproducible dataset for this code?
Can you describe why the other ones are not?

A)  `sample_data <- data.frame(month = rep(7:9, each = 2), hindfoot_length = c(10, 25, 14, 26, 30, 17))`
B)  `sample_data <- data.frame(weight = rnorm(10))`
C)  `sample_data <- data.frame(weight = c(100, NA, 30, 60, 40, NA))`
D)  `sample_data <- sample(rodents$weight, 10)`
E)  `sample_data <- rodents_modified[1:20,]`

::: solution
### Solution

The correct answer is C!

A)  does not include the variable of interest (weight).
B)  does not produce the same problem (NA result with a warning message)--the code runs just fine.
C)  minimal and reproducible.
D)  is not reproducible. Sample randomly samples 10 items; sometimes it may include NAs, sometime it may not (not guaranteed to reproduce the error). It can be used if a seed is set (see next section for more info).
E)  uses a dataset that isn't accessible without previous data wrangling code–the object rodents_modified doesn't exist.
:::
::::

## 3.2 Can I just use my own data?

At this point you may be wondering why you need a separate dataset, can't you just use your own data if you made sure it was minimal and your helper could access it?

::: instructor
Here you can ask the class if they can think of any reasons why using your own data may not be possible or, if possible, not a good idea.
:::

::: callout
There are several reasons why you might need to create a separate dataset that is minimal and reproducible instead of trying to use your actual dataset.
The original dataset may be:

-   too large - the Portal dataset is \~35,000 rows with 13 columns and contains data for decades. That's a lot!
-   private - your dataset might not be published yet, or maybe you're studying an endangered species whose locations can't easily be shared. Another example: many medical datasets cannot be shared publically.
-   hard to send - on most online forums, you can't attach supplemental files (more on this later). Even if you are just sending data to a colleague, file paths can get complicated, the data might be too large to attach, etc.
-   complicated - it would be hard to locate the relevant information. One example to steer away from are needing a 'data dictionary' to understand all the meanings of the columns (e.g. what is "plot type" in `ratdat`?) We don't our helper to waste valuable time to figure out what everything means.
-   highly derived/modified from the original file. You may have already done a bunch of preliminary data wrangling you don't want to include when you send the example, so you would need to provide the intermediate dataset directly to your helper.
:::

If so, you wouldn't be entirely wrong.
While there could be several ways in which your original data may be inaccessible or hard to derive or subset, there are likely just as many ways you could make it anonymous, minimal, and reproducible.
And we will show you how!
Nevertheless, making your own data minimal and reproducible isn't necessarily easier than creating a new dataset from scratch.
Furthermore, creating a dataset from scratch can often highlight the source of your issue!
Which means you might not need to ask help after all or you can ask a more specific question.

## 3.3 How do I create a minimal reproducible dataset?

In general, there are 3 common ways to provide minimal reproducible data for a reprex.

-   You can write a script that creates a new "dummy" dataset with the same key characteristics as your original data.

-   You can make your own data minimal and reproducible.

-   You can use a dataset that is already embedded in R and is therefore already accessible.

For the purpose of this lesson, we believe each coder is entitled to all the options, therefore we will walk you through how to provide a minimal reproducible dataset using each of these 3 methods.
However, opinions generally differ on which method is best for which situations.
Below we compiled a summary table of advantages and disadvantages of each method based on many conversations with several data science groups.

+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|                       | **Advantages**                                                                                                                                                                                             | **Disadvantages**                                                                                                                                                      |
+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **Data from Scratch** | -   Often the most concise                                                                                                                                                                                 | While some disadvantages are universal, many apply mostly to novices.                                                                                                  |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   Easiest for helpers                                                                                                                                                                                    | -   Can be intimidating                                                                                                                                                |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   Helps you problem-solve along the way (e.g., identify what data aspects are generating the problem)                                                                                                    | -   Requires good understanding of your data                                                                                                                           |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   Easy to share, collaborate, teach, and understand                                                                                                                                                      | -   Harder to generate if the error is idiosyncratic or dependent on having a large dataset                                                                            |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   More universally applicable                                                                                                                                                                            | -   Time-consuming if unskilled                                                                                                                                        |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   Avoids privacy/security concerns                                                                                                                                                                       | -   Iterative (you may need to trial and error a few times to replicate the problem)                                                                                   |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   Lets you clearly illustrate the sought outcome                                                                                                                                                         | -   More likely to require analogies–less interpretable/connected to real problems, more likely to require greater context                                             |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   Uses important-to-learn skills                                                                                                                                                                         | -   Risks generating XY problems–make sure you are asking the right question/replicating the right problem                                                             |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   Easier for more skilled individuals                                                                                                                                                                    |                                                                                                                                                                        |
+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **R-built Data**      | -   Simple and easy to share–no need to provide additional data                                                                                                                                            | -   May require a good mental model of the problem                                                                                                                     |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   Familiar–helpers already know the data structure                                                                                                                                                       | -   Harder if the error is idiosyncratic                                                                                                                               |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   Potentially faster than starting from scratch (i.e. faster than generating rows/columns de novo).                                                                                                      | -   Greatest risk of generating XY problems–make sure you are asking the right question/replicating the right problem                                                  |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   No privacy/security concerns                                                                                                                                                                           | -   Iterative (you may need to trial and error a few times to replicate the problem)                                                                                   |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   Can easily be manipulated or simplified                                                                                                                                                                | -   Need to re-think the question so it matches a different dataset and context–mental gymnastics                                                                      |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   Generalizes the problem                                                                                                                                                                                | -   Still need to choose which dataset and variables are more appropriate                                                                                              |
+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| **Your Data**         | -   Can require the least mental effort                                                                                                                                                                    | -   Less growth-minded if chosen as the "easy way out"--skips the learning process of trying to construct a dataset and any insights that that process might give you. |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   Problem is easy to replicate even if you don’t understand it at all                                                                                                                                    | -   Easy to do poorly and think that you're doing it well; perceived "easiness" leads to overcomplication/confusion                                                    |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   Accurately represents the actual problem; avoids XY problems.                                                                                                                                          | -   Leaves all the work to the helpers if you don’t also work to minimize it–less motivation for harder work                                                           |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   Richer context may intrigue/motivate helpers                                                                                                                                                           | -   Could obfuscate the problem if not minimized–less likely to find a quick answer                                                                                    |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   Can be quicker if dataset is small                                                                                                                                                                     | -   More difficult to share–may be large/messy                                                                                                                         |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   May be required for idiosyncratic problems that are based on aspects of the data itself that you don’t know about (e.g.  when the data itself, rather than the code per se, is central to the problem) | -   Security/privacy/sanitizeation problems                                                                                                                            |
|                       |                                                                                                                                                                                                            |                                                                                                                                                                        |
|                       | -   Captures data structures that are difficult or time-consuming to replicate if you are a novice                                                                                                         |                                                                                                                                                                        |
+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

## 3.4 Creating a "dummy" dataset from scratch

While this might be the most daunting option for novices, it tends to be the preferred methods for experts.
That's probably because, once you really understand the basic building blocks, it becomes the most straight-forward method of creating a minimal reproducible dataset.
This is also the method that makes most sense when doing other activities that also require a reprex (e.g., teaching, collaborating, developing).
Lastly, in this lesson we believe there are greater problem-solving insights to be gained by creating a new "dummy" dataset.
So let's start by making this scary process more easily digestible!

Usually, at this stage, you would have 2 pressing quesions:

1.  How do I create a dataset?
2.  How do I recreate the key elements of my data that replicate my issue?

Let's start with the first.

There are many ways one can create a dataset in R.

You can start by creating vectors using `c()`


``` r
vector <- c(1,2,3,4) 
vector
```

``` output
[1] 1 2 3 4
```

You can also add some randomness by sampling from a vector using `sample()`.

For example you can sample numbers 1 through 10 in a random order


``` r
x <- sample(1:10)
x
```

``` output
 [1] 10  8  7  3  9  5  4  2  1  6
```

Or you can randomly sample from a normal distribution


``` r
x <- rnorm(10)
x
```

``` output
 [1] -0.909463194 -0.365545330 -1.712217358 -0.007364299 -1.051240206
 [6] -0.350109483 -0.311576571  1.713959335 -0.161357572  1.569398590
```

You can also use `letters` to create factors.


``` r
x <- sample(letters[1:4], 20, replace=T)
x
```

``` output
 [1] "a" "c" "d" "c" "a" "b" "b" "c" "c" "b" "a" "c" "a" "a" "a" "c" "b" "c" "b"
[20] "b"
```

Remember that a data frame is just a collection of vectors.
You can create a data frame using `data.frame` (or `tibble` in the `dplyr` package).
You can then create a vector for each variable.


``` r
data <- data.frame (x = sample(letters[1:3], 20, replace=T), 
                    y = rnorm(1:20))
head(data)
```

``` output
  x           y
1 b -0.36620783
2 b -1.29362251
3 a -0.82626886
4 c -1.21481226
5 c  0.05616861
6 a -1.19779358
```

**However**, when sampling at random you must remember to `set.seed()` before sending it to someone to make sure you both get the same numbers!

::: callout
For more handy functions for creating data frames and variables, see the cheatsheet.
For some questions, specific formats can be needed.
For these, one can use any of the provided as.someType functions: `as.factor`, `as.integer`, `as.numeric`, `as.character`, `as.Date`, `as.xts`.
:::

::: instructor
You can skip the challenge below or you can run through it together to illustrate the above.
:::

::: challenge
### Exercise 3: Your turn! (Optional)

Create a data frame with:

A. One categorical variable with 2 levels and one continuous variable.
B.
One continuous variable that is normally distributed.
C.
Name, sex, age, and treatment type.
:::

## 3.5 Identifying the key elements of your data

No matter which approach we take for providing a dataset, we need to identify which elements of our original data are necessary.
To do so, we propose starting a few simple questions to investigate your data:

-   How many variables do we need?
-   What data type (discrete or continuous) is each variable?
-   How many levels and/or observations are necessary?
-   Should the values be distributed in a specific way?
-   Are there any NAs that could be relevant?

Let's come back to our kangaroo rats example.
Here is the minimal code we settled on:


``` r
# Minimal code [Or whatever we end up with]
krats_subset <- rodents %>%
  filter(species == c("ordii", "spectabilis"),
         sex == c("F", "M"))

table(krats_subset$sex, krats_subset$species)
```

``` output
   
    ordii spectabilis
  F   350           0
  M     0         626
```

So we want to create a minimal reproducible 'dummy' version of `krats_subet`.
Let's start by taking a quick look, then aswering the questions.


``` r
head(krats_subset)
```

``` output
  record_id month day year plot_id species_id sex hindfoot_length weight
1        58     7  18 1977      12         DS   M              45     NA
2        80     8  19 1977       1         DS   M              48     NA
3       104     8  20 1977      11         DS   M              43     NA
4       144     8  21 1977      15         DS   M              40     NA
5       176     9  11 1977      12         DS   M              45     NA
6       182     9  11 1977      21         DS   M              49     NA
      genus     species   taxa                plot_type
1 Dipodomys spectabilis Rodent                  Control
2 Dipodomys spectabilis Rodent        Spectab exclosure
3 Dipodomys spectabilis Rodent                  Control
4 Dipodomys spectabilis Rodent Long-term Krat Exclosure
5 Dipodomys spectabilis Rodent                  Control
6 Dipodomys spectabilis Rodent Long-term Krat Exclosure
```

::: challenge
### Excercise 4

Try to answer the following questions on your own to determine what we need to include in our minimal reproducible dataset:

1.  How many variables do we need?
2.  What data type (discrete or continuous) is each variable?
3.  How many levels and/or observations are necessary?
4.  Should the values be distributed in a specific way?
5.  Are there any NAs that could be relevant?
:::

::: instructor
After giving them some time to think it through on their own, work together through the answers
:::

Let's go over the answers together and build a dataset as we go along!

1.  How many variables do we need?

We need species, sex, and maybe a third identifier like record_id.
This means we potentially need 3 vector (remember, each column in a dataframe is essentially just a vector).

1.  What data type (discrete or continuous) is each variable?

Species and sex are both discrete (categorical) variables, while record ID would be more continuous.

1.  How many levels and/or observations are necessary?

Since we are filtering our dataset down to 2 categories for both species and sex, that means we need at least 3 levels in each to start with.
In terms of number of observations there don't seem to be specific restrictions other than we probably want at least 1 observations per original category, so 2\*3=6, or we can just pick another typical nice number like 10.

1.  Should the values be distributed in a specific way?

Since question probably isn't going to be relevant most of the time, but certainly worth considering.
If we needed a longer dataset of measurements we may have wanted to make sure it was normally distributed.
If we needed a longer dataset of counts we may have wanted to make sure it was Poisson distributed.
Or maybe we had bimodal data.
But in this case, we had a short dataset and I don't think it matters.
We can always come back to this if we are unable to replicate our issue (hint: in which case the distribution may be related to the issue).

1.  Are there any NAs that could be relevant?

We don't have any NAs but we do have a blank category under sex.
For all we know that could be important, so maybe we want to also make one of our categories blank.


``` r
# We need 3 variables: species, sex, and record_id
# species and sex are categorical with at least 3 levels, one of which is blank for sex
species <- sample(letters, 3, replace=F)
print(species)
```

``` output
[1] "u" "e" "q"
```

``` r
sex <- c('M','F','')
print(sex)
```

``` output
[1] "M" "F" "" 
```

``` r
# record_id is continuous 
record_id <- 1:10
print(record_id)
```

``` output
 [1]  1  2  3  4  5  6  7  8  9 10
```

``` r
# Now let's go sampling and put it all together
sample_data <- data.frame(
  record_id = record_id,
  species = sample(species, 10, replace=T),
  sex = sample(sex, 10, replace=T)
)
print(sample_data)
```

``` output
   record_id species sex
1          1       u   F
2          2       e   F
3          3       q   F
4          4       q    
5          5       e   F
6          6       u   M
7          7       e    
8          8       q   F
9          9       u    
10        10       q    
```

And just like that we created a 'dummy' dataset from scratch!
Notice that we could also have compiled the same type of dataset in a single line by creating each vector already within the `data.frame()`


``` r
sample2_data <- data.frame(
  record_id = 1:10,
  species = sample(letters[1:3], 10, replace=T),
  sex = sample(c('M','F',''), 10, replace=T)
)
print(sample2_data)
```

``` output
   record_id species sex
1          1       c   M
2          2       b   F
3          3       c    
4          4       b    
5          5       c    
6          6       a   M
7          7       a   F
8          8       b   M
9          9       a   F
10        10       b   M
```

**Important**: Notice that the outputs of if you want the outputs to be EXACTLY the same each time, but you are using `sample()` which is an inherently random process, you must first use `set.seed()` and share that with your helper too.


``` r
set.seed(1) # set seed before recreating the sample
sample_data <- data.frame(
  record_id = 1:10,
  species = sample(letters[1:3], 10, replace=T),
  sex = sample(c('M','F',''), 10, replace=T)
)
print(sample_data)
```

``` output
   record_id species sex
1          1       a    
2          2       c   M
3          3       a   M
4          4       b   M
5          5       a   F
6          6       c   F
7          7       c   F
8          8       b   F
9          9       b    
10        10       c   M
```

::: callout
Adding a `set.seed()` at the start of your reprex will ensure anyone else who runs the same code **in the same order** will always get the same results.
However, if using it more generally, you may want to read more about it.
For example, in the example below we set a seed of 2 and then run `sample(10)` twice.
You will notice that the output of each sample run is not the same.
However, if you run the whole code again, you will see that each of the outputs actually do stay the same.


``` r
set.seed(2)
sample(10)
```

``` output
 [1]  5  6  9  1 10  7  4  8  3  2
```

``` r
sample(10)
```

``` output
 [1]  1  3  6  2  9 10  7  5  4  8
```
:::

Great!
Now we need to check whether it works within our code and whether it reproduces our issue


``` r
# Minimal code [or whatever we end up with] 
sample_subset <- sample_data %>% # replace rodents with our sample dataset
  filter(species == c("a", "b"), # replace species with those from our sample dataset
         sex == c("F", "M")) # this can stay the same because we recreated it the same

table(sample_subset$sex, sample_subset$species)
```

``` output
   
    a b
  F 1 0
  M 0 1
```

It works!
Our sample size has unexpectedly been reduced to just 2 observations, when we would have expected a sample of 8, based on the sample_data output above.
Wherever the issue lies, we were able to successfully replicate it in our minimal 'dummy' dataset.

::: challenge
### Exercise 5: Your turn!

Now practice doing it yourself.
Create a data frame with:

A. One categorical variable with 2 levels and one continuous variable.
B.
One continuous variable that is normally distributed.
C.
Name, sex, age, and treatment type.
:::

## 3.6 Using your own data set

Even once you master the art of creating 'dummy' datasets, there may be occasions in which your data or your issue is maybe too complex and you can't seem to replicate the issue.
Or maybe you still think using your own data would just be easier.

In cases when you want to make your own data minimal and reproducible, you will want to take a similar approach to what we did in Episode 2 when making our code minimal.
Keep what is essential, get rid of the rest.
In other words, we will want to subset our data into a smaller, more digestible chunk.

The question still arises: how do I know what is essential?

Use the same guiding questions that we used earlier!

1.  How many (or rather which) variables do we need?
2.  What data type is each variable? (less necessary, since we are keeping the actual variables)
3.  How many levels and/or observations are necessary? (potentially still useful, we don't want to get rid of more than we need)
4.  Should the values be distributed in a specific way? (they are as they are, but worth keeping in mind in terms of how we are removing observations)
5.  Are there any NAs that could be relevant?

Based on our previous answers we end up with:

1.  We need species, sex, and maybe record_id
2.  Species and sex are categorical, record_id is a continuous count of our observations.
3.  As we said earlier, we want 3 each for species and sex, which happens to already be the case. And we could reduce our record_id size to \~10.
4.  Not really, but we want to make sure that when we reduce the number of observations we still have observations in each of the 3 levels in species and sex.
5.  No NA's, but we still don't know if the blanks are relevant, so let's make sure we keep at least one.

Now that we have a clearer goal, let's subset our data.

Useful functions for subsetting a dataset include `subset()`, `head()`, `tail()`, and indexing with [] (e.g., iris[1:4,]).
Alternatively, you can use tidyverse functions like `select()`, and `filter()` from the tidyverse.
You can also use the same `sample()` functions we covered earlier.

*Note*: you should already have an understanding of how to subset or wrangle data using the tidyverse from the R for Ecology lesson.
If not, go check it out!
[insert link to lesson]


``` r
# Remember your minimal code
krats_subset <- rodents %>%
  filter(species == c("ordii", "spectabilis"),
         sex == c("F", "M"))

table(krats_subset$sex, krats_subset$species)
```

``` output
   
    ordii spectabilis
  F   350           0
  M     0         626
```

::: challenge
### Exercise 6: Think quick!

Which dataset are we trying to make minimal and reproducible?
Hint: the two datasets we can see are krats_sebset and rodents
:::

Given that the code that is going wrong is that which creates krats_subset, we need to create a minimal reproducible version of rodents!
We can then insert our new_rodent dataset in place of the original rodent one.

::: instructor
Make sure participants understand the distinction we are trying to make and why it matters.
It may not be straightforward.
:::

**Step 1: select the variables of interest**


``` r
# subset rodent into new_rodent to make it minimal
# Note: there are many ways you could do this!
new_rodent <- rodents %>% 
  # 1. select the variables of interest
  select(record_id, species, sex)
  # PAUSE. Does this work so far?
print(new_rodent)
```

``` output
   record_id      species sex
1          1     albigula   M
2          2     albigula   M
3          3     merriami   F
4          4     merriami   M
5          5     merriami   M
6          6       flavus   M
7          7     eremicus   F
8          8     merriami   M
9          9     merriami   F
10        10       flavus   F
11        11  spectabilis   F
12        12     merriami   M
13        13     merriami   M
14        14     merriami    
15        15     merriami   F
16        16     merriami   F
17        17  spectabilis   F
18        18 penicillatus   M
19        19       flavus    
20        20  spectabilis   F
21        21     merriami   F
22        22     albigula   F
23        23     merriami   M
24        24     hispidus   M
25        25     merriami   M
26        26     merriami   M
27        27     merriami   M
28        28     merriami   M
29        29 penicillatus   M
30        30  spectabilis   F
31        31     merriami   F
32        32     merriami   F
33        33     merriami   F
 [ reached 'max' / getOption("max.print") -- omitted 16115 rows ]
```

**Step 2-5: reduce the number of observations to \~10 while making sure the dataset still contains at least 3 species and at least 3 sexes**

While the rest is just one step, it is the trickiest, because this is where we want to ensure the key elements of our original dataset, as defined earlier, are preserved.

::: challenge
### Exercise 7: Try it yourself

How would you continue the subsetting pipeline?
How could you reduce the number of observations while **making sure you still have at least 3 species and 3 sexes left**?
Hint: there is no single right answer!
Trial and error works wonders.
:::


``` r
set.seed(1)
new_rodents <- rodents %>% 
  # 1. select the variables of interest
  select(record_id, species, sex) %>%
  slice_sample(n=4, replace = F, by='sex')
print(new_rodents)
```

``` output
   record_id     species sex
1       2359    merriami   M
2      16335    albigula   M
3       9910       ordii   M
4       8278       ordii   M
5      12038    merriami   F
6       7862   megalotis   F
7       9221    albigula   F
8       1335 spectabilis   F
9       9862     harrisi    
10     14979    merriami    
11     11333   spilosoma    
12       351 leucogaster    
```

The code ran wihtout issues, yay!
But do we end up with what we were looking for?

1.  Doe we have \~10 observations? Yes! 9 seems good enough
2.  Do we have at least 3 species? Yes! We have 7 (we could choose to reduce this further)
3.  Do we have at least 3 sexes? Yes! M, F, and blank

Great!
All of our requirements are fulfilled.
Now let's see if it replicates our issue when we add it to our minimal code.

Note: `slice_sample()` and similar functions allow you to specify and customize how exactly you want that sample to be taken (check the documentation!).
For example, you can specify a proportion of rows to select, specify how to order variables, whether ties [may require more explanation] should be kept together, or even whether to weigh certain variables.
All of this allows you to keep aspects of your dataset that may be relevant and hard to replicate otherwise.

Remember your minimal code:


``` r
krats_subset <- rodents %>%
  filter(species == c("ordii", "spectabilis"),
         sex == c("F", "M"))

table(krats_subset$sex, krats_subset$species)
```

``` output
   
    ordii spectabilis
  F   350           0
  M     0         626
```

We now want to replace rodents with our new_rodents.
Do we need to change anything else?

We actually still have ordii and spectabilis as species in our list, so we can keep it as is.
Same for sex.
So we're all set!


``` r
new_subset <- new_rodents %>%
  filter(species == c("ordii", "spectabilis"),
         sex == c("F", "M"))
```

The code ran without any issues!
But does it replicate our issue?

::: instructor
Note: if the new dataset had an odd number of rows it would spit out a warning giving you a hint as to what the issue may be.
:::

Take a step back to remind yourself of what you are looking for.
What was the issue we had identified?

The number of rows we end up after the filer is lower than expected.

So what would we expect to see with this new dataset?
Since it is nice and short, this makes it a lot easier to predict the outcome.

We are asking for the 2 ordii rows, both males, and the 1 spectabilis row, which is female.


``` r
table(new_subset$sex, new_subset$species)
```

``` output
< table of extent 0 x 0 >
```

Instead we end up with nothing!
Why aren't we getting the rows we are asking for?

Maybe our table is just wrong, let's look at the actual dataset we end up with


``` r
print(new_subset)
```

``` output
[1] record_id species   sex      
<0 rows> (or 0-length row.names)
```

Still nothing!
What is going on??
Well, we certainly replicated our issue.
Time to ask for help!

::: instructor
I love that the `filter {dplyr}` documentation is thoroughly unhelpful on this
:::

But wait, our dataset is now minimal and relevant, but is it reproducible (accessible outside your device)?
Not yet.
We created a subset of our original dataset `rodents` but this came from a file on our computer.
We could share our csv file and add an upload code...
but that's not ideal and it makes it hard to share our problem on a community site.
Remember, the more steps required, the less likely someone will want to help.

Thankfully, there is a nifty function `dput()` that can help us out.
Let's try it and see what happens.


``` r
dput(new_rodents)
```

``` output
structure(list(record_id = c(2359L, 16335L, 9910L, 8278L, 12038L, 
7862L, 9221L, 1335L, 9862L, 14979L, 11333L, 351L), species = c("merriami", 
"albigula", "ordii", "ordii", "merriami", "megalotis", "albigula", 
"spectabilis", "harrisi", "merriami", "spilosoma", "leucogaster"
), sex = c("M", "M", "M", "M", "F", "F", "F", "F", "", "", "", 
"")), class = "data.frame", row.names = c(NA, -12L))
```

It spit out a hard-to-read but not excessively long chunk of code.
This code, when run, will recreate our `new_rodents` dataset!
We can also break it down and label it further to help the reader.


``` r
reprex_data <- structure(list(
  
# a unique identifier
record_id = c(2359L, 16335L, 9910L, 8278L, 12038L, 7862L, 9221L, 1335L, 9862L, 14979L, 11333L, 351L), 

# a list of species
species = c("merriami", "albigula", "ordii", "ordii", "merriami", "megalotis", "albigula", "spectabilis", "harrisi", "merriami", "spilosoma", "leucogaster"), 

# a list of sexes. Note: this includes some blanks!
sex = c("M", "M", "M", "M", "F", "F", "F", "F", "", "", "", "")),

class = "data.frame", row.names = c(NA, -12L))

print(reprex_data)
```

``` output
   record_id     species sex
1       2359    merriami   M
2      16335    albigula   M
3       9910       ordii   M
4       8278       ordii   M
5      12038    merriami   F
6       7862   megalotis   F
7       9221    albigula   F
8       1335 spectabilis   F
9       9862     harrisi    
10     14979    merriami    
11     11333   spilosoma    
12       351 leucogaster    
```

Ta-da!
Now they can easily recreate our minimal dataset and use it to run the minimal code.
However, was that really easier than creating a dataset from scratch?

And sure, you could just use `dput()` on your original dataset.
It would work.
But that wouldn't be very considerate to those who are trying to help.
Try it.


``` r
#dput(rodents)
```

It becomes a huge chunk of code!
When clearly we don't need all of that.

Remember, we want to keep everything minimal for many reasons:

-   to make it easy for our helpers to understand our data and code
-   to allow helpers to quickly focus their efforts on the right factors
-   to make the problem-solving process as easy and painless as possible
-   bonus: to help *us* better understand and zero-in on the source of our issue, often stumbling upon a solution along the way

Nevertheless, it remains an option for when your data appears too complex or you are not quite sure where your error lies and therefore are not sure what minimal components are needed to reproduce the example.

## 3.7 Using an R-build dataset

The last approach we mentioned is to build a minimal reproducible dataset based on the datasets that already exist within R (and therefore everyone would have access to).

A list of readily available datasets can be found using `library(help="datasets")`.
You can then use `?` in front of the dataset name to get more information about the contents of the dataset.

For a more detailed discussion of the benefits of using this approach see [insert something]

This approach essentially blends the skills we already learned in the first two.
We need to identify a dataset with appropriate variables that match the "key elements" of our original dataset.
We then need to further reduce that dataset to a minimal, relevant, number or rows.
Once again, we can use the previously learned functions such as `select()`, `filter()`, or `sample()`.

Since we already practiced everything you need, why not try it yourself?

:::: challenge
### Exercise 8: Extra Challenge

Using the "HairEyeColor" dataset, create a minimal reproducible dataset for the same issue and minimal code we have been exploring.
1.
Start by using `?HairEyeColor` to read a description of the dataset and `View(HairEyeColor)` to see the actual dataset.
2.
Which variables would be a good match for our situation?
What are our requirements?
3.
How can we subset this dataset to make it minimal and still replicate our issue?

::: solution
Remember, there are many possible solutions!
The most important feature is that the example dataset can replicate the issue when used within our minimal code.

The following is 1 possible solution:

We selected Hair and Eye as replacements for species and sex because they are both categorical and have at least 3 levels.
We don't strictly need anything else.
We will call our new `rodents` replacement `hyc`.
We set a seed because we want a random sample.


``` r
set.seed(1)

# the dummy dataset
hyc <- as.data.frame(HairEyeColor) %>% # oh no! Needs to be converted to df -- might need to change example or have them figure that one out... or we can give them this first line.
  select(Hair, Eye) %>%
  slice_sample(n=10)
print(hyc)
```

``` output
    Hair   Eye
1  Black Hazel
2  Blond Brown
3    Red  Blue
4  Black Brown
5  Brown Brown
6    Red  Blue
7    Red Hazel
8  Brown Green
9  Brown Brown
10   Red Brown
```

``` r
# the minimal code
hyc_subset <- hyc %>%
  filter(Hair == c('Red','Blonde'),
         Eye == c('Blue', 'Brown'))

# illustrating the issue
table(hyc_subset$Hair, hyc_subset$Eye) 
```

``` output
       
        Brown Blue Hazel Green
  Black     0    0     0     0
  Brown     0    0     0     0
  Red       0    1     0     0
  Blond     0    0     0     0
```

``` r
# the whole subset
print(hyc_subset)
```

``` output
  Hair  Eye
1  Red Blue
```

``` r
# But we know there are more!
table(hyc$Hair, hyc$Eye) # Reds have 2 Blue and 1 Brown, and Blonds have 1 Brown!
```

``` output
       
        Brown Blue Hazel Green
  Black     1    0     1     0
  Brown     2    0     0     1
  Red       1    2     1     0
  Blond     1    0     0     0
```
:::
::::

::: callout
*What about NAs?* If your data has NAs and they may be causing the problem, it is important to include them in your example dataset.
You can find where there are NAs in your dataset by using `is.na`, for example: `is.na(krats$weight)`.
This will return a logical vector or TRUE if the cell contains an NA and FALSE if not.
The simplest way to include NAs in your dummy dataset is to directly include it in vectors: `x <- c(1,2,3,NA)`.
You can also subset a dataset that already contains NAs, or change some of the values to NAs using `mutate(ifelse())` or substitute all the values in a column by sampling from within a vector that contains NAs.

One important thing to note when subsetting a dataset with NAs is that subsetting methods that use a condition to match rows won’t necessarily match NA values in the way you expect.
For example


``` r
test <- data.frame(x = c(NA, NA, 3, 1), y = rnorm(4))
test %>% filter(x != 3) 
```

``` output
  x          y
1 1 -0.3053884
```

``` r
# you might expect that the NA values would be included, since “NA is not equal to 3”. But actually, the expression NA != 3 evaluates to NA, not TRUE. So the NA rows will be dropped!
# Instead you should use is.na() to match NAs
test %>% filter(x != 3 | is.na(x))
```

``` output
   x          y
1 NA  0.4874291
2 NA  0.7383247
3  1 -0.3053884
```
:::

::: keypoints
-   A minimal reproducible dataset contains (a) the minimum number of lines, variables, and categories, in the correct format, to replicate your issue; and (b) it must be fully reproducible, meaning that someone else can access or run the same code to reproduce the dataset needed for your reprex.
-   To make it accessible, you can create a dataset from scratch using `as.data.frame`, you can use an R dataset like `cars`, or you can use a subset of your own dataset and then use `dput()` to generate reproducible code.
:::

## Bonus: Additional Practice

Here are some more practice exercises if you wish to test your knowledge

::: challenge
### Extra Practice? Would need to change from mpg, since that's from ggplot

For each of the following, identify which data are necessary to create a minimal reproducible dataset using `mpg`.

A)  We want to know how the highway mpg has changed over the years\
B)  We need a list of all "types" of cars and their fuel type for each manufacturer\
C)  We want to compare the average city mpg for a compact car from each manufacturer\
:::

**(I copied these from excercise 6 in the google doc... but I'm not sure that they are getting at the point of the lesson...)**

:::: challenge
### Another Excercise

Each of the following examples needs your help to create a dataset that will correctly reproduce the given result and/or warning message when the code is run.
Fix the dataset shown or fill in the blanks so it reproduces the problem.

A)  `set.seed(1)` `sample_data <- data.frame(fruit = rep(c(“apple”, “banana”), 6), weight = rnorm(12))` `ggplot(sample_data, aes(x = fruit, y = weight)) + geom_boxplot()` **HELP: how do I insert an image from clipboard?? Is it even possible?**
B)  bodyweight \<- c(12, 13, 14, **,** ) max(bodyweight) [1] NA
C)  sample_data \<- data.frame(x = 1:3, y = 4:6) mean(sample_data$x)
    [1] NA
    Warning message:
    In mean.default(sample_data$x): argument is not numeric or logical: returning NA
D)  sample_data \<- \_\_\_\_ dim(sample_data) NULL

::: solution
A)  "fruit" needs to be a factor and the order of the levels must be specified: `sample_data <- data.frame(fruit = factor(rep(c("apple", "banana"), 6), levels = c("banana",          "apple")), weight = rnorm(12))`
B)  one of the blanks must be an NA
C)  **?? + what's really the point of this one?**
D)  `sample_data <- data.frame(x = factor(1:3), y = 4:6)`
:::
::::

Great work!
We've created a minimal reproducible example.
In the next episode, we'll learn about `{reprex}`, a package that can help us double-check that our example is reproducible by running it in a clean environment.
(As an added bonus, `{reprex}` will format our example nicely so it's easy to post to places like Slack, GitHub, and StackOverflow.)
