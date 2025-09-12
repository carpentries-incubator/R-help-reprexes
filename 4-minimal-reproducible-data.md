---
title: "Minimal reproducible data"
teaching: 60
exercises: 34
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
-   Appreciate why it is important to provide example data that is minimal and reproducible
-   Recognize that there are different approaches to providing example data
-   Identify the relevant aspects of your data
-   Create a suitable reprex dataset from scratch
-   Share your original dataset in a way that is minimal and reproducible
-   Subset a built-in dataset to use in your reprex
:::

## 4.1 What is a minimal reproducible dataset and why do I need it?

::: instructor
Development note: Previous episodes should have already introduced the concept of a minimal reproducible examples, why it is important, and talked about making the code minimal and reproducible.
This data episode is part of being reproducible and should perhaps be followed-up with more details on reproducibility if not previously mentioned (e.g., reprex needs minimal code - check - dependencies, which include minimal data - check - and other basic information like your system and R version as well as contextual information on your data?).
:::

Mickey has now (1) narrowed down their problem area *(they are losing observations during filtering)*, (2) stripped down their code to make it minimal, and have been working on making it reproducible by including all necessary dependencies (so anyone can simply copy-paste the code into their system to replicate their problem).
They have done a good job so far, but there is still one dependency missing, can you guess what it is?

:::: challenge
### Exercise 1

If Remy received the current script and tried to run it as-is, would it work? If not, why?

Below is a reminder of what Mickey's script currently looks like.


``` r
# Mickey's current minimal code

library(readr)
library(dplyr)

surveys <- read_csv("data/surveys_complete_77_89.csv")
```

``` output
Rows: 16878 Columns: 13
── Column specification ────────────────────────────────────────────────────────
Delimiter: ","
chr (6): species_id, sex, genus, species, taxa, plot_type
dbl (7): record_id, month, day, year, plot_id, hindfoot_length, weight

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

``` r
# Filter to known sex
rodents_subset <- surveys %>%
  filter(sex == c("F", "M"))

# Subsetted dataset
table(rodents_subset$sex)
```

``` output

   F    M 
3656 4145 
```

``` r
# Original dataset
table(surveys$sex) # the numbers don't match!
```

``` output

   F    M 
