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
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Reading features vector and activity labels
features <- read.table("./UCI HAR Dataset/features.txt")
a_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Merging train and test datasets to create one dataset
x_data <- rbind(x_test,x_train)
y_data <- rbind(y_test,y_train)
subject_data <- rbind(subject_test,subject_train)

initial_data <- cbind(subject_data, y_data, x_data)
# THIS COMPLETES STEP 1 OF THE ASSIGNMENT

# Selecting only columns with "mean" or "std" in their names
mu_sigma <- grep("-(mean|std)\\(\\)", features[, 2])

x_data <- x_data[, mu_sigma]
names(x_data) <- features[mu_sigma, 2]

# Using descriptive activity names to name the activities in the data set
y_data[, 1] <- a_labels[y_data[, 1], 2]
names(y_data) <- "activity"

# Appropriately labeling the data set with descriptive variable names
names(subject_data) <- "subject"

# Binding all the data in a single data set
all_data <- cbind(subject_data, y_data, x_data)

# THIS COMPLETES STEPS 2, 3, & 4 OF THE ASSIGNMENT

# Creating a second, independent, tidy data set with the average of each 
# variable for each activity and each subject 

#Loading relevant packages
library(data.table)
library(dplyr)
library(tidyr)
library(stringr)

# Adding the subject averages as the last column
all_data <- mutate(all_data, subject_avg=rowMeans(all_data[, 3:68]))

# Adding the activiyy averages as the last row
activity_avg <- colMeans(all_data[, 3:69])
activity_avg <- as.data.frame(activity_avg)
activity_avg <- transpose(activity_avg)

extra <- transpose(as.data.frame(c("activity_avg", "ALL")))
activity_avg <- cbind(extra, activity_avg)

names(activity_avg) = names(all_data)
all_data <- rbind(all_data, activity_avg)

# Removing the "()" and "-" from the column names
names <- names(all_data)
names <- str_replace(names, "\\(.*\\)", "")
names <- str_replace(names, "\\-", "_")
names <- str_replace(names, "\\-", "_")
names(all_data) <- names

# Using gather to create a tidy data set
final_data <- gather(all_data, feature, observation, tBodyAcc_mean_X:subject_avg)

write.table(final_data, "final_data.txt", row.names = FALSE)

# THIS COMPLETES STEP 5 OF THE ASSIGNMENT

# Cleaning up the environment
rm(list = ls())

