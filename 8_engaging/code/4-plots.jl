# Load the packages we need
using JLD2, Plots, DataFrames

# Load the parameters data frame
@load "params.jld2" params

# Create empty arrays that will hold the R2 values
R2_train = []
R2_val = []

# Let's load all the results we want, and put them into the arrays
for i = 1:nrow(params)
	# load the results of experiments i

end

# Add the R2 values to the dataframe


# Subset the dataframe to only some of the results


# Make the plot


Plots.savefig("plot.pdf")