7318 8260 
```

::: solution
The code would fail to run because Remy probably doesn't have the "surveys_complete_77_89.csv" file, or, more specifically doesn't have that file in the specified "data" folder.
Indeed, we have no idea what Remy's file management system looks like!
:::
::::

A **reprex code will always require a data object** in order to run!

To make sure Remy can work on the reprex anywhere, Mickey needs to ensure Remy has the required dataset to run it.

As with the code, a reprex's dataset should also be **minimal--free of unnecessary information** and **reproducible--such that anyone can recreate it**.

Indeed, Step 3 on the roadmap tells us to create a minimal reproducible dataset.
However, Mickey figures it would be faster and easier to send Remy the current minimal code along with the original csv file.
After all, the code already includes how to read-in the csv file, right?
There is no need to create another dataset.

:::: challenge
### Exercise 2: Reflect

Mickey feels like sharing the original data file would be easier, but who would find it easier, Mickey or Remy?

::: solution
Mickey is thinking that it would be easier for themselves, not necessarily for Remy.

**Remember:** one of the goals of creating a reprex is to **help the helpers**.
They don't have to help, they are volunteering their time.
As such, they deserve to be treated with kindness and respect.
If you send a code with a separate file, not only is the code not reproducible, but you are creating extra work for the helper.
Extra unnecessary and potentially time-consuming steps are more likely to make helpers frustrated rather than happy to help.

If you find yourself getting frustrated at how much time and effort creating a reprex might be taking, remember that (1) **trusting the process may reveal the solution along the way**; and (2) **being kind, clear, and helpful will reward you with a quicker, more accurate solution** (and will make it more likely that a helper will help again in the future).
:::
::::

Remy's feelings aside, while this strategy could still work in this particular instance, there are many reasons why sharing original data may not be possible or recommended.
Can you think of any?
See callout below for examples.

::: callout
### Think twice before sharing your data!

Even though there are times when sharing your original dataset seems like the easiest approach, there are several reasons why sharing original data may not be possible or recommended.

The original dataset may be:

-   too large - the Portal dataset is \~35,000 rows with 13 columns and contains data for decades. That's a lot!
-   private - the dataset might not be published yet, it may not be yours to share, or maybe it includes protected information such as personal medical information or the location of endangered species.
-   hard to send - on most online forums, you can't attach supplemental files (more on this later). Even if you are just sending data to a colleague, file paths can get complicated, the data might be too large to attach, etc.
-   complicated - it would be hard to locate the relevant information. One example to steer away from are needing a 'data dictionary' to understand all the meanings of the columns (e.g. what is "plot type" in `ratdat`?) We don't our helper to waste valuable time to figure out what everything means.
-   highly derived/modified from the original file. You may have already done a bunch of preliminary data wrangling you don't want to include when you send the example, so you would need to provide the intermediate dataset directly to your helper.
:::

While Mickey does not have to create a brand new example dataset, they should at least work to make their original data minimal and reproducible (see the reflection exercise above).

While it may sometimes feel like unnecessary effort, the process of creating a minimal dataset will not only help others help you, but also allow you to **better understand your data** and often **discover the source of the problem** without the need for external help.
By removing extraneous information and only keeping what is required to replicate the issue, we can ensure both we and our helper are be able to easily see how the data is structured and where the problem arises.
Furthermore, we have already seen how sometimes the source of the problem isn't actually the code, but rather the data!
Providing an appropriate example, or mock dataset **allows a helper to better investigate and manipulate that data** to fix the problem (as if they were working directly on your computer).

See what the mock dataset of a reprex can look like in the callout below.

::: instructor
While formatted as a callout, the pro-tip content is critical for students to develop the right mental model of what an example dataset looks like.
:::

::: callout
### Pro-tip: documentation examples are a reprex

An example of what minimal reproducible examples look like can be found in the `?help` section, in R Studio.
When looking at the documentation for any function, scroll all the way down to where they list examples.
These will usually be minimal and reproducible, since they are intended to be directly copy-pasted and run by anyone.

For example, let's look at the function `mean`:


``` r
?mean
```

When we scroll all the way down, we see examples that can be run directly on the console, with no additional code.
Try to copy-paste the following in your script.
Does it run?


``` r
xm <- mean(x)
```

``` error
Error: object 'x' not found
```

``` r
c(xm, mean(x, trim = 0.10))
```

``` error
Error: object 'xm' not found
```

It is missing the first line which actually creates the dataset `x`.
Try again with the new line.


``` r
x <- c(0:10, 50)
xm <- mean(x)
c(xm, mean(x, trim = 0.10))
```

``` output
[1] 8.75 5.50
```

Now it should run as intended!

In this example, **x is the mock dataset** consisting of just 1 variable.
**Notice how it was created as part of the example.** This will be your goal with your reprex.

When your data is uploaded from a separate file, that file becomes a dependency in your code–it cannot run without it.
Since a reprex needs to be reproducible by anyone, **we need to think about our data in a different way–as a mock object created in the script itself**.
:::

In summary, just like with the code, **a minimal reproducible dataset must be:**

-   **minimal**: it only contains information required to run your minimal code and replicate the problem. You can also think of this as being **relevant** to the problem.
-   **reproducible**: it must be **accessible** to someone without your computer, and it must consistently **replicate your problem**. This means it also needs to be **complete**, meaning there are no dependencies that have been omitted (e.g., packages).

::: instructor
This exercise is intended to address the LO "Describe a minimal reproducible dataset" although it better targets the learner's ability to *identify* an appropriate reprex dataset.
:::

:::: challenge
### Ecercise 3: Test your knowledge!

Let's say we want to know the average weight of all the species in our `rodents` dataset from episode 2 (also below if you no longer have it).
We try to use the following code...


``` r
# The previously created "rodents" dataset
rodents <- surveys %>% filter(taxa == "Rodent")

