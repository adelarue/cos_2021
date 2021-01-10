#' -------------------------------------------------------------------------
#' Visualization in R
#' By Ted Papalexopoulos and Dan Killian
#' Adapted from previous sessions by Phil Chodrow, Andy Zheng and more. 
#' 
#' Prior to running any code, you probably want to go to 
#' Session > Set Working Directory > To Source File Location
#' -------------------------------------------------------------------------


#' ----------------------------------------------
#' RECAP
#' ----------------------------------------------
#' Let's recall the main verbs of dplyr:
#'   `filter()` to select rows based on their values.
#'   `arrange()` to reorder rows.
#'   `select()` and `rename()` to select columns based on their names.
#'   `mutate()` to add new columns that are functions of existing columns
#'   `summarise()` to condense multiple values to a single value.
#' And the all important `group_by()` function (more on that in a second).

#' Let's load tidyverse and the AirBnB dataset, and clean the price 
#' like last time.  The `parse_number()` function also works here.
library(tidyverse)
raw_listings <- read_csv('../data/listings.csv')
listings = raw_listings %>% mutate(nprice = parse_number(price))


#' `filter()` only listings that are "Downtown", and rating is above 80
listings %>% 
    filter(neighbourhood_cleansed == "Downtown", 
           review_scores_rating > 80) %>% 
    select(id, neighbourhood_cleansed, review_scores_rating)


#` Sorts the rows by descending price
listings %>% 
    arrange(desc(nprice)) %>% 
    select(id, neighbourhood_cleansed, nprice)

#' Replaces NAs with 0 in the `review_score_rating`. Now `clean_rating` is
#' a new column appended at the end of the data frame.
listings %>%
    mutate(clean_rating = case_when(
        is.na(review_scores_rating) ~ 0, 
        TRUE ~ review_scores_rating)
    ) %>% 
    select(id, review_scores_rating, clean_rating)

#' Bonus verb: `count(...)` works like table, but always in *long* format.
listings %>% count(property_type, bedrooms)

#' ----------------------------------------------
#' GROUP_BY
#' ----------------------------------------------
#' The `group_by(...)` verb creates groups of observations. By itself, 
#' it doesn't change the data frame at all. All it does is adds a 
#' "groups" meta-attribute, that other verbs use in different ways.
#' 
#' We already saw last time how `group_by() %>% summarise()` aggregates
#' *within each group*.
listings %>% 
    group_by(neighbourhood_cleansed) %>% 
    summarise(n = n(), 
              mean_rating = mean(review_scores_rating, na.rm = T)) %>% 
    head

#' But it also changes how `mutate()` and `filter()` work!
#' The main difference is that anything they do will be done 
#' for each group *separately*. 

#' For example, let's use the `min_rank()` function. Try it on a vector:
min_rank(c(5, 10, 1)) # Gives (2, 3, 1)

#' So what if we wanted to add a column that lists ranking of each
#' listing within it's neighborhood by descending price.
listings %>%
    group_by(neighbourhood_cleansed) %>%
    mutate(neighbourhood_rank = min_rank(desc(nprice))) %>% 
    select(id, neighbourhood_cleansed, nprice, neighbourhood_rank)

#' Because of `group_by()`, `min_rank()` acts on each neighbourhood's
#' `nprice` column separately. 

#' `filter()` also works this way. Let's pick the 2nd highest-price
#' in each neighborhood. 
listings %>%
    group_by(neighbourhood_cleansed) %>%
    filter(min_rank(desc(nprice)) == 2) %>% 
    select(id, neighbourhood_cleansed, nprice)

#' Another use case: suppose we want to explore the price of listings
#' relative to their neighbourhood average. We could create a new data frame
#' with `summarise()` and join it back, or...
listings %>% 
    group_by(neighbourhood_cleansed) %>% 
    mutate(neighb_avg_price = mean(nprice, na.rm = T)) %>% 
    select(id, neighbourhood_cleansed, nprice, neighb_avg_price) %>% 
    tail

#' ----------------------------------------------
#' *GRAMMAR OF GRAPHICS*
#' ----------------------------------------------
#' Every ggplot contains of three elements: 
#'    *Data*: a dataframe
#'    *Aesthetics*: what we want to plot
#'    *Geometry*: how we want to plot it
#'    
#' Let's see it in action...
#' ----------------------------------------------

