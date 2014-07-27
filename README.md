# Getting and Cleaning Data

## Course Project

You should create one R script called run_analysis.R that does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Project requirements

1. Download and extract the data source; find the ```UCI HAR Dataset``` folder.
2. Set the working directory as the parent folder of ```UCI HAR Dataset``` by using __Session>Set Working Directory>Choose Directory...__, __Ctrl+Shift+H__, or the ```setwd()``` command in RStudio. 
3. Load the ```reshape2``` and ```data.table``` package libraries.
4. Run the ```run_analysis.R``` script; this will create a new file called ```tiny_data.txt``` in the working directory containing the cleaned data.