using CSV, DataFrames
using ScikitLearn
using Random, Statistics
using JLD2

# Import the necessary modules and libraries from ScikitLearn
@sk_import ensemble:RandomForestClassifier

# Import our training function which trains a random forest
include("rf.jl")

# Load the data for training and validation
train = CSV.read("data/listings_clean_train.csv", header=false)
val = CSV.read("data/listings_clean_val.csv", header=false)

# Load the parameters dataframe
@load "params.jld2" params

# Get the experiment ID from the arguments that were passed to julia

# Set a random seed - always a good idea when using functions you didn't write
Random.seed!(1776)

# Actually run the experiment


