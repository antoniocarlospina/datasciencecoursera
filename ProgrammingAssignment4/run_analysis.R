#Getting and Cleaning Data Course Project
#Antonio Carlos Pina
#
#To run: put this file anywhere and run it with
#source("run_analysis.R")
#
#The purpose of this project is to demonstrate your ability to collect,
#work with, and clean a data set.
#
#INSTRUCTIONS "as-is":
#
#You should create one R script called run_analysis.R that does the following.
#
#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement.
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names.
#From the data set in step 4, creates a second, independent tidy data set with the average of each
#  variable for each activity and each subject.
#
#STEP 0: Libraries, Variables & Constants
#
require("reshape2")
require("data.table")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
my_file <- "Dataset.zip"
my_dir <- getwd()
#
#STEP 1: Prepare the environment
#
cat("Starting run_analysis.R\n")
if (!file.exists(my_file)) {
  cat("... Downloading the file\n")
  download.file(fileUrl, destfile = my_file, method = "curl")
}
cat("... Unzipping the file\n")
unzip(my_file)
cat("... Changing to the work directory\n")
setwd("UCI HAR Dataset")
#
#STEP 2: Load the files
#
cat("... Loading the datasets. It can take a while !\n")
#train
xtrain <- read.table("./train/X_train.txt")
ytrain <- read.table("./train/y_train.txt")
strain <- read.table("./train/subject_train.txt")
#test
xtest <- read.table("./test/X_test.txt")
ytest <- read.table("./test/y_test.txt")
stest <- read.table("./test/subject_test.txt")
#Load the labels
my_activity_labels <- read.table("activity_labels.txt")[,2]
my_features_labels <- read.table("features.txt")[,2]
#
#STEP 3: Separating only mean and std
#
names(xtrain) <- my_features_labels
names(xtest) <- my_features_labels
cat("... Filtering mean and std in the datasets\n")
sep_features <- grepl("mean\\(|std\\(", my_features_labels)
xtrain <- xtrain[,sep_features]
xtest <- xtest[,sep_features]
#
#STEP 4: Labeling 
#
cat("... Labeling columns \n")
names(strain) <- "SubjectID"
names(stest) <- "SubjectID"
#Create new column with Activity
ytest[,2] = my_activity_labels[ytest[,1]]
ytrain[,2] = my_activity_labels[ytrain[,1]]
names(ytest) <- c("ActivityID", "ActivityName")
names(ytrain) <- c("ActivityID", "ActivityName")
#
#STEP 5: Binding Data
#
cat("... Merging everything\n")
mergetest <- cbind(stest,ytest,xtest)
#releasing some memory after the merge
rm(stest)
rm(ytest)
rm(xtest)
mergetrain <- cbind(strain,ytrain,xtrain)
#releasing some memory after the merge
rm(strain)
rm(ytrain)
rm(xtrain)
mergedata <- rbind(mergetest, mergetrain)
#releasing some memory after the merge
rm(mergetest)
rm(mergetrain)
#
# Finally, "mergedata" - There can be only one ...
#
#
cat("... Melting data and applying mean()\n")
meltdata <- melt(mergedata, id = c("SubjectID","ActivityID","ActivityName"))
#releasing some memory after the melt
rm(mergedata)
#Using dcast to apply mean
tidy <- dcast(meltdata, SubjectID + ActivityID + ActivityName ~ variable, mean)
cat("... Writing final file ./UCI HAR Dataset/tidy.csv\n")
write.csv(tidy, "tidy.csv", row.names=FALSE)
#
#STEP final: Return the environment
#
cat("... Returning to original dir\n")
setwd(my_dir)
cat("... Removing the ZIP file\n")
file.remove(my_file)
cat("End of Execution. Look ./UCI HAR Dataset/tidy.csv\n")
