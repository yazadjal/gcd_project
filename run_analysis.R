# Downloading the zipfile from the web and saving it in the working directory

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- paste0(getwd(),"/","gcd_assignment.zip")
download.file(fileurl, destfile, method = "curl", quiet = TRUE)

# Unziping the downloaded file 
# (no need to specify exdir, as it will create its own dir) 

unzip("gcd_assignment.zip")

# Reading test and training variables
# (as we have unzipped the directory in the working directory, 
# "./UCI HAR Dataset/..." is sufficient)
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
#REDACTED

# Reading features vector and activity labels
#REDACTED

# Merging train and test datasets to create one dataset
#REDACTED

# THIS COMPLETES STEP 1 OF THE ASSIGNMENT

#REDACTED

# Using descriptive activity names to name the activities in the data set
#REDACTED

# Appropriately labeling the data set with descriptive variable names
names(subject_data) <- "subject"

# Binding all the data in a single data set
#REDACTED

# THIS COMPLETES STEPS 2, 3, & 4 OF THE ASSIGNMENT

# Creating a second, independent, tidy data set with the average of each 
# variable for each activity and each subject 

#Loading relevant packages
library(data.table)
library(dplyr)
library(tidyr)
library(stringr)

# Adding the subject averages as the last column
#REDACTED

# Adding the activiyy averages as the last row
#REDACTED

# Removing the "()" and "-" from the column names
#REDACTED

# Using gather to create a tidy data set
#REDACTED

# THIS COMPLETES STEP 5 OF THE ASSIGNMENT

# Cleaning up the environment
rm(list = ls())

