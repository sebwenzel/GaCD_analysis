### PRE-PROCESSING

## clean memory
rm(list=ls())

## get working directory into wd
wd <- getwd()

## load libreries
library(data.table)


### MAIN PROGRAM CODE

## Purpose of this code is:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average 
##    of each variable for each activity and each subject.

# load data
X_train <- read.table("./data/train/X_train.txt")
X_test <- read.table("./data/test/X_test.txt")

Y_train <- read.table("./data/train/Y_train.txt")
Y_test <- read.table("./data/test/Y_test.txt")

subject_train = read.table("./data/train/subject_train.txt")
subject_test = read.table("./data/test/subject_test.txt")

## 1. - mearging data
# join data
X_all <- rbind(X_train, X_test)
Y_all <- rbind(Y_train, Y_test)
subject_all <- rbind(subject_train, subject_test)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# features
# load features
features <- read.table("./data/features.txt")
# create subset for valide features
valid_features <- grep("mean\\(\\)|std\\(\\)", features[, 2])

# create subset of X_all with only columns matching valid_features
X_all <- X_all[, valid_features]




## 3. Uses descriptive activity names to name the activities in the data set
# activities
# load activities
activities <- read.table("./data/activity_labels.txt", col.names = c("id","label")) 
# clean activities
activities[ ,2] <- tolower(gsub("_", "", as.character(activities[ ,2])))

names(Y_all) = "id"
activity <- merge(Y_all, activities, by="id")$label


## 4. Appropriately labels the data set with descriptive variable names.
# create correct names for X_all
# '()' removed
X_all_names <- gsub("\\(\\)", "", features[valid_features, 2]) 
# '-' removed
X_all_names <- gsub("-", "", X_all_names) 
# 'M' for Mean
X_all_names <- gsub("mean", "Mean", X_all_names)
# 'S' for Std
X_all_names <- gsub("std", "Std", X_all_names)

# set new names for X_all columns
names(X_all) <- X_all_names


# writing new tidy data set into a text-file
names(subject_all) <- "subject"
data_new <- cbind(subject_all, X_all, activity)
write.table(data_new, "data_new.txt", row.name=FALSE)



## 5. From the data set in step 4, creates a second, independent tidy data set with the average 
##    of each variable for each activity and each subject.

dataDT <- data.table(data_new)
data_new_calc<- dataDT[, lapply(.SD, mean), by=c("subject", "activity")]
write.table(data_new_calc, "data_new_calc.txt", row.name=FALSE)


### POST-PROCESSING

## return to working directory from start
setwd(wd)

## clean memory
#rm(list=ls())
