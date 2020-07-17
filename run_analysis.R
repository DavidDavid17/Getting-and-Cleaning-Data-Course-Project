---
  title: "Untitled"
output: html_document
---
  
  ```{r}
library(dplyr)
```

### Preparing the data

```{r}
filename <- "Getting_and_cleaning_data_coursera.zip"
if (!file.exists(filename)){fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"download.file(fileURL, filename, method="curl")} 
if (!file.exists("UCI HAR Dataset")) {unzip(filename)}
```

```{r}
features <- read.table("UCI HAR Dataset/features.txt")
```

```{r}
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
```

```{r}
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
features_test <- read.table("UCI HAR Dataset/test/X_test.txt")
activity_test <- read.table("UCI HAR Dataset/test/y_test.txt")
```

```{r}
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
features_train <- read.table("UCI HAR Dataset/train/X_train.txt")
activity_train <- read.table("UCI HAR Dataset/train/y_train.txt")
```

### 1. Merges the training and the test sets to create one data set.

```{r}
colnames(features_train) <- features[,2]
colnames(activity_train) <-"activityId"
colnames(subject_train) <- "subjectId"

```

```{r}
colnames(features_test) <- features[,2] 
colnames(activity_test) <- "activityId"
colnames(subject_test) <- "subjectId"
colnames(activity_labels) <- c('activityId','activityType')
```

```{r}
data_train <- cbind(activity_train,subject_train,features_train)
data_test <- cbind(activity_test,subject_test,features_test)
data <- rbind(data_train,data_test)
```

### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

```{r}
colNames <- colnames(data)
mean_sd <- (grepl("activityId",colNames)|grepl("subjectId",colNames)|grepl("mean..",colNames) |grepl("std..",colNames))
mean_sd <- data[,mean_sd == TRUE]

```

### 3. Uses descriptive activity names to name the activities in the data set

```{r}
activity_names <- merge(mean_sd, activity_labels,
                        by='activityId',
                        all.x=TRUE)
```

### 4. Appropriately labels the data set with descriptive variable names.

```{r}
names(activity_names)<-gsub("Acc","Accelerometer",names(activity_names))
names(activity_names)<-gsub("Gyro","Gyroscope",names(activity_names))
names(activity_names)<-gsub("BodyBody","Body",names(activity_names))
names(activity_names)<-gsub("Mag","Magnitude",names(activity_names))
names(activity_names)<-gsub("^t","Time",names(activity_names))
names(activity_names)<-gsub("^f","Frequency",names(activity_names))
names(activity_names)<-gsub("tBody","TimeBody",names(activity_names))
names(activity_names)<-gsub("angle","Angle",names(activity_names))
names(activity_names)<-gsub("gravity","Gravity",names(activity_names))
names(activity_names)<-gsub("-mean()","Mean",names(activity_names), ignore.case = TRUE)
names(activity_names)<-gsub("-std()","STD",names(activity_names), ignore.case = TRUE)
names(activity_names)<-gsub("-freq()","Frequency",names(activity_names), ignore.case = TRUE)
```

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


```{r}
data_summary <- activity_names %>%
  group_by(subjectId, activityId) %>%
  summarise_all(list(mean),na.rm = TRUE) %>%
  ungroup()
write.table(data_summary, "Tidydatasummary.txt", row.name=FALSE)
```

```{r}
data_summary
```
