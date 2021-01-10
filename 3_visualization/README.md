# Visualization with R and Shiny

In this session we will focus on visualization, first learning how to use
`ggplot` to create beautiful plots, and then `shiny` to incorporate our
analyses in an interactive web application -- all through RStudio! On the 
way, we'll pick up some more cool tricks for data wrangling with the 
`tidyverse`.

## Pre-Assignment


### 0. Install libraries

Make sure you have installed packages `tidyverse`, `shiny`, `leaflet`, `DT`. 
You can install them using: 

```
install.packages(c("tidyverse", "shiny", "leaflet", "DT"))
```
*You might be warned that some packages will have to be installed from 
binaries. Do it.*

Make sure you can load the libraries without an error in RStudio:

```
library(shiny)
library(DT)
library(tidyverse)
library(leaflet)
```

### 1. Make your first Shiny app

Follow these instructions to create a simple interactive web app, all through RStudio: 

1. In RStudio, click on `File -> New File -> Shiny Web App`. 
2. Name your application something (e.g. `dummy_app`), select `Single File` and the directory you want the app to live in. 
3. Hit `Create`. This should make a `dummy_app` folder in the directory, containing a single `app.R` file.
4. If it hasn't opened automatically, find it and open it in RStudio.
5. Above the open script, on the right side, click `Run App` (there a "Play"-like green triangle next to it).

Voila! You now have your first Shiny app. 

If you don't understand the code, don't worry. We'll dive right into this dark magic during the session.

### 2. Upload a screenshot to Canvas

1. Change the `Number of bins` slider to 10, and take a screenshot the histogram plot.
2. Upload the image to the Session 3 assignment on Canvas.
3. Go ahead and delete the `dummy_app` directory, we won't need it. 