#' Summarise a bit for nicer plots.
by_bedroom_rating = listings %>% 
    filter(!is.na(review_scores_rating), !is.na(bedrooms)) %>% 
    group_by(bedrooms, review_scores_rating) %>% 
    summarise(med_price = median(nprice),
              num_listings = n())
by_bedroom_rating

#' We specify our *Data* (by_bedroom_rating), *Aesthetic mapping* 
#' (x and y to columns of the data) and *Geometry* (geom_point), 
#' and glue them together with `+`.
by_bedroom_rating %>% 
    ggplot(aes(x = review_scores_rating, y = med_price)) + 
    geom_point()

#' Clean, intuitive and pretty. But more importantly, *extensible*. 

#' *Adding aesthetics*: Suppose we want to see the points broken
#' out by color. We can change the aesthetic (note that `factor()`
#' tells R to treat the variable as categorical).
by_bedroom_rating %>% 
    ggplot(aes(x = review_scores_rating, y = med_price, 
               color = factor(bedrooms))) + 
    geom_point()

#' *Adding geoms*: We can also keep adding geoms to visualize the
#' same data in a different way. Here, we throw a linear best-fit
#' line for each bedroom class.
by_bedroom_rating %>% 
    ggplot(aes(x = review_scores_rating, y = med_price, 
               color = factor(bedrooms))) + 
    geom_point() + 
    geom_smooth(method = lm)

#' Note that the same aesthetics propagate through all geoms. You 
#' can override by additional mappings provided directly to the geoms. 
#' For example, if we move the `color` aesthetic to `geom_point()`, then
#' `geom_smooth()` will plot the overall best-fit line.
by_bedroom_rating %>% 
    ggplot(aes(x = review_scores_rating, y = med_price)) + 
    geom_point(aes(color = factor(bedrooms))) + 
    geom_smooth(method = lm, color = "black")

#' ----------------------------------------------
#' More geometries
#' ----------------------------------------------
#' Let's try bar plot for the median price by neighborhood.
by_neighbour = listings %>% 
    group_by(neighbourhood_cleansed) %>% 
    summarise(med_price = median(nprice))

by_neighbour %>%
    ggplot(aes(x = neighbourhood_cleansed, y = med_price)) +
    geom_bar(stat = 'identity') +
    theme(axis.text.x = element_text(angle=60, hjust=1)) 
#' We use stat="identity" to tell `geom_bar()` we want the height
#' of the bar to be the `y` value. If there were multiple `y`'s 
#' per `x` in the data, we could have specified an aggregation 
#' function like `mean`.
#' 
#' Notice also how we are separating thematic (non-content) adjustments 
#' like text rotation, from geometry and aesthetic mappings. 

#' Now let's follow through on this idea and clean up a bit: 
by_neighbour %>%
    ggplot(aes(x = reorder(neighbourhood_cleansed, desc(med_price)), 
               y = med_price)) +
    geom_bar(fill='dark blue', stat='identity') +
    theme(axis.text.x=element_text(angle=60, hjust=1)) +
    labs(x='', y='Median price', title='Median daily price by neighborhood')

#' The only new tool here is `reorder()`. which simply reorders the first
#' argument (neighbourhood) by the second (descending negative price).

#' ----------------------------------------------
#' Facetting
#' ----------------------------------------------
#' Want a couple of extra dimensions in your plot? Try facetting, i.e.
#' breaking out your plot into subplots by some variable(s) with 
#' `facet_wrap()`. Here, each value of `accommodates` will get it's 
#' own density plot (a smoothed histogram) over price:
listings %>%
    filter(!is.na(bedrooms)) %>% 
    ggplot(aes(x=nprice)) +
    geom_histogram(binwidth=50) + 
    xlim(0, 500) + 
    labs(x='Price', y='# of Listings') +
    facet_wrap(~bedrooms, scales = "free_y") 

#' Or a `facet_grid()` over two variables... We interpret the facet 
#' layout as an x~y axis, and use the formula `room_type~cancellation_policy`:
listings %>%
    ggplot(aes(x=nprice, fill=room_type)) +
    geom_density(alpha=0.5) + 
    xlim(0, 500) + 
    labs(x='Price', y='Frac. of Listings', fill='Room type') +
    facet_grid(room_type~cancellation_policy) 

