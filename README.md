## Download file and unzip it:
```
fileName <- "Smartphones.zip"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "Smartphones"
download.file(url,fileName, mode = "wb") 
unzip("Smartphones.zip", files = NULL, exdir=".")
```
## Read Data
```
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
Data_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Data_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Aсtivity_test <- read.table("UCI HAR Dataset/test/y_test.txt")
Aсtivity_train <- read.table("UCI HAR Dataset/train/y_train.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")  
```
## Merges the training and the test sets to create one data set. 

```
alldataSubject <- rbind(subject_train, subject_test)
setnames(alldataSubject, "V1", "subject")
alldataTable <- rbind(Data_train, Data_test)
setnames(features, names(features), c("featureNum", "featureName"))
colnames(alldataTable) <- features$featureName
setnames(activity_labels, names(activity_labels), c("activityNum","activityName"))
alldataActivity<- rbind(Aсtivity_train, Aсtivity_test)
setnames(alldataActivity, "V1", "activityNum")
setnames(alldataActivity, "V1", "activityNum")
allSubjectjActivity<- cbind(alldataSubject, alldataActivity)
dataAll <- cbind(allSubjectjActivity, alldataTable)
```
## Extracts only the measurements on the mean and standard deviation for each measurement.
```
FeaturesMeanStd <- grep("mean\\(\\)|std\\(\\)",features$featureName,value=TRUE)
FeaturesMeanStd <- union(c("subject","activityNum"), FeaturesMeanStd)
dataAll<- subset(dataAll,select=FeaturesMeanStd) 
```
## Uses descriptive activity names to name the activities in the data set

```
library(dplyr)
library(gapminder)
dataAll <- merge(activity_labels, dataAll , by="activityNum", all.x=TRUE)
dataAll$activityName <- as.character(dataAll$activityName)
dataNew<- aggregate(. ~ subject - activityName, data = dataAll, mean) 
dataAll<- tbl_df(arrange(dataNew,subject,activityName))
```
## Appropriately labels the data set with descriptive variable names
```
head(str(dataAll),2)
```
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
```
write.table(dataAll, "TidyData.txt", row.name=FALSE)
```
## There are TidyData.txt:
The first row is the header containing the names for each column.
180 groups (30 subjects and 6 activities)
71 columns – 33 Mean variables + 33 Standard deviation variables + 1 subject( 1 of of the 30 test subjects) + activityName + activityNum + activityName.x + activityName.y

