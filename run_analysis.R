## Getting and Cleaning Data - Project 1
library(reshape2)
## Download the data file
if (!file.exists("data")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    dir.create("data")
    download.file(fileUrl, destfile="./data/acc_data.zip", 
                  method = "curl")
    unzip("./data/acc_data.zip")
}

## Merghe the training and test sets to create one data set
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
## Load the training set files
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(X_train) <- features$V2 # Add the colnames to the trining dataset.
X_train$activ_label <- y_train # Add a column of activity labels (1-6)
X_train$activ_label <- unlist(X_train$activ_label)
X_train$subject <- subject_train # Add a column of the subject (1-30)
X_train$subject <- unlist(X_train$subject)

## Load the test set files
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(X_test) <- features$V2
X_test$activ_label <- y_test
X_test$activ_label <- unlist(X_test$activ_label)
X_test$subject <- subject_test
X_test$subject <- unlist(X_test$subject)

# Merge the trainign set and the test set to one data set
merged_set <- rbind(X_test, X_train)
# Create factor with descriptive activity names
merged_set$activ_label <- factor(merged_set$activ_label, 
                                 levels = activity_labels$V1, 
                                 labels = activity_labels$V2)

## Extract the mean and standard deviation for each measurement
mean_cols <- c(1, 2, 3, 41, 42, 43, 81, 82, 83, 121, 122, 123, 
               161, 162, 163, 201, 214, 227, 240, 253, 266,267, 
               268, 294, 295, 296, 345, 346, 347, 373, 374, 375, 
               424, 425, 426, 452, 453, 454, 503, 513, 516, 526, 
               529, 539, 542, 552, 555, 556, 557, 558, 559, 560, 561)
std_cols <- c(4, 5, 6, 44, 45, 46, 84, 85, 86, 124, 125, 126, 164, 
              165, 166, 202, 215, 228, 241, 254, 269, 270, 271, 
              348, 349, 350, 427, 428, 429, 504, 517, 530, 543)
std_mean_cols <- sort(c(mean_cols, std_cols))
mean_std_set <- merged_set[, std_mean_cols]

## Create a new data set with the average of each variable for each activity
## and each subject.
merged_set_melt <- melt(merged_set, id=c("activ_label", "subject"))
activ_subj_cast <- dcast(merged_set_melt, activ_label+subject~variable, mean)
# save data set to a file
write.table(merged_set, "tidy_merged.txt")
write.table(activ_subj_cast, "activity_subject_means.txt")