# Mean rodent weight
mean(rodents$weight)
```

``` output
[1] NA
```

...but it returns NA!
We don't know why that is happening and we want to ask for help.

Which of the following represents a minimal reproducible dataset for the minimal code `mean(rodents$weight)`?
Can you describe why the other ones are not?

A)  `sample_data <- data.frame(month = rep(7:9, each = 2), hindfoot_length = c(10, 25, 14, 26, 30, 17))`
B)  `sample_data <- data.frame(weight = rnorm(10))`
C)  `sample_data <- data.frame(weight = c(100, NA, 30, 60, 40, NA))`
D)  `sample_data <- rodents_modified[1:20,]`

**Hint:** the data needs to (1) run within your code, and (2) replicate the problem.
To test whether each new `sample_data` works, try inputting it back into the function that is giving you problems.
E.g., use `mean(sample_data$weight)`

::: solution
### Solution

The correct answer is C!

A)  does not include the variable of interest (weight).
B)  does not replicate the problem (NA result with a warning message)--the code runs just fine.
C)  minimal and reproducible.
D)  is not reproducible. Sample randomly samples 10 items; sometimes it may include NAs, sometime it may not (not guaranteed to replicate the error). It can be used if a seed is set (see next section for more info).
E)  uses a dataset that isn't accessible without previous data wrangling code–the object rodents_modified doesn't exist.
F)  Inaccessible data. It provides the path to a file on someone else's computer.
:::
::::

::: callout
### Don't use screenshots

Screenshots are another example of an inappropriate and unhelpful way to share your data with a helper.
While they can be used as a quick snapshot of what the data looks like, the data within a screenshot cannot be manipulated and a helper would have to create their own mock dataset to run the code.
:::

## 4.2 Three different approaches

In general, there are 3 common ways to provide minimal reproducible data for a reprex.

-   Add a few lines of code to create a mock dataset with the same key characteristics as the original data (like in the example sections of documentations).

-   Subset the original data to be minimal and reproducible, then use  function like `dput()`.

-   Subset a dataset that is already provided by R (e.g., `cars`, `npk`, `penguins`, etc.).
    For a complete list, use `library(help = "datasets")`.

::: instructor
It would be nice if we could toggle the callout below or at least the table so that it doesn't take so much room since it is not an essential part of the lesson.
:::

::: callout
## Pros and Cons

The developers of this lesson believe everyone is entitled to use any option they prefer, therefore the rest of this episode will expand on each of the 3 approaches listed above.
However, within the data science community, opinions differ on which method is best recommended.
Below is a summary table of advantages and disadvantages of each approach based on many conversations with several data science groups.

+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------------------------------------+
|                       | **Advantages**                                                                                                                                                                                             | **Disadvantages**                                                                                                         |
+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------------------------------------+
| **Data from Scratch** | -   Often the most concise                                                                                                                                                                                 | -   Can be intimidating                                                                                                   |
|                       |                                                                                                                                                                                                            |                                                                                                                           |
|                       | -   Easiest for helpers                                                                                                                                                                                    | <!-- -->                                                                                                                  |
|                       |                                                                                                                                                                                                            |                                                                                                                           |
|                       | -   Helps problem-solve along the way (e.g., identify what data aspects are generating the problem)                                                                                                        | -   Requires good understanding of your data                                                                              |
|                       |                                                                                                                                                                                                            |                                                                                                                           |
|                       | -   More universally applicable: Easy to share, collaborate, teach, and understand                                                                                                                         | -   Harder to generate if the error is idiosyncratic or dependent on having a large dataset                               |
|                       |                                                                                                                                                                                                            |                                                                                                                           |
|                       | -   Avoids privacy/security concerns                                                                                                                                                                       | -   Time-consuming if unpracticed                                                                                         |
|                       |                                                                                                                                                                                                            |                                                                                                                           |
|                       | -   Lets you clearly illustrate the sought outcome                                                                                                                                                         | -   Iterative (you may need to trial and error a few times to replicate the problem)                                      |
|                       |                                                                                                                                                                                                            |                                                                                                                           |
|                       | -   Uses important-to-learn skills                                                                                                                                                                         | -   More likely to require analogies, less interpretable/concrete, more likely to require greater context                 |
|                       |                                                                                                                                                                                                            |                                                                                                                           |
|                       | -   Easier with practice                                                                                                                                                                                   | -   Risks generating XY problems–make sure you are asking the right question/replicating the right problem                |
+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------------------------------------+
| **R-built Data**      | -   Simple and easy to share–no need to provide additional data                                                                                                                                            | -   May require a good mental model of the problem                                                                        |
|                       |                                                                                                                                                                                                            |                                                                                                                           |
|                       | -   Familiar–helpers already know the data structure                                                                                                                                                       | -   Harder if the error is idiosyncratic                                                                                  |
|                       |                                                                                                                                                                                                            |                                                                                                                           |
|                       | -   Potentially faster than starting from scratch (i.e. faster than generating rows/columns de novo).                                                                                                      | -   Greatest risk of generating XY problems–make sure you are asking the right question/replicating the right problem     |
|                       |                                                                                                                                                                                                            |                                                                                                                           |
|                       | -   No privacy/security concerns                                                                                                                                                                           | -   Iterative (you may need to trial and error a few times to replicate the problem)                                      |
|                       |                                                                                                                                                                                                            |                                                                                                                           |
|                       | -   Can easily be manipulated or simplified                                                                                                                                                                | -   Need to re-think the question so it matches a different dataset and context–mental gymnastics                         |
|                       |                                                                                                                                                                                                            |                                                                                                                           |
|                       | -   Generalizes the problem                                                                                                                                                                                | -   Still need to choose which dataset and variables are more appropriate                                                 |
+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------------------------------------+
| **Your Data**         | -   Can require the least mental effort                                                                                                                                                                    | -   Less growth-minded if chosen as an "easy way out"--skips the learning process and any insights you could have gained. |
|                       |                                                                                                                                                                                                            |                                                                                                                           |
|                       | -   Problem is easy to replicate even if you don’t understand it at all                                                                                                                                    | -   Easy to do poorly and think that you're doing it well; perceived "easiness" leads to overcomplication/confusion       |
|                       |                                                                                                                                                                                                            |                                                                                                                           |
|                       | -   Accurately represents the actual problem; avoids XY problems.                                                                                                                                          | -   Leaves all the work to the helpers if you don’t also work to minimize it–less motivation for harder work              |
|                       |                                                                                                                                                                                                            |                                                                                                                           |
|                       | -   Richer context may intrigue/motivate helpers                                                                                                                                                           | -   Could obfuscate the problem if not minimized–less likely to find a quick answer                                       |
|                       |                                                                                                                                                                                                            |                                                                                                                           |
|                       | -   Can be quicker if dataset is small                                                                                                                                                                     | -   More difficult to share–may be large/messy                                                                            |
|                       |                                                                                                                                                                                                            |                                                                                                                           |
|                       | -   May be required for idiosyncratic problems that are based on aspects of the data itself that you don’t know about (e.g.  when the data itself, rather than the code per se, is central to the problem) | -   Security/privacy/sanitizeation problems                                                                               |
|                       |                                                                                                                                                                                                            |                                                                                                                           |
|                       | -   Captures data structures that are difficult or time-consuming to replicate if you are a novice                                                                                                         |                                                                                                                           |
+-----------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------------------------------------------------+
:::

## 4.3 Creating a mock dataset from scratch

While starting from scratch can be daunting at first, it becomes easier and faster with practice.
Once you are familiar with the basic building blocks, it is a straight-forward method of creating a minimal reproducible dataset.
This is also the preferred method for other activities that require a reprex (e.g., teaching, collaborating, developing, etc.), and it often provides valuable problem-solving insights.
So let's breakdown this process to be more digestible!

Mickey is still new at this and has 2 pressing questions:

1.  How do I create a dataset from scratch?
2.  How do I know which key aspects of my data to recreate?

Let's start with the first.

There are many ways one can create a dataset in R (these should be familiar if you took the Carpentries lesson [Data Analysis and Visualization in R for Ecologists](https://datacarpentry.org/R-ecology-lesson/)).

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
x <- sample(1:10, 5)
x
```

