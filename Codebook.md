The R script called run_analysis.R does the following.

1. Merges the training and the test sets to create one data set.

     Merge the training and test sets, features and activity labels into the variable "data".

2. Extracts only the measurements on the mean and standard deviation for each measurement.
    
     Extracted the means and standard deviation for all measurement into the variable "mean_sd"
    
3. Uses descriptive activity names to name the activities in the data set

     The descriptive activity is saved under the variable "activity_names"

4. Appropriately labels the data set with descriptive variable names.

     Labelling the data set with the function gsub, by replacing certain words. (i.e. Acc to Accelerometer, Gyro to Gyroscope, etc.)

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

     The average of each variable is saved under the variable data_summary and was then written off into tidydatasummary.txt
