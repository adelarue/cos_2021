# Data Wrangling and Visualization with R

In this session, we will introduce the R programming language, the RStudio IDE, and basic techniques in data wrangling using R and RStudio.  Specifically, we will cover some basic tools using out-of-the-box R commands, then introduce the powerful framework of the "tidyverse", and finally gain some understanding of the philosophy of this framework to set up deeper exploration of our data.  Throughout, we will be using a publicly available dataset of AirBnB listings.  


## Pre-assignment 1: Keeping current

To ensure that you have the most current versions of all files, please fire up a terminal, navigate to the directory into which you cloned the full set of materials for the course, and run `git pull`.  (Refer back to Session 1 if you're having trouble here.)

Before class, it is recommended to skim through the [online session notes].

We recommend you follow along in class using the `S2_script.R` file, which will allow you to live-code along with the session leader and work through un-solved exercises. 

## Pre-assignment 2: Download `R` and RStudio

We will be learning the `R` programming language for statistical computation. To interact with `R`, we will use RStudio, the most popular and widely used R IDE, to write and execute `R` commands. 

* **Install `R` and RStudio**: Navigate to https://rstudio.com/products/rstudio/download/#download and follow instructions 1 and 2.  
* In step 1, install R by selecting the 'R 3.0.1+' hyperlink and following the download R instructions for your operating system.  
* In step 2, install RStudio Desktop by clicking the the "Download RStudio" button.  
* **Test Your Installation**: Open RStudio and type 1+2 into the Console window, and type "Enter".
* Later in the class we will require the most recent version of R (>= 4.0.3). If you already had R installed on your computer, you may have an earlier version. To check and update the R version, you can follow the **Install `R`** instructions above.


## Pre-assignment 3: Installing libraries

We will use three libraries for this session: `tidyr`, `dplyr`, and `ggplot2`. These three packages (any many more!) can all be conveniently loaded using the metalibrary `tidyverse`. To unleash the power of the Tidyverse open RStudio and type the following into the console window and press "Enter": 

```
install.packages('tidyverse')
```

You should test that the libraries will load by then running in the console window:

```
library(tidyverse)
```

Then test that dplyr/tidyr work by executing the command:
```
data.frame(name=c('Ann', 'Bob'), number=c(3.141, 2.718)) %>% gather(type, favorite, -name)
```
which should output something like this
```
      name   type favorite
    1  Ann number    3.141
    2  Bob number    2.718
```

Finally, test that ggplot works by executing the command
```
data.frame(x=rnorm(1000), y=rnorm(1000)) %>% ggplot(aes(x,y)) + geom_point()
```
which should produce a cloud of points centered around the origin.

**Please submit screenshot of these two outputs to the Pre-Assignment 2 Page on the course Canvas page.**


## Additional Resources

`dplyr` and `tidyr` are well-established packages within the `R` community, and there are many resources to use for reference and further learning. Some of our favorites are below (these links may be outdated but with a quick internet search, you should be able to find the correct webpage as these are all very popular resources). 

- Tutorials by Hadley Wickham for `dplyr` [basics](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html), [advanced grouped operations](https://cran.r-project.org/web/packages/dplyr/vignettes/window-functions.html), and [database interface](https://cran.r-project.org/web/packages/dplyr/vignettes/databases.html).
- Third-party [tutorial](http://www.dataschool.io/dplyr-tutorial-for-faster-data-manipulation-in-r/) (including docs and a video) for using `dplyr`
- [Principles](http://vita.had.co.nz/papers/tidy-data.pdf) and [practice](https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html) of tidy data using `tidyr`
- (Detailed) [cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf?version=0.99.687&mode=desktop) for `dplyr` and `tidyr` 
- A useful [cheatsheet](https://stat545-ubc.github.io/bit001_dplyr-cheatsheet.html) for `dplyr` joins
- [Comparative discussion](http://stackoverflow.com/questions/21435339/data-table-vs-dplyr-can-one-do-something-well-the-other-cant-or-does-poorly) of `dplyr` and `data.table`, an alternative package with higher performance but more challenging syntax.  

Some of the infinitude of visualization subjects we did not cover are: heatmaps and 2D histograms, statistical functions, plot insets, ...  And even within the Tidyverse, don't feel you need to limit yourself to `ggplot`.  Here's a good overview of some [2d histogram techniques](http://www.everydayanalytics.ca/2014/09/5-ways-to-do-2d-histograms-in-r.html), a discussion on [overlaying a normal curve over a histogram](http://stackoverflow.com/questions/5688082/ggplot2-overlay-histogram-with-density-curve), a workaround to fit multiple plots in [one giant chart](http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/). 

For other datasets and applications, one place to start is data hosting and competition websites like [Kaggle](http://www.kaggle.com), and there many areas like [sports analytics](http://www.footballoutsiders.com), [political forecasting](http://www.electoral-vote.com/evp2016/Info/data.html), [historical analysis](https://t.co/3WCaDxGnJR), and countless others that have [clean](http://http://www.pro-football-reference.com/), [open](http://www.kdnuggets.com/datasets/index.html), and [interesting](https://www.kaggle.com/kaggle/hillary-clinton-emails) data just waiting for you to `read.csv`. 


