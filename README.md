# Getting and Cleaning Data Project

## Description of run_analysis.R

The data cleanup script does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Procedure

1. For the test and train data setsit creates an interim dataset:
    1. Extract the mean and standard deviation features.
    2. Get the list of activities.
    3. Put the activity labels.
    4. Get the list of subjects.
    5. Put the subject IDs.
2. Join the test and train interim datasets.
3. Split the variables.
4. Marges the table, keying on subject and acitivity: mean function to each vector of values in each subject/activity pair
5. Write the tidy data set into a text file.