``` output
[1] 10  5  6  1  9
```

Or you can randomly sample from a normal distribution


``` r
x <- rnorm(10)
x
```

``` output
 [1] -0.20824156  0.49970612  2.57149310  0.66824811 -0.82295861  0.31894033
 [7]  0.04703593 -1.33676815 -0.28820645  0.22620139
```

You can also use built-in vectors like `letters` to create factors.


``` r
x <- sample(letters[1:4], 20, replace=T)
x
```

``` output
 [1] "b" "b" "b" "c" "d" "c" "d" "b" "b" "b" "a" "c" "b" "c" "d" "a" "b" "d" "a"
[20] "b"
```

Remember that **a data frame is just a collection of vectors**.
You can create a data frame using `data.frame` (or `tibble` in the `dplyr` package), and then define a vector for each variable.


``` r
data <- data.frame (x = sample(letters[1:3], 20, replace=T), 
                    y = rnorm(1:20))
head(data)
```

``` output
  x          y
1 b  1.5040195
2 a -0.1995433
3 a -1.8742752
4 b -0.5683280
5 b  0.1528315
6 c  1.1181352
```

**However**, when sampling at random you must remember to `set.seed()` before sending it to someone to make sure you both get the same numbers!

::: callout
For more handy functions for creating data frames and variables, see the [**cheatsheet**].
Some questions may require specific formats.
For these, you can use any of the provided `as.someType` functions: `as.factor`, `as.integer`, `as.numeric`, `as.character`, `as.Date`, `as.xts`.
:::

::: instructor
You can skip the challenge below if short on time.
The exercise assesses the LO: "Create a dataset from scratch." There will not be another exercise to practice this, but you will walk through creating the main reprex dataset together, so that may be enough.
**Do not spend too much time on this**.
Students can work in pairs, or you can work all together.
Don't wait for everyone to be done before going through solutions, maybe have them alert you when they finish each one, they can then keep going while they wait.
You can skip giving the solution for C, expecting quicker learners to have tried it for practice while slower learners may not have gotten to it, that's ok!
:::

::: challenge
### Exercise 4: You try! 

Create a data frame with:

A. One categorical variable with 2 levels and one continuous variable.

B. One continuous variable that is normally distributed.

C. Name, sex, age, and treatment type.
:::

## 4.5 Identifying the relevant aspects of your data

No matter which approach you choose to take for providing a dataset, they key is always to identify which elements of the original data are necessary, or relevant, to replicate the problem.
To do so, here are a few guiding questions:

1.  Which variables are necessary to replicate the problem?
2.  What data type (discrete or continuous) is each variable?
3.  How many levels and/or observations are necessary?
4.  Do the values need to be distributed in a specific way?
5.  Are there any NAs that could be relevant?

Let's check back with Mickey and the minimal code they settled on:


``` r
# Mickey's current minimal code

library(readr)
library(dplyr)

surveys <- read_csv("data/surveys_complete_77_89.csv")
```

``` output
Rows: 16878 Columns: 13
── Column specification ────────────────────────────────────────────────────────
Delimiter: ","
chr (6): species_id, sex, genus, species, taxa, plot_type
dbl (7): record_id, month, day, year, plot_id, hindfoot_length, weight

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

``` r
# Filter to known sex
rodents_subset <- surveys %>%
  filter(sex == c("F", "M"))

# Subsetted dataset
table(rodents_subset$sex)
```

``` output

   F    M 
3656 4145 
```

``` r
# Original dataset
table(surveys$sex) # the numbers don't match!
```

``` output

   F    M 
