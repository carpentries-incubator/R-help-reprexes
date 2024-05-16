---
title: "Minimal Reproducible Data"
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- What is a minimal reproducible dataset?
- What do I need to include in a minimal reproducible dataset?
- How do I create a minimal reproducible dataset?
- How do I share my data?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

- Describe a minimal reproducible dataset
- List the requirements for a minimal reproducible dataset
- Identify the minimum objects required to reproduce your coding problem
- Create a data frame from scratch ("dummy data")
- List readily available datasets and how to access them
- Create a sample dataset from a subset of your data
- (optional) Evaluate when to use which type of dataset
- (optional) Include NAs or NULL values in your dataset
- List ways to share a sample dataset

::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::: challenge

### Exercise 1

Which of the following datasets are reproducible? Which ones need editing, why? Edit as necessary.

A) this dataset comes from an inaccessible directory
B) this dataset works great
C) this dataset uses dplyr but does not specify the package
D) this dataset is way too long (not minimal)

:::::::::::::: solution

### Solution

Here is just one example for how each dataset could be improved.

A) do not use data from your computer unless you are attaching the data file. You can reproduce a subset of that data from scratch (dummy data). For example:
B) This dataset is already reproducible and needs no editing
C) add `library(dplyr)` or `dplyr::function()` 
D) Reduce the length of this dataset by...

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::
