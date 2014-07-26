cleaning data project
=====================

Files for the project of the data science - getting and cleaning data course.

The script run_analysis.R will check if /.data folder already exists. If not, it will download the data from this address:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and save it into a new folder named ./data. The downloaded zip file is unziped into the working directory.
The script than reads to memory the features.txt and the activity_labels.txt files which will be used to write descriptive column names and activities in the tidy data. In the next step the script reads the training data which includes the y_travin.txt file with the activity for each row and the subject_train.txt file which includes the subject that was measured for each row. Than the script reads the X_train.txt file which contains all the measurments (561 columns). The script adds the column names to the data from X_train.txt from features.txt and the lables as descriptive text and the number of the subject tested (1-30) for each measurmnet (for each row).
The same process is done for the test data.
The test and training data sets are combined into a single data set which will be written to a file named tidy_merged.txt. 

After creating the merged data set the script creates a second data set with the means of each variable for each subject and activity. In order to create this data set the script melts the data to show the activities and subjects. Than it is casting the melted table to show the means of the variables for each activity and for each subject. The data set will be saved in a file activity_subject_means.txt

The script finishes by writing the two tidy data set to two files tidy_merged.txt and activity_subject_means.txt.

