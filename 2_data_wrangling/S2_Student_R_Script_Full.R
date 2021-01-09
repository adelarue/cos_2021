# This R script is provided so that students attending COS2021 Session
# 2 can follow along with the instructor



## R as a calculator

1 / 200 * 30
(59 + 73 + 2) / 3
sin(pi / 2)

#-------------------------------------------------------------------------------

## Simple variable assignment
three_times_four <- 3 * 4

#-------------------------------------------------------------------------------

## Capitalization matters!
MIT_Cheer <- "Go Engineers"

# The following commands will produce an error.
mit_cheer
MIT_cheer

#-------------------------------------------------------------------------------

## Even scalars are vectors in R

# the following line of code returns TRUE even though three_times_four is 
# length 1.

is.vector(three_times_four)

#-------------------------------------------------------------------------------

## Creating vectors

vector_A <- c(1,2,3)
vector_B <- c(2,4,6)

#-------------------------------------------------------------------------------

## Vectorized Functions
# In other programming languages, one would need to initialize an empty vector
# and then populate that vector element by element as follows:

B_divided_by_A <- c()   # This is an empty vector

for(i in 1:length(vector_A)){
  B_divided_by_A[i] <- vector_B[i]/vector_A[i]
}

# In R, all we need to type is:
vector_B/vector_A

# The output of the two methods are the same!
B_divided_by_A == (vector_B/vector_A)

#-------------------------------------------------------------------------------

## What happens when you have vectors of different lengths?

c(1,1) + c(4,4,4,4)

#-------------------------------------------------------------------------------

## Indexing a dataframe

names(cars) #the cars dataframe has two columns: "speed" and "distance"
cars$speed #view the speed column

#-------------------------------------------------------------------------------

## Indexing elements of a vector

cars$speed[1:5]

#-------------------------------------------------------------------------------

## Directly indexing elements of a dataframe

cars[1:10, 1]

#-------------------------------------------------------------------------------

## R help pages

?summary()

#-------------------------------------------------------------------------------

## Check working directory

getwd()

#-------------------------------------------------------------------------------

## Clear the workspace

rm(list = ls())

#-------------------------------------------------------------------------------

## Load the library

library(tidyverse)

#-------------------------------------------------------------------------------

## Import the data

raw_listings <- read_csv('../data/listings.csv')

#-------------------------------------------------------------------------------

## View the data's structure

str(raw_listings)

#-------------------------------------------------------------------------------

## View a summary of the data

summary(raw_listings)  

#-------------------------------------------------------------------------------

## View the column names

colnames(raw_listings)  

#-------------------------------------------------------------------------------

## Tabulate the "room_type" column

table(raw_listings$room_type)	  

#-------------------------------------------------------------------------------

## Learning about data types.

# Does something look strange here?
summary(raw_listings$price)

# You probably would have noticed something was not right when you went
# to execute an operation such as:
sum(raw_listings$price)               # This produces an error

#-------------------------------------------------------------------------------

## User-Defined functions

# We define a new function, "clean_price" which will remove unnecessary 
# punctuation from the provided column
clean_price <- function(price) as.numeric(gsub('\\$|,', '', price))

#-------------------------------------------------------------------------------

## Motivation for the Tidyverse

# View the first 10 elements of two columns
raw_listings[1:10, colnames(raw_listings) %in% c("neighbourhood","price")] 


# Tabularize a column based on a conditional argument
table(raw_listings$room_type, raw_listings$accommodates >= 4)	 

#-------------------------------------------------------------------------------

## A much faster and easier way to view the first 10 elements of two columns
## courtesy of the tidyverse
raw_listings %>%
  select(neighbourhood, price) %>%
  head(10)


## A much faster and easier was to tabularize a column with a conditional 
## argument
raw_listings %>%
  filter(accommodates >= 4) %>%
  select(room_type) %>%
  table()

#-------------------------------------------------------------------------------

## Using the mutate function

raw_listings %>%
  mutate(nprice = clean_price(price)) %>%
  select(name, price, nprice) %>% 
  head()

#-------------------------------------------------------------------------------

## Using the arrange function

raw_listings %>%
  mutate(nprice = clean_price(price)) %>%
  select(name, price, nprice) %>%
  arrange(nprice) %>%
  head()

#-------------------------------------------------------------------------------

## Using the arrange function but sorting from high to low