7318 8260 
```

Let's take a closer look at the dataset we need to substitute and then answer the questions outlined earlier.


``` r
head(surveys)
```

``` output
# A tibble: 6 × 13
  record_id month   day  year plot_id species_id sex   hindfoot_length weight
      <dbl> <dbl> <dbl> <dbl>   <dbl> <chr>      <chr>           <dbl>  <dbl>
1         1     7    16  1977       2 NL         M                  32     NA
2         2     7    16  1977       3 NL         M                  33     NA
3         3     7    16  1977       2 DM         F                  37     NA
4         4     7    16  1977       7 DM         M                  36     NA
5         5     7    16  1977       3 DM         M                  35     NA
6         6     7    16  1977       1 PF         M                  14     NA
# ℹ 4 more variables: genus <chr>, species <chr>, taxa <chr>, plot_type <chr>
```

::: challenge
### Exercise 5: Your turn! 

Try to answer the following questions on your own to determine what we need to include in our minimal reproducible dataset:

1.  Which variables does Mickey need to replicate their problem?
2.  What data type (discrete or continuous) is each variable?
3.  How many levels and/or observations are necessary?
4.  Do the values need to be distributed in a specific way?
5.  Are there any NAs that could be relevant?
:::

::: instructor
Give them some time to think it through, maybe in pairs or small groups, but **focus on working through the answers together, even if not everyone has finished**.
Go one question at a time (time to answer the first -\> walk through solution -\> time to answer the second -\> etc.).
:::

Let's go over the answers together and help Mickey build a dataset as we go along!

::: instructor
Begin creating the dataset with the information gained from each question, then you can put it all together.
:::

1.  How many variables does Mickey need to reproduce their problem?

They really just sex, and maybe an identifier like record_id.
This means they potentially only need 1 vector, maybe 2 (remember, each column in a dataframe is essentially a vector, and in "tidy data" should correspond with a variable; each row is then an observation).


``` r
# create 2 variables: sex, and maybe record_id

# a vector for sex:

# a vector for record_id:
```

2.  What data type (discrete or continuous) is each variable?

Sex is a discrete (categorical) variable, while record ID would be continuous.


``` r
# create 2 variables: sex, and maybe record_id

# a vector for sex: categorical

# a vector for record_id: continuous
```

3.  How many levels and/or observations are necessary?

Since Mickey is filtering their dataset down to 2 categories for sex, that means they need at least 3 levels to start with.
In terms of number of observations there don't seem to be specific restrictions so they can just pick a generally nice number like 10.
This is where creating a reprex dataset becomes a bit more of an art than a science; it is common to use trial and error until the problem is replicated accurately.


``` r
# create 2 variables: sex, and maybe record_id

# a vector for sex: categorical with 3 levels 

# a vector for record_id: continuous, ~10
```

4.  Do the values need to be distributed in a specific way?

This question probably isn't going to be relevant most of the time, but certainly worth considering.
If Mickey needed a longer dataset of measurements they may have wanted to make sure it was normally distributed.
If they needed a longer dataset of counts they may have wanted to make sure it was Poisson distributed.
Or maybe they had binary data.
But in this case, Mickey has a fairly short dataset and the code doesn't include anything that should vary depending on the distribution, so it probably doesn't matter.
Again, this process can be one of trial and error.
They can always come back to this question if they are unable to replicate their problem (hint: in which case the distribution may be related to the problem they are having!).

5.  Are there any NAs that could be relevant?

Mickey's data does have NAs for the sex variable.
It might not matter or it could be important, so let's have them put in NAs in the mock dataset just in case.


``` r
# create 2 variables: sex, and maybe record_id

# a vector for sex: categorical with 3 levels, one of which is NA 
sex <- c('M','F',NA)
sex
```

``` output
[1] "M" "F" NA 
```

``` r
# a vector for record_id: continuous, ~10 
record_id <- 1:10 
record_id
```

``` output
 [1]  1  2  3  4  5  6  7  8  9 10
```

``` r
# Now let's go "sampling" and put our "obervations" in a dataframe
sample_data <- data.frame(
  # record_id stays the same, since these are our 10 "observations"
  record_id = record_id,
  # randomly select 10 observations from our list of sexes
  sex = sample(sex, 10, replace=T)
)

# Look at our new dataset
sample_data
```

``` output
   record_id  sex
1          1 <NA>
2          2 <NA>
3          3    M
4          4    F
5          5    F
6          6    F
7          7 <NA>
8          8    F
9          9    F
10        10    M
```

And just like that we helped Mickey create a mock dataset from scratch!
Notice that they could also have compiled the same type of dataset in a single line by creating each vector within `data.frame()`


``` r
sample2_data <- data.frame(
  record_id = 1:10,
  sex = sample(c('M','F', NA), 10, replace=T)
)

sample2_data
```

``` output
   record_id  sex
