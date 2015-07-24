#DONE# Should perform the following tasks
#DONE# 1 Merges the training and the test sets to create one data set.
#DONE# 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
#DONE# 3 Uses descriptive activity names to name the activities in the data set
#DONE# 4 Appropriately labels the data set with descriptive variable names. 
#DONE# 5 From the data set in step 4, creates a second, independent tidy data set with 
   ## the average of each variable for each activity and each subject.
   ## upload your tidy data set from step 5 as a txt file created with write.table() using row.name=FALSE

# Load required packages
library(dplyr)

# Pull in label information
labels.features <- read.table("./UCI HAR Dataset/features.txt")
labels.activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
labels.activity <- tolower(as.vector(labels.activity[,2]))

# Combine the Test Data into a single set
message("Combining the test data into a single set.")
test.data <- read.table("./UCI HAR Dataset/test/X_test.txt")
test.activity <- read.table("./UCI HAR Dataset/test/y_test.txt")
test.subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test.subject,test.activity,test.data)
test[,"set"] <- cbind(rep("test",nrow(test)))

# Combine the Train Data into a single set
message("Combining the train data into a single set.")
train.data <- read.table("./UCI HAR Dataset/train/X_train.txt")
train.activity <- read.table("./UCI HAR Dataset/train/y_train.txt")
train.subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train.subject,train.activity,train.data)
train[,"set"] <- cbind(rep("train",nrow(train)))

# Merge the Test and Train datasets into a single set
message("Combining the imported test and train datasets into a single set.")
full <- rbind(train,test)
full[,1] <- as.factor(full[,1])
full[,2] <- as.factor(full[,2])
full[,564] <- as.factor(full[,564])

# Add appropriate column labels to the complete dataset
message("Adding original column names to the full dataset.")
labels.columns <- c("subject","activity")
labels.columns <- append(labels.columns,as.vector(labels.features[,2]))
labels.columns <- c(labels.columns, c("set"))
names(full) <- labels.columns

# Drop unnecessary columns, keeping only those for mean and standard deviation
message("Targeting only the variables dealing with mean measurements or standard deviation.")
labels.relevant <- grep("\\-mean\\(|\\-std\\(", labels.features[,2], ignore.case=TRUE, value=TRUE)
labels.relevant.index <- grep("\\-mean\\(|\\-std\\(", labels.features[,2], ignore.case=TRUE, value=FALSE) + 2
targetset <- full[,1:2]
targetset <- cbind(targetset,full[,labels.relevant.index])

# Replace activity names with descriptive activity names
levels(targetset[,"activity"]) <- labels.activity

# Replace column names with descriptive variable names
message("Rewording original variable descriptions for clarity.")
labels.relevant <- gsub("-|\\(|\\)","",labels.relevant,ignore.case=FALSE)
labels.relevant <- gsub("tBody","time.body.",labels.relevant,ignore.case=FALSE)
labels.relevant <- gsub("fBody","frequency.body.",labels.relevant,ignore.case=FALSE)
labels.relevant <- gsub("tGravity","time.gravity.",labels.relevant,ignore.case=FALSE)
labels.relevant <- gsub("Body","",labels.relevant,ignore.case=FALSE)
labels.relevant <- gsub("Acc","accelerometer.",labels.relevant,ignore.case=FALSE)
labels.relevant <- gsub("Gyro","gyroscope.",labels.relevant,ignore.case=FALSE)
labels.relevant <- gsub("Jerk","jerk.",labels.relevant,ignore.case=FALSE)
labels.relevant <- gsub("Mag","magnitude.",labels.relevant,ignore.case=FALSE)
labels.relevant <- gsub("std","standard.deviation",labels.relevant,ignore.case=FALSE)
labels.relevant <- gsub("X",".x",labels.relevant,ignore.case=FALSE)
labels.relevant <- gsub("Y",".y",labels.relevant,ignore.case=FALSE)
labels.relevant <- gsub("Z",".z",labels.relevant,ignore.case=FALSE)
names(targetset)[3:68] <- labels.relevant
#targetset <- targetset[,c(2,1,3:68)]

# Create tidy dataset of averages of each variable per subject and activity
targetset <- tbl_df(targetset)
targetset <- group_by(targetset,activity,subject)
list <- names(targetset)
tidy_data <- summarise_each(targetset,funs(mean))
list <- gsub("time","average.time",list)
list <- gsub("frequency","average.frequency",list)
names(tidy_data) <- list

# Remove all intermediate data
message("Cleaning up.")
rm(list=setdiff(ls(), c("targetset","tidy_data")))

# Write the tidy data output
message("Writing tidy dataset to file.")
write.table(tidy_data,file="./tidy_data.txt",row.names=FALSE)
message(paste("All done! The output file is available at: \n     ",getwd(),"/tidy_data.txt.",sep=""))
