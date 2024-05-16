---
title: "Minimal Reproducible Data"
teaching: 40
exercises: 4
---

:::::::::::::::::::::::::::::::::::::: questions 

- What is a minimal reproducible dataset?
- What do I need to include in a minimal reproducible dataset?
- How do I create a minimal reproducible dataset?
- How do I share my data?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives

After completing this episode, participants should be able to...

- Describe a minimal reproducible dataset
- Identify the minimum objects required to reproduce your coding problem
- Create a data frame from scratch ("dummy data")
- List readily available datasets and how to access them
- Create a sample dataset from a subset of your data
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

A) Not reproducible.  
Do not use data from your computer unless you are attaching the data file. You can reproduce a subset of that data from scratch (dummy data). For example:
B) Minimal and reproducible!  
This dataset is already reproducible and needs no editing
C) Not reproducible.  
Add `library(dplyr)` or `dplyr::function()` 
D) Not minimal.  
Reduce the length of this dataset by...

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::: keypoints
 - A minimal reproducible dataset contains the minimum number of lines and variables to reproduce a certain problem and can be fully reproduced by someone else using only the information provided 
 - You can create a dataset from scratch using `as.data.frame`, you can use available datasets like `iris` or you can use a subset of your own dataset
 - You can share your data by...
::::::