1          1    M
2          2    F
3          3    M
4          4    F
5          5    F
6          6 <NA>
7          7 <NA>
8          8 <NA>
9          9 <NA>
10        10    M
```

**Important**: Notice that the outputs of the two datasets are not the same.
If you want the outputs to be EXACTLY the same each time, but you are using `sample()` which is an inherently random process, you must first use `set.seed()` and share that with your helper too.


``` r
set.seed(1) # set seed before recreating the sample
sample_data <- data.frame(
  record_id = 1:10,
  sex = sample(c('M','F', NA), 10, replace=T)
)
sample_data
```

``` output
   record_id  sex
1          1    M
2          2 <NA>
3          3    M
4          4    F
5          5    M
6          6 <NA>
7          7 <NA>
8          8    F
9          9    F
10        10 <NA>
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
Now we need to check whether the mock dataset works with the minimal code Mickey created earlier.
Does it run?
Does it replicate the problem they were having?


``` r
# Mickey's reprex (1 approach) 

# Required packages to run the code
library(readr)
library(dplyr)

set.seed(1) # ensures accurate data replication

# Create a mock dataset
sample_data <- data.frame(
  record_id = 1:10,
  sex = sample(c('M','F', NA), 10, replace=T)
)

# The problematic code snippet
sample_subset <- sample_data %>% # replace rodents with our sample dataset
  filter(sex == c("F", "M")) # this can stay the same because we recreated it the same

# Subsetted sample dataset - how many individuals for each sex?
table(sample_subset$sex)
```

``` output

F 
1 
```

``` r
# Original sample dataset - how many individuals for each sex?
table(sample_data$sex) # the numbers don't match!
```

``` output

F M 
3 3 
```

It works!
The sample size has unexpectedly been reduced to just 2 observations, when we would have expected a sample of 8, based on the sample_data output above.
Wherever the issue may lie, we were able to successfully replicate it in this minimal reproducible example.

## 4.6 Using the original data set

Even if you master the art of creating mock datasets, there may be occasions in which your data or problem is too complex and you can't seem to replicate the issue.
Or maybe you still think using your original data would just be easier.

In cases when you want to make your own data minimal and reproducible, you will want to take a similar approach to what we did in Episode 3 when making the code minimal.
Keep what is essential, get rid of the rest.
In other words, we will want to subset our data into a smaller, more digestible chunk.

The question still arises: how do I know what is essential?

Use the same guiding questions that we used earlier!

