---
title: Setup
---
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: instructor

Setup instructions live in this document. Please specify the tools and the data sets the learner needs to have installed. If you want to hide different setup instructions, you can use a `solution` tag.

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

### Install R and RStudio

R and RStudio are two separate pieces of software: 

* **R** is a programming language and software used to run code written in R.
* **RStudio** is an integrated development environment (IDE) that makes using R easier. In this course we use RStudio to interact with R. 
  
If you don't already have R and RStudio installed, follow the instructions for your operating system below. You have to install R before you install RStudio. 

<br>

:::::::::::::::: solution

## For Windows

* Download R from the [CRAN website](https://cran.r-project.org/bin/windows/base/release.htm).
* Run the `.exe` file that was just downloaded
* Go to the [RStudio download page](https://www.rstudio.com/products/rstudio/download/#download)
* Under *Installers* select **Windows Vista 10/11 - RSTUDIO-xxxx.yy.z-zzz.exe** (where x = year, y = month, and z represent version numbers)
* Double click the file to install it
* Once it's installed, open RStudio to make sure it works and you don't get any error messages.
  
:::::::::::::::::::::::::

:::::::::::::::: solution

## For MacOS

* Download R from the [CRAN website](https://cran.r-project.org/bin/macosx/).
* Select the `.pkg` file for the latest R version
* Double click on the downloaded file to install R
* It is also a good idea to install [XQuartz](https://www.xquartz.org/) (needed by some packages)
* Go to the [RStudio download page](https://www.rstudio.com/products/rstudio/download/#download)
* Under *Installers* select **Mac OS 13+ - RSTUDIO-xxxx.yy.z-zzz.dmg** (where x = year, y = month, and z represent version numbers)
* Double click the file to install RStudio
* Once it's installed, open RStudio to make sure it works and you don't get any error messages.

:::::::::::::::::::::::::

:::::::::::::::: solution

## For Linux 

* Click on your distribution in the [Linux folder of the CRAN website](https://cran.r-project.org/bin/linux/). Linux Mint users should follow instructions for Ubuntu.
* Go through the instructions for your distribution to install R.
* Go to the [RStudio download page](https://www.rstudio.com/products/rstudio/download/#download)
* Select the relevant installer for your Linux system (Ubuntu/Debian or Fedora)
* Double click the file to install RStudio
* Once it's installed, open RStudio to make sure it works and you don't get any error messages.

:::::::::::::::::::::::::

### Update R and RStudio

If you already have R and RStudio installed, first check if your R version is up to date:

* When you open RStudio your R version will be printed in the console on the bottom left. Alternatively, you can type `sessionInfo()` into the console. If your R version is 4.0.0 or later, you don't need to update R for this lesson. If your version of R is older than that, download and install the latest version of R from the R project website [for Windows](https://cran.r-project.org/bin/windows/base/), [for MacOS](https://cran.r-project.org/bin/macosx/), or [for Linux](https://cran.r-project.org/bin/linux/)
* It is not necessary to remove old versions of R from your system, but if you wish to do so you can check [How do I uninstall R?](https://cran.r-project.org/bin/windows/base/rw-FAQ.html#How-do-I-UNinstall-R_003f) 
* After installing a new version of R, you will have to reinstall all your packages with the new version. For Windows, there is a package called `installr` that can help you with upgrading your R version and migrate your package library. A similar package called `pacman` can help with updating R packages across
To update RStudio to the latest version, open RStudio and click on 
`Help > Check for Updates`. If a new version is available follow the 
instruction on screen. By default, RStudio will also automatically notify you 
of new versions every once in a while.

::::::::::::::::::::::::::::: callout

### R versions

The changes introduced by new R versions are usually backwards-compatible. That is, your old code should still work after updating your R version. However, if breaking changes happen, it is useful to know that you can have multiple versions of R installed in parallel and that you can switch between them in RStudio by going to `Tools > Global Options > General > Basic`.

While this may sound scary, it is **far more common** to run into issues due to using out-of-date versions of R or R packages. Keeping up with the latest versions of R, RStudio, and any packages you regularly use is a good practice.

:::::::::::::::::::::::::::::

### Install required R packages

During the course we will need a number of R packages. Packages contain useful R code written by other people. We will use the packages `tidyverse` and `reprex`. (The `tidyverse` is a suite of packages, including `ggplot2` and `dplyr`, which we will use in our code.)

To try to install these packages, open RStudio and copy and paste the following command into the console window (look for a blinking cursor on the bottom left), then press the <kbd>Enter</kbd> (Windows and Linux) or <kbd>Return</kbd> (MacOS) to execute the command.

```r
install.packages(c("tidyverse", "reprex"))
```

Alternatively, you can install the packages using RStudio's graphical user interface by going to `Tools > Install Packages` and typing the names of the packages separated by a comma.

R tries to download and install the packages on your machine. 

When the installation has finished, you can try to load the packages by pasting the following code into the console:

```r
library(tidyverse)
library(reprex)
```

If you do not see an error like `there is no package called ‘...’` you are good to go! 

### Updating R packages

Generally, it is recommended to keep your R version and all packages up to date, because new versions bring improvements and important bugfixes. To update the packages that you have installed, click `Update` in the `Packages` tab in the bottom right panel of RStudio, or go to `Tools > Check for Package Updates...` 

You should update **all of the packages** required for the lesson, even if you installed them relatively recently.

Sometimes, package updates introduce changes that break your old code, which can be very frustrating. To avoid this problem, you can use a package called `renv`. It locks the package versions you have used for a given project and makes it straightforward to reinstall those exact package version in a new environment, for example after updating your R version or on another computer. However, the details are outside of the scope of this lesson.

### Creating and opening an RStudio project

We will be using the "project" feature of RStudio to keep our code and data contained for this lesson. To create a new project in RStudio, choose File > New Project from the top menu. Then you can choose to create the project in a new or existing folder. Name your project something distinctive that you will recognize (for example, "2025-08-15_reprexes_workshop"). Then, create a "data/" folder inside your project folder.

Switch over to the project from inside of RStudio by clicking on the blue cube icon at the upper righthand corner of the RStudio window and choosing "Open Project". Alternatively, you can navigate to your project folder in Finder (on Mac) or File Explorer (on Windows) and double-click the file with the ".Rproj" extension to open up a fresh session of RStudio for your project.

For more information and guidance on RStudio projects, see the [Posit support page](https://support.posit.co/hc/en-us/articles/200526207-Using-RStudio-Projects).

### Download dataset

For this lesson, we will be using a dataset called `surveys_complete_77_89.csv`, which contains rodent survey data from the [Portal Project]("https://portal.weecology.org/")

Please download the [cleaned data](../episodes/data/surveys_complete_77_89.csv) and put it into the `data/` folder of your RStudio project.
 
### Download analysis script

For episode 3 of this lesson, we will be examining a pre-created [analysis script](../scripts/mickey_analysis.rtf). So that everyone is on the same page, please download the text file "[mickey_analysis.R](../scripts/mickey_analysis.rtf)" and copy it into a new script in the main folder of your RStudio project.
