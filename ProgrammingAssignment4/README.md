# Assignment #

This is a programming assignment of the "Getting and Cleaning Data" course
 (part of the Data Science specialization from Johns Hopkins - Coursera)

The purpose of this project is to demonstrate the ability to:

* Collecting
* Manipulating
* Cleaning

a dataset, transforming unformatted data in tidy data for further analysis.

## Project ##

This project includes:

* the tidy data set result of the script (**tidy.csv**)
* the script that performs the transformation of the data (**run_analysis.R**)
* a code book that describes the data and how it was transformed
* this file

## The unformatted data set ##

The data source is a collection of data acquired from the accelerometers from a Samsung Galaxy S smartphone. It's the so called "Wearable Computing" (think Fitbit, Apple Watch, etc) where those devices performing continuous monitoring on our movements.

Here is the source Website:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

And here is the original Dataset to be transformed:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## run_analysis.R ##

This script is fully commented and also sends messages to the console. The required transformation is:

* To merge the training and test sets
* To extract only the "mean" and "standard deviation" measurements of each measurement
* To apply descriptive activity names in the data set
* To label everything with descriptive variable names
* To create a second, independent tidy data set with the average of each variable for each activity and each subject

**Attention: The script relies on "reshape2" and "data.table". If you don't have it (I doubt ;-)) please remember to install it!**

## Code Book ##

The Code Book file brings more information on the variables and transformation.

