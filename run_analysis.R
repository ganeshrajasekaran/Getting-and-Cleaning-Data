#################################################################################
### The purpose of this project is to demonstrate ability to collect, work with,
### and clean a data set.
### The goal is to prepare tidy data from a raw data set. This tidy data can be 
### used later for analysis purpose.
################################################################################
library(dplyr)

############################### Step 1 #####################################
### 1.1 Download the Dataset from site 
### 1.2 Extract the Feature sets and Activity Lables
###########################################################################

# Download the Datasets
if(!file.exists("./data")){
    dir.create("./data")
}

if (!file.exists("/data/Dataset.zip")) {
    
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    
    download.file(fileUrl,destfile="./data/Dataset.zip", mode = "wb")

    # Unzip dataSet to /data directory
    unzip(zipfile="./data/Dataset.zip",exdir="./data")
}

# Extract the Feature Sets & Activity Lables
features <- read.table('./data/UCI HAR Dataset/features.txt')
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

#Name the columns for Activity Label DataSets
colnames(activityLabels) <- c('activityId','activityType')


############################### Step 2 #####################################
### Merging the training and the test sets to create one data set.
###
### We perform the following sub sets in this step
### 2.1 Read the Training Data related files
### 2.2 Read the Test Data related files
### 2.3 Rename the raw Column names of Traning & Test Dataset with the actual 
###    Feature names
### 2.4 Merge Training Datasets column wise
### 2.5 Merge Test Datasets column wise
### 2.6 Merge Training & Test Datasets row wise
###########################################################################

# Read the Training Dataset files
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# Read the Test Dataset files
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Rename the columns of the Training & Test Datasets
colnames(x_train) <- features[,2]
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

# Merge the column wise (Activity, Subject, Features from X)

trainMerged <- cbind(y_train, subject_train, x_train)
testMerged <- cbind(y_test, subject_test, x_test)

# Merge the row wise 
completeDT <- rbind(trainMerged, testMerged)

############################### Step 3 #####################################
### We dont need all the features in the dataset. We should extract only
### the features required for our assignment. those are Mean & Std
###
###########################################################################
colNames <- colnames(completeDT)

meanAndStdColumns <- (grepl("activityId" , colNames) | 
                     grepl("subjectId" , colNames) | 
                     grepl("mean.." , colNames) | 
                     grepl("std.." , colNames) )

# Extract the new Dataset from the completeDT
trimmedDataTable <- completeDT[ , meanAndStdColumns == TRUE]

############################### Step 4 #####################################
### Use the Descriptive names for both Activity & Variables in the dataset.
###########################################################################

# Update the ActivityId to Descriptive Names
trimmedDataTable$activityId <- factor(trimmedDataTable$activityId, 
                                 levels = activityLabels[, 1], labels = activityLabels[, 2])

trimmedDataTableCols <- colnames(trimmedDataTable)

#Update the Variables to Descriptive Names
trimmedDataTableCols <- gsub("[\\(\\)-]", "", trimmedDataTableCols)
trimmedDataTableCols <- gsub("^f", "frequencyDomain", trimmedDataTableCols)
trimmedDataTableCols <- gsub("^t", "timeDomain", trimmedDataTableCols)
trimmedDataTableCols <- gsub("Acc", "Accelerometer", trimmedDataTableCols)
trimmedDataTableCols <- gsub("Gyro", "Gyroscope", trimmedDataTableCols)
trimmedDataTableCols <- gsub("Mag", "Magnitude", trimmedDataTableCols)
trimmedDataTableCols <- gsub("Freq", "Frequency", trimmedDataTableCols)
trimmedDataTableCols <- gsub("mean", "Mean", trimmedDataTableCols)
trimmedDataTableCols <- gsub("std", "StandardDeviation", trimmedDataTableCols)
trimmedDataTableCols <- gsub("BodyBody", "Body", trimmedDataTableCols)

colnames(trimmedDataTable) <- trimmedDataTableCols


############################### Step 5 #####################################
### On the trimmedDataTable Dataset, we should perform the average on the Mean & Std
### related varible by grouping Subject & Activity.
### The result will be having a row for per Subject & Activity
###########################################################################

aggregatedDataTable <- aggregate(. ~subjectId + activityId, trimmedDataTable, mean)
aggregatedDataTable <- aggregatedDataTable[order(aggregatedDataTable$subjectId, aggregatedDataTable$activityId),]

############################### Step 6 #####################################
### Write the Aggregated Data Table into a new File. 
###
###########################################################################

write.table(aggregatedDataTable, "tidy_data_set.txt", row.name=FALSE, quote = FALSE)


