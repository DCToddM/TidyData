Need to load plyr packate
1.  libarayr(plyr)

Read test and train data in using following 4 lines of code.

1.  x_test <- read.table("test/x_test.txt")
2.  y_test <- read.table("test/y_test.txt")
3.  subject_test <- read.table("test/subject_test.txt")
4.  x_train <- read.table("train/x_train.txt")
5.  y_train <- read.table("train/y_train.txt")
6.  subject_train <- read.table("train/subject_train.txt")

Read features and activity_labels files in using the following lines of code.

1.  activity_labels <- read.table("activity_labels.txt")
2.  features <- read.table("features.txt")

features.txt holds a text value for each column in train and test sets.  These are the column headers for each column in the test and training data.

activity_labels.txt holds the different activities performed.

subject.train.txt and subject.test.txt identifies the subject who performed the activity.  It ranges from 1 - 30.

y_test and y_train hold the activity performed for each row in x_test and x_train respectively.

used mergedData = merge(x_test, x_train, all=TRUE) to merge data into one dataset.  When creating script will need to pass in both dataset names.

need to apply features dataset to mergedData dataset so we can extract columns that have "mean" or "std" in their column title.

used this command to add column labels.
column_labels <- t(features)  # this will transpost the features data.
names(mergedData) <- c(column_labels[2, 2:561]) this appled the dataset column_labels to the mergedData dataset to set the names of the columns.

used this line to extract any column with "mean" or "std" in its column name as required by the project requirement.
newdata <- mergedData[, grepl("mean|std", names(mergedData))]

used this command to combine the y_test and y_train data into one data set so that we can later add the column to the merged x_test and x_train dataset.
activityID <- rbind(y_test, y_train)

used this command to add the activityID to the merged newData frame.
newdata$activity <- c(activityID[,1])
Since it placed the "activityID" as the last column and I wanted it to be first I used this command to move the activityID as the first column.
newdata <- newdata[, c(ncol(newdata), 1:(ncol(newdata)-1))]

used this command to combine the subject_test and subject_train data into one dataframe called subjectID.
subjectID <- rbind(subject_test, subject_train)

used this command to add the subjectID column to the newdata dataframe and put the column fromt the subjectID dataframe into the newdata dataframe.
newdata$subject <- c(subjectID[,1])
used this command to moe the subjectID column to be first in the newdata dataframe
newdata <- newdata[, c(ncol(newdata), 1:(ncol(newdata)-1))]

Renamed column in activity_labels.txt column V1 to activity using the following command
activity_labels <- rename(activity_labels, activityid = V1)

**** At this point I made a newdata_bkp data frame which allowed me to play with getting the activity labels joined with the activityid so I can get the descriptive name of the activity.

Made sure to name the subject_train and subject_test imported and column named changed or set to activityid so we could join on that later to get the text descrition of each activiy.  If needed can used this command to change the subjet data colum to activityid:
newdata_bkp <- rename(newdata_bkp, activityid = activity)

After columns in both activty_labels and newdata_bkp are renamed proplery can get the text descritpion of activity performed using this command
newdata_bkp <- inner_join(activity_labels, newdata_bkp, by="activityid")

used this code to remove any of the '-' symbols from the columns names
names(newdata_bkp) <- gsub("-","", names(newdata_bkp))

used this code to remove any of the '()' symbols from the columnnames
names(newdata) <- gsub("\\(", "", names(newdata))
names(newdata) <- gsub("\\)", "", names(newdata))

Used this code to get the final dataset required for the project
newdata_means <- ddply(newdata, c("activity", "subject"), function(x) colMeans(subset(newdata, select = c(4:81))))

This is the code used to write the results to the text file
write.table(newdata_means, "SamsungData.txt", sep="\t")