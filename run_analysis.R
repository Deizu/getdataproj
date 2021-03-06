# Load required packages
message("Loading required package: dplyr.")
suppressPackageStartupMessages(require(dplyr,quietly=TRUE))

# Pull in label information
labels.features <- read.table("./UCI HAR Dataset/features.txt")
labels.activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
labels.activity <- tolower(as.vector(labels.activity[,2]))

# Combine the Test Data into a single set
message("Combining the test data into a single 'test' set.")
test.data <- read.table("./UCI HAR Dataset/test/X_test.txt")
test.activity <- read.table("./UCI HAR Dataset/test/y_test.txt")
test.subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test <- cbind(test.activity,test.subject,test.data)
test[,"set"] <- cbind(rep("test",nrow(test)))

# Combine the Train Data into a single set
message("Combining the train data into a single 'train' set.")
train.data <- read.table("./UCI HAR Dataset/train/X_train.txt")
train.activity <- read.table("./UCI HAR Dataset/train/y_train.txt")
train.subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train <- cbind(train.activity,train.subject,train.data)
train[,"set"] <- cbind(rep("train",nrow(train)))

# Merge the Test and Train datasets into a single set
message("Combining the assembled 'test' and 'train' datasets into one full set.")
full <- rbind(train,test)
full[,1] <- as.factor(full[,1])
full[,2] <- as.factor(full[,2])
full[,564] <- as.factor(full[,564])

# Add appropriate column labels to the complete dataset
message("Adding original column names to the full dataset.")
labels.columns <- c("activity","subject")
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
message("Relabeling activities using their imported names.")
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

# Create tidy dataset of averages of each variable per subject and activity
message("Creating tidy dataset of averages of each variable per combination of subject and activity.")
targetset <- tbl_df(targetset)
targetset <- group_by(targetset,activity,subject)
list <- names(targetset)
tidy_data <- summarise_each(targetset,funs(mean))
list <- gsub("time","average.time",list)
list <- gsub("frequency","average.frequency",list)
names(tidy_data) <- list

# Remove all intermediate data
message("Cleaning up. Leaving final tidy dataset in R environment for inspection.")
rm(list=setdiff(ls(), c("tidy_data")))

# Write the tidy data output
message("Writing tidy dataset to file.")
write.table(tidy_data,file="./tidy_data.txt",row.names=FALSE)
message(paste("All done! The output file is available at: \n     ",getwd(),"/tidy_data.txt.",sep=""))
