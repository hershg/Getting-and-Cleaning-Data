# Create one R script called run_analysis.R that does the following:
#   1. Merges the training and the test sets to create one data set.
#   2. Extracts only the measurements on the mean and standard deviation for each measurement.
#   3. Uses descriptive activity names to name the activities in the data set
#   4. Appropriately labels the data set with descriptive activity names.
#   5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(data.table)
library(reshape2)

# Load activity labels from file
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")[,2]

# Load features from file
features <- read.table("UCI HAR Dataset/features.txt")[,2]

# Create logical vector showing measurments on only mean and standard deviation
mean_std_features <- grepl("mean|std", features)

# Load X_test, y_test, and subject_test data from file
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Give X_test proper column names(the names from the features file)instead of just numbered columns
names(X_test) = features

# Simplify X_test to only measurments involving mean and standard deviation (using mean_std_features from before)
X_test = X_test[,mean_std_features]

# Assign level names from level numbers in column 2 of y_test
y_test[,2] = activity_labels[y_test[,1]]

# Give y_test and subject_test proper column names
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

# Merge subject_test, y_test, and X_test data into test_data
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

# Load X_train, y_train, and subject_train data from file
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Give X_train proper column names
names(X_train) = features

# Simplify X_train to only measurments involving mean and standard deviation
X_train = X_train[,mean_std_features]

# Assign level names from level numbers in column 2 of y_train
y_train[,2] = activity_labels[y_train[,1]]

# Give y_train and subject_train proper column names
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

# Merge subject_train, y_train, and X_train data into train_data
train_data <- cbind(as.data.table(subject_train), y_train, X_train)

# Merge test_data with train_data
data = rbind(test_data, train_data)

# Melt data
id_labels = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data = melt(data, id = id_labels, measure.vars = data_labels)

# Reshape data (tidy_data) and apply mean function to melted data with dcast
tidy_data = dcast(melt_data, subject + Activity_Label ~ variable, mean)

# Create a file containing the tidy, cleaned data
write.table(tidy_data, file = "tidy_data.txt")