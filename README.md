# Packages Loaded
1.  libarayr(plyr)
2.  library(dplyr)
3.  library(data.table)

# Files Loaded

1.  x_test <- read.table("test/x_test.txt")
2.  y_test <- read.table("test/y_test.txt")
3.  subject_test <- read.table("test/subject_test.txt")
4.  x_train <- read.table("train/x_train.txt")
5.  y_train <- read.table("train/y_train.txt")
6.  subject_train <- read.table("train/subject_train.txt")
7.  activity_labels <- read.table("activity_labels.txt")
8.  features <- read.table("features.txt")

# Final Output File Name

1.  SamsungData.txt


# Steps Taken to Create Output

*below is a list of hilights of what the run_analysis.R function does*

1.  Loads neccessary packages needed for the run_analysis function to work.
2.  Load all neccessary data files needed.
3.  Merges x_test and x_train data into one dataframe
4.  Adds variable names to each column of the data.
5.  Extracts just those columns that have "std" or "mean" in their name
6.  Adds new column which give activityid to each row of data.
7.  Adds new column which gives subject to each row of data
8.  Adds new column which joins with activityid to get a text description of activity.
9.  Removes all bad characters from column names which do not fit tidy data definition.
10. Extacts mean of each column grouped by activity and subject into new data frame.
11. Creates a text file with data as required by project.