raw_listings %>%
  mutate(nprice = clean_price(price)) %>%
  select(name, price, nprice) %>%
  arrange(desc(nprice)) %>%
  head()

#-------------------------------------------------------------------------------

## Using the is.na function

raw_listings %>% 
  select(bathrooms) %>%
  is.na() %>%
  sum()

#-------------------------------------------------------------------------------

## Combine the filter function and the is.na function to remove NAs

raw_listings %>% 
  filter(!is.na(bathrooms))

#-------------------------------------------------------------------------------

## Create a new dataframe after doing some tidy-ing

listings <- raw_listings %>%
  filter(!is.na(bedrooms), 
         !is.na(bathrooms)) %>%
  mutate(nprice = clean_price(price),
         weekly_price = clean_price(weekly_price),
         monthly_price = clean_price(monthly_price))

#-------------------------------------------------------------------------------

## Practice with the summarize function

listings %>% 
  summarise(avg.price = mean(nprice))

#-------------------------------------------------------------------------------

## Practice doing a group_by summary

listings %>%
  group_by(neighbourhood_cleansed) %>%
  summarize(avg.price = mean(nprice))

#-------------------------------------------------------------------------------

##### EXERCISE

## Summarizing with multiple functions

listings %>%
  group_by(neighbourhood_cleansed) %>%
  summarize(avg.price = mean(nprice),
            med.price = median(nprice),
            num = n())

#-------------------------------------------------------------------------------

## Including a filter after a summarize function

listings %>%
  group_by(neighbourhood_cleansed) %>%
  summarize(avg.price = mean(nprice),
            med.price = median(nprice),
            num = n()) %>%
  filter(num > 200)

#-------------------------------------------------------------------------------

## Filtering by group membership

listings %>%
  filter(neighbourhood_cleansed %in% c('Downtown', 
                                       'Back Bay', 
                                       'Chinatown')) %>%
  group_by(neighbourhood_cleansed) %>%
  summarize(avg.price = mean(nprice),
            med.price = median(nprice),
            num = n()) %>%
  arrange(med.price)


#-------------------------------------------------------------------------------

## Practice with pivot_longer

long_price <- listings %>%
  select(id, name, nprice, weekly_price, monthly_price) %>%
  pivot_longer(cols = c("nprice", "weekly_price", "monthly_price"), 
               names_to = "price_type",
               values_to = "price_value") %>%
  filter(!is.na(price_value))

long_price %>% head()  # take a peek

#-------------------------------------------------------------------------------

##### EXERCISE

## Practice using pivot_wider

pivot_wider(long_price,
            names_from = price_type,
            values_from = price_value) %>%
  head()

#-------------------------------------------------------------------------------

## Create two tables to practice joins

table1 = data.frame(name=c('Paul', 'John', 'George', 'Ringo'),
                    instrument=c('Bass', 'Guitar', 'Guitar', 'Drums'),
                    stringsAsFactors=F)


table2 = data.frame(name=c('John', 'George', 'Jimi', 'Ringo', 'Sting'),
                    member=c('yes', 'yes', 'no', 'yes', 'no'),
                    stringsAsFactors=F)

#-------------------------------------------------------------------------------

## Practice a full join

full_join(table1, table2, by='name')

#-------------------------------------------------------------------------------

## Practice a left join

left_join(table1, table2, by='name')

#-------------------------------------------------------------------------------

## Practice an inner join

inner_join(table1, table2, by='name')

#-------------------------------------------------------------------------------

## Create two separate dataframe to practice joining

rooms <- listings %>%
  select(name, bathrooms, bedrooms) %>%
  pivot_longer(cols = c("bathrooms","bedrooms"), 
               names_to = "room_type",
               values_to = "number")

prices <- listings %>%
  select(name, nprice) %>%
  mutate(price = as.numeric(gsub('\\$|,', '', nprice)))

rooms_prices <- full_join(rooms, prices, by='name')

#-------------------------------------------------------------------------------

## Build a plot to demonstrate why joining can be useful.

rooms_prices %>%
  filter(!is.na(number), number %% 1 == 0) %>%
  mutate(number = as.factor(number)) %>%
  ggplot(aes(x = number, 
             y = price, 
             fill = room_type)) +
  geom_boxplot() +
  facet_grid(~room_type) +
  labs(x = '# of Rooms', 
       y = 'Daily price', 
       fill = 'Room type')

