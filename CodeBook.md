The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.
Assign each data to variables
1.-
x_test <- test/X_test.txt : 2947 rows, 561 columns contains recorded features test data
y_test <- test/y_test.txt : 2947 rows, 1 columns 
features <- features.txt : 561 rows, 2 columns
activities <- activity_labels.txt : 6 rows, 2 columns 
subject_test <- test/subject_test.txt : 2947 rows, 1 column contains test data of 9/30 volunteer test subjects being observed
subject_train <- test/subject_train.txt : 7352 rows, 1 column contains train data of 21/30 volunteer subjects being observed
x_train <- test/X_train.txt : 7352 rows, 561 columns contains recorded features train data
y_train <- test/y_train.txt : 7352 rows, 1 columns contains train data of activities’code labels

Xtt <-10299 rows, 561 columns is created by merging x_train and x_test using rbind() function
Ytt <-10299 rows, 1 column is created by merging y_train and y_test using rbind() function
Subjectt -> 10299 rows, 1 column is created by merging subject_train and subject_test using rbind() function
Merged <-10299 rows, 563 column is created by merging Subjectt, Ytt and Xtt using cbind() function
Tidymerged <-(10299 rows, 88 columns) is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement


Entire numbers in code column of the Tidymerged replaced with corresponding activity taken from second column of activities variables.
The columns in Tidymerged renamed into:
Acc in column’s name replaced by Accelerometer/ Gyro replaced by Gyroscope/ BodyBody replaced by Body/ Mag replaced by Magnitude/ character t and f replaced by Time and Frequency respectively/ tBody replaced by TimeBody / -mean replaced by Mean/ -std replaced by STD/-freq replaced by Fraquency/ angle replaced by Angle/ gravity replaced by Gravity

Final_Data <- 180 rows, 88 columns is created by sumarizing Tidymerged groupped by subject and activity and taking the means of each variable for each activity and each subject.
Export Final_Data into FinalData.txt file.