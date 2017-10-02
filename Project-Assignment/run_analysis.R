## Getting and Cleaning Data: Peer-graded Assignment Project
##

# Load libraries.
library("data.table")

# Load txt files.
dest1 <- "./UCI HAR Dataset/test/X_test.txt"
dest2 <- "./UCI HAR Dataset/test/y_test.txt"
dest3 <- "./UCI HAR Dataset/test/subject_test.txt"
dest4 <- "./UCI HAR Dataset/train/X_train.txt"
dest5 <- "./UCI HAR Dataset/train/y_train.txt"
dest6 <- "./UCI HAR Dataset/train/subject_train.txt"
dest7 <- "./UCI HAR Dataset/features.txt"
dest8 <- "./UCI HAR Dataset/activity_labels.txt"
x_test <- read.table(dest1)             # dim(x_test): 2947 561
y_test <- read.table(dest2)             # dim(y_test): 2947 1
sub_test <- read.table(dest3)           # dim(sub_test): 2947 1
x_train <- read.table(dest4)            # dim(x_train): 7352 561
y_train <- read.table(dest5)            # dim(y_train): 7352 1
sub_train <- read.table(dest6)          # dim(sub_train): 7352 1
feature <- read.table(dest7)            # dim(feature): 561 2
act_labels <- read.table(dest8)         # dim(act_labels): 6 2



## 1. Merges the training and the test sets to
## create one data set.
##

library("dplyr")
## Add data type {test, train}.
x_test <- mutate(x_test, datatype="test")
x_train <- mutate(x_train, datatype="train")

## Combine each y_test and y_train with act_labels
y_test_labeled <- mutate(y_test, act_label=act_labels[2][V1,])
y_train_labeled <- mutate(y_train, act_label=act_labels[2][V1,])

## Combine data by column
test_combined <- cbind(sub_test, y_test_labeled, x_test)
train_combined <- cbind(sub_train, y_train_labeled, x_train)

## Rename for convenience
names(test_combined)[1] <- "subject"
names(train_combined)[1] <- "subject"
names(test_combined)[2] <- "act_no"
names(train_combined)[2] <- "act_no"

## Then combine the two data by row, and update column name by
## the features
all_combined <- rbind(test_combined, train_combined)
names(all_combined)[4:564] <- as.character(feature[,2])



## 2. Extracts only the measurements on the mean and standard
## deviation for each measurement.

## These are the letters we want to be in the column names
wanted <- c("[Mm]ean\\(\\)","std\\(\\)")
## Select column numbers that contain those letters.
cols_wanted <- 
    c(
        1,2,3,grep(paste(wanted,collapse="|"),
        names(all_combined))
    )
## Then get the subset from the data.
all_wanted <- all_combined[ , cols_wanted]



## 3. Uses descriptive activity names to name the activities
## in the data set

# This was already done by the following codes in
# line 38 and 39.
# y_test_labeled <- mutate(y_test, act_label=act_labels[2][V1,])
# y_train_labeled <- mutate(y_train, act_label=act_labels[2][V1,])



## 4. Appropriately labels the data set with descriptive variable names.

names(all_wanted)<-gsub("^t", "time", names(all_wanted))
names(all_wanted)<-gsub("^f", "frequency", names(all_wanted))
names(all_wanted)<-gsub("Acc", "Accelerometer", names(all_wanted))
names(all_wanted)<-gsub("Gyro", "Gyroscope", names(all_wanted))
names(all_wanted)<-gsub("Mag", "Magnitude", names(all_wanted))
names(all_wanted)<-gsub("BodyBody", "Body", names(all_wanted))



## 5. From the data set in step 4, creates a second,
## independent tidy data set with the average of each
## variable for each activity and each subject.
library(plyr)
head(names(all_wanted))
tidy_result <-aggregate(. ~subject + act_label, all_wanted, mean)
tidy_result<-tidy_result[order(tidy_result$subject,tidy_result$act_no),]
write.table(tidy_result, file = "Tidy.txt",row.name=FALSE)