1.  Which variables are necessary to replicate the problem?
2.  What data type (discrete or continuous) is each variable? (perhaps less necessary, since you are keeping the original variables)
3.  How many levels and/or observations are necessary? (we don't want to get rid of more than we need)
4.  Do the values need to be distributed in a specific way? (worth keeping in mind in terms of how we are removing observations)
5.  Are there any NAs that could be relevant?

::: instructor
You can give them time to answer those questions on their own first, like in Exercise 5, or just go through them together.
:::

Based on our previous answers we end up with:

1.  We need species, sex, and maybe record_id
2.  Species and sex are categorical, record_id is a continuous count of our observations.
3.  As we said earlier, we want 3 each for species and sex, which happens to already be the case. And we could reduce our record_id size to \~10.
4.  Not really, but we want to make sure that when we reduce the number of observations we still have observations in each of the 3 levels in species and sex.
5.  NA's are present in the sex variable, so let's make sure we keep at least one.

Now that we have a clearer goal, let's subset the data.

Useful functions for subsetting a dataset include `subset()`, `head()`, `tail()`, and indexing with [] (e.g., iris[1:4,]).
Alternatively, you can use tidyverse functions like `select()`, and `filter()` from the tidyverse.
You can also use the same `sample()` functions we covered earlier.

***Note*****:** you should already have an understanding of how to subset or wrangle data using the tidyverse from the [Data Analysis and Visualization in R for Ecologists](https://datacarpentry.org/R-ecology-lesson/).
If not, go check it out!


``` r
# Mickey's current script

library(readr)
library(dplyr)

surveys <- read_csv("data/surveys_complete_77_89.csv")
```

``` output
Rows: 16878 Columns: 13
── Column specification ────────────────────────────────────────────────────────
Delimiter: ","
chr (6): species_id, sex, genus, species, taxa, plot_type
dbl (7): record_id, month, day, year, plot_id, hindfoot_length, weight

ℹ Use `spec()` to retrieve the full column specification for this data.
ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

``` r
# Filter to known sex
rodents_subset <- surveys %>%
  filter(sex == c("F", "M"))

# Subsetted dataset
table(rodents_subset$sex)
```

``` output

   F    M 
3656 4145 
```

``` r
# Original dataset
table(surveys$sex) # the numbers don't match!
```

``` output

   F    M 
7318 8260 
```

Given that the code that is going wrong is that which creates rodents_subset, we need to create a minimal reproducible version of surveys!
We can then insert our new_surveys dataset in place of the original rodents one.

**Step 1: select the variables of interest**


``` r
# subset rodent into new_rodent to make it minimal
# Note: there are many ways you could do this!
new_surveys <- surveys %>% 
  # 1. select the variables of interest
  select(record_id, sex)
  # PAUSE. Does this work so far?
new_surveys
```

``` output
# A tibble: 16,878 × 2
   record_id sex  
       <dbl> <chr>
 1         1 M    
 2         2 M    
 3         3 F    
 4         4 M    
 5         5 M    
 6         6 M    
 7         7 F    
 8         8 M    
 9         9 F    
10        10 F    
# ℹ 16,868 more rows
```

**Step 2-5: reduce the number of observations to \~10 while making sure the dataset still contains at least 3 species and at least 3 sexes**

While the rest is just one step, it is the trickiest, because this is where we want to ensure the key elements of our original dataset, as defined earlier, are preserved.

::: challenge
### Exercise 6: Your Turn! (5 mins)

How would you continue the subsetting pipeline?
How could you reduce the number of observations while **making sure you still have at least 3 sexes left**?
Hint: there is no single right answer!
Trial and error works wonders.
:::


``` r
set.seed(1)
new_surveys <- surveys %>% 
  # select the variables of interest
  select(record_id, sex) %>%
  # randomly select 4 rows from each sex category
  slice_sample(n=4, replace = F, by='sex') # use ?slice_sample to check the documentation
new_surveys
```

``` output
# A tibble: 12 × 2
   record_id sex  
       <dbl> <chr>
 1      2359 M    
 2     16335 M    
 3      9910 M    
 4      8278 M    
 5     12038 F    
 6      7862 F    
 7      9221 F    
 8      1335 F    
 9      3320 <NA> 
10       343 <NA> 
11     14482 <NA> 
12      9376 <NA> 
```

The code ran without issues, hooray!
But do we end up with what we were looking for?

1.  Do we have \~10 observations? Yes! 12 sounds good
2.  Do we have at least 3 sexes? Yes! M, F, and NA

Great!
All of our requirements are fulfilled.
Now let's see if it replicates Mickey's problem when we add it to their minimal code.

***Note:*** `slice_sample()` and similar functions allow you to specify and customize how exactly you want that sample to be taken (check the documentation!).
For example, you can specify a proportion of rows to select, specify how to order variables, whether ties **[may require more explanation]** should be kept together, or even whether to weigh certain variables.
All of this allows you to keep aspects of your dataset that may be relevant and hard to replicate otherwise.

Remember the problematic code snippet:


``` r
# Filter to known sex
rodents_subset <- surveys %>%
  filter(sex == c("F", "M"))
```

We now want replace `surveys` with `new_surveys`, and let's change the name of the `rodents_subset` too so we can compare them. Does that problematic code snippet work or do we need to change anything else? 


``` r
# Filter to known sex
new_subset <- new_surveys %>%
  filter(sex == c("F", "M"))
```

The code ran without any errors!
But does it replicate Mickey's problem?

::: instructor
***Note:*** if the new dataset had an odd number of rows it would spit out a warning giving you a hint as to what the source of the problem may be.
:::

Take a step back to remind yourself of what you are looking for.
What was the problem we had identified?

-   The number of rows that remain after the filter is lower than expected.

So what would we expect to see with this new dataset?
Since it is nice and short, this makes it a lot easier to predict the outcome.

-   We should find that both tables list 4 females and 4 males.


``` r
# Before the filter
table(new_surveys$sex) # as expected!
```

``` output

F M 
4 4 
```

``` r
# After the filter
table(new_subset$sex) # oh no! The numbers listed are not what we expect...
```

``` output

F M 
2 2 
```

``` r
# ...which is exactly the problem we were trying to replicate!
```

Why aren't we getting the rows we are asking for?

Maybe our table is just wrong, let's look at the actual dataset we end up with


``` r
new_subset
```

``` output
# A tibble: 4 × 2
  record_id sex  
      <dbl> <chr>
1     16335 M    
2      8278 M    
3     12038 F    
4      9221 F    
```

Still wrong!
What is going on??
We don't have an answer, but we certainly replicated a problem that occurs when we filter the data.
Time to ask for help!

::: instructor
I love that the `filter {dplyr}` documentation is thoroughly unhelpful on this
:::

But wait, Mickey's dataset is now minimal and relevant, but is it reproducible (accessible outside their device)?
Not yet.
We created a subset of their original dataset `rodents` but this came from a file on their computer.
They could share the csv file and add a line of code that uploads it...
but we already said this is not good practice for a reprex, and it makes it hard to ask for help on a community website.
Remember, the more steps required, the less likely someone will want to help.

Thankfully, there is a nifty function `dput()` that can help us out.
Let's try it and see what happens.


``` r
dput(new_surveys)
```

``` output
structure(list(record_id = c(2359, 16335, 9910, 8278, 12038, 
7862, 9221, 1335, 3320, 343, 14482, 9376), sex = c("M", "M", 
"M", "M", "F", "F", "F", "F", NA, NA, NA, NA)), row.names = c(NA, 
-12L), class = c("tbl_df", "tbl", "data.frame"))
```

It spit out a hard-to-read but not excessively long chunk of code.
This code, when run, will recreate the `new_rodents` dataset!
We can also break it down and label it further to help the reader.


``` r
reprex_data <- structure(list(

  # a unique identifier (not actually necessary)
record_id = c(2359, 16335, 9910, 8278, 12038, 
7862, 9221, 1335, 3320, 343, 14482, 9376), 

# A list of sexes. Note: this includes NAs!
sex = c("M", "M", 
"M", "M", "F", "F", "F", "F", NA, NA, NA, NA)), 

# no row names
row.names = c(NA, -12L), 

# type of data
class = c("tbl_df", "tbl", "data.frame"))

# see the dataset
print(reprex_data)
```

``` output
# A tibble: 12 × 2
   record_id sex  
       <dbl> <chr>
 1      2359 M    
 2     16335 M    
 3      9910 M    
 4      8278 M    
 5     12038 F    
 6      7862 F    
 7      9221 F    
 8      1335 F    
 9      3320 <NA> 
10       343 <NA> 
11     14482 <NA> 
12      9376 <NA> 
```

Ta-da!
Now anyone can easily recreate Mickey's minimal dataset and use it to run the minimal code.
Now, was that *really* easier than creating a dataset from scratch?

Some of you may still be thinking that you could just use `dput()` on the original dataset.
And it would work.
But that wouldn't be very considerate to those who are trying to help.

::: challenge
### Exercise 7: Try it! (1 min)

Try running `dput(surveys)` in your script.
:::

It becomes a huge chunk of code!
When clearly we don't need all of that.

Remember, we want to keep everything minimal for many reasons:

-   to make it easy for our helpers to understand our data and code
-   to allow helpers to quickly focus their efforts on the right factors
-   to make the problem-solving process as easy and painless as possible
-   bonus: to help *us* better understand and zero-in on the source of our problem, often stumbling upon a solution along the way

Nevertheless, it remains an option for when your data appears too complex or you are not quite sure where your problem lies and therefore are not sure what minimal components are needed to reproduce the example.
In other words, when you don't have a good mental model of what the problem is even after going through the initial steps we outlined earlier in the lesson.

## 4.7 Using an R-built dataset

The last approach we mentioned is to build a minimal reproducible dataset based on the datasets that already exist within R (and therefore everyone would have access to).

A list of readily available datasets can be found using `library(help="datasets")`.
You can then use `?` in front of the dataset name to get more information about the contents of the dataset.

For a more detailed discussion of the benefits of using this approach see the Pros and Cons callout in section 4.3.

This approach essentially blends the skills you already learned in the first two.
You need to identify a dataset with appropriate variables that match the "key elements" of the original dataset.
You then need to further reduce that dataset to a minimal, relevant, number or rows.
Once again, you can use the previously learned functions such as `select()`, `filter()`, or `sample()`.

Since you already learned everything you need, why not try it yourself?

:::: challenge
### Exercise 8: Extra Challenge (10 mins)

Using the "HairEyeColor" dataset, create a minimal reproducible dataset for the same issue and minimal code we have been exploring.

1.  Start by using `?HairEyeColor` to read a description of the dataset and `View(HairEyeColor)` to see the actual dataset.

2.  Which variables would be a good match for our situation?
    What are our requirements?

3.  How can we subset this dataset to make it minimal and still replicate our issue?

::: solution
Remember, there are many possible solutions!
The most important feature is that the example dataset can replicate the issue when used within our minimal code.

The following is 1 possible solution:

We selected Hair and Eye as replacements for species and sex because they are both categorical and have at least 3 levels.
We don't strictly need anything else.
We will call our new `survyes` replacement `hyc`.
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
### *What about NAs?*

If your data has NAs and they may be causing the problem, it is important to include them in your example dataset.
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

Great work!
You created a minimal reproducible example.
In the next episode, you will learn about `{reprex}`, a package that can help you double-check that your example is properly reproducible by running it in a clean environment.
(As an added bonus, `{reprex}` will format your example nicely so it's easy to post to places like Slack, GitHub, and StackOverflow.)

::: keypoints
-   A minimal reproducible dataset (a) contains the minimum number of lines, variables, and categories, in the correct format, to replicate your problem; and (b) must be fully reproducible, meaning that someone else can run the same code from anywhere without additional steps.
-   To make it accessible, you can create a dataset from scratch using `as.data.frame`, you can use an R-built dataset like `cars`, or you can use a subset of your own dataset and then use `dput()` to generate reproducible code.
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

At the end of the episode, here is our final reprex. In the next episode, we will learn how to test whether this reprex is fully reproducible, and also how to share it with others.


``` r
# Mickey's reprex (1 approach) 

# Required packages to run the code
library(readr)
library(dplyr)

set.seed(1) # ensures accurate data replication

# Create a mock dataset
sample_data <- data.frame(
  record_id = 1:10,
  sex = sample(c('M','F', NA), 10, replace=T)
)

# The problematic code snippet
sample_subset <- sample_data %>% # replace rodents with our sample dataset
  filter(sex == c("F", "M")) # this can stay the same because we recreated it the same

# Subsetted sample dataset - how many individuals for each sex?
table(sample_subset$sex)
```

``` output

F 
1 
```
