run_analysis <- function(){
     #Load needed libraries
     library(plyr)
     library(dplyr)
     library(data.table)
     
     #read in the 8 text files we need to work with
     x_test <- read.table("x_test.txt")
     y_test <- read.table("y_test.txt")
     subject_test <- read.table("subject_test.txt")
     x_train <- read.table("x_train.txt")
     y_train <- read.table("y_train.txt")
     subject_train <- read.table("subject_train.txt")
     activity_labels <- read.table("activity_labels.txt")
     features <- read.table("features.txt")
     
     #merge the x_train and x_test files into one big data fram
     mergedData = merge(x_test, x_train, all=TRUE)
     
     #transpose the features dataframe so we can label our columns in our merged 
     #data
     column_labels <- t(features)
     
     #here we apply the names for our column_labels dataset to our large dataset
     names(mergedData) <- c(column_labels[2, 2:561])
     
     #create smaller dataset from large dataset pulling only those colums with 
     #"mean" and "std" in their variable names
     newdata <- mergedData[, grepl("mean|std", names(mergedData))]
     
     #combine the y_test and y_train files which hold the activity completed
     activityID <- rbind(y_test, y_train)
     
     #add the combined y file as a column to the large data frame so we no what 
     #activity was performed for each row of data.
     newdata$activity <- c(activityID[,1])
     
     #since above command adds column to back let's move it to the front.
     newdata <- newdata[, c(ncol(newdata), 1:(ncol(newdata)-1))]
     
     #combine subject_test and subject_train files to create one data frame
     subjectID <- rbind(subject_test, subject_train)
     
     #add new column to newdata data frame so we can know what subject performed
     #what task for each row of data
     newdata$subject <- c(subjectID[,1])
     #since above command adds column to back let's move it to the front.
     newdata <- newdata[, c(ncol(newdata), 1:(ncol(newdata)-1))]
     
     #we need a common key to join activity_labels data fram and newdata data
     #frame.  Rename V1 column in activity_lables to activityid
     activity_labels <- rename(activity_labels, activityid = V1)
     
     #rename activity column in newdata data fram to activityid
     newdata <- rename(newdata, activityid = activity)
     
     #add a new column to newdata frame which hold the text description of what
     #activity was performed for each row of data
     newdata <- inner_join(activity_labels, newdata, by="activityid")
     
     #when we added the new activity column it give the column name of "V2" \
     # which we change to activity with this command.
     newdata <- rename(newdata, activity = V2)
     
     #lets get rid of all the characters which do not make a a good tidy data
     #variable name
     names(newdata) <- gsub("-","", names(newdata))
     names(newdata) <- gsub("\\(", "", names(newdata))
     names(newdata) <- gsub("\\)", "", names(newdata))
     
     #We now creat the smaller data frame required for the project.  We are
     #getting the mean of each column grouped by activity and subject.
     newdata_means <- ddply(newdata, c("activity", "subject"), function(x) colMeans(subset(newdata, select = c(4:81))))
     
     #write the newdata_means to a text file to upload with project.
     write.table(newdata_means, "SamsungData.txt", sep="\t", row.name=FALSE)
     
}