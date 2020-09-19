library(dplyr)
#training and test data and create one data set
features <- read.table("../Getting-and-Cleaning-/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("../Getting-and-Cleaning-/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("../Getting-and-Cleaning-/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("../Getting-and-Cleaning-/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("../Getting-and-Cleaning-/UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("../Getting-and-Cleaning-/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("../Getting-and-Cleaning-/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("../Getting-and-Cleaning-/UCI HAR Dataset/train/y_train.txt", col.names = "code")

Xtt <- rbind(x_train, x_test)
Ytt <- rbind(y_train, y_test)
Subjectt <- rbind(subject_test, subject_train)
Merged <- cbind(Subjectt, Xtt, Ytt)

#Extract measurements on the mean and sd 

Tidymerged <- select(Merged, subject, code, contains("mean"), contains("std") )

#Uses descriptive activity names to name the activities in the data set
Tidymerged$code <- activities[Tidymerged$code, 2]

#Appropriately labels the data set with descriptive variable names.


names(Tidymerged)[2] = "activity"
names(Tidymerged)<-gsub("Acc", "Accelerometer", names(Tidymerged)) 
names(Tidymerged) <-gsub("Gyro", "Gyroscope", names(Tidymerged))
names(Tidymerged) <- gsub("BodyBody", "Body", names(Tidymerged))
names(Tidymerged) <-gsub("Mag", "Magnitude", names(Tidymerged)) 
names(Tidymerged)<- gsub("^t", "Time", names(Tidymerged))
names(Tidymerged)<- gsub("^f", "Frequency", names(Tidymerged)) 
names(Tidymerged) <-gsub("tBody", "TimeBody", names(Tidymerged)) 
names(Tidymerged) <-gsub("-mean()", "Mean", names(Tidymerged), ignore.case = TRUE)
names(Tidymerged) <-gsub("-std()", "STD", names(Tidymerged), ignore.case = TRUE) 
names(Tidymerged) <- gsub("-freq()", "Frequency", names(Tidymerged), ignore.case = TRUE)
names(Tidymerged) <-gsub("angle", "Angle", names(Tidymerged))
names(Tidymerged) <- gsub("gravity", "Gravity", names(Tidymerged))

#Creates a second, independent tidy data set with the average of each variable
#for each activity and each subject.

FinalData <- Tidymerged %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)

View(FinalData)

