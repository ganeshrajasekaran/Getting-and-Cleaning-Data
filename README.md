# Getting and Cleaning Data

The Scope of this assignment is to come up with Tidy data set for *Human Activity Recognition Using Smartphones Dataset*. The Tidy Dataset will have the features related to Mean and Standard.

# Dataset Overview
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The downloaded dataset contains the following files

1. 'features_info.txt': Shows information about the variables used on the feature vector.

2. 'features.txt': List of all features.

3. 'activity_labels.txt': Links the class labels with their activity name.

4. 'train/X_train.txt': Training set.

5. 'train/y_train.txt': Training labels.

6. 'test/X_test.txt': Test set.

7. 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

1. 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 


# Steps

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

