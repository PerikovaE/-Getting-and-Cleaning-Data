fileName <- "Smartphones.zip"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "Smartphones"
download.file(url,fileName, mode = "wb") 
unzip("Smartphones.zip", files = NULL, exdir=".")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
Data_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Data_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Aсtivity_test <- read.table("UCI HAR Dataset/test/y_test.txt")
Aсtivity_train <- read.table("UCI HAR Dataset/train/y_train.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")  

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

FeaturesMeanStd <- grep("mean\\(\\)|std\\(\\)",features$featureName,value=TRUE)
FeaturesMeanStd <- union(c("subject","activityNum"), FeaturesMeanStd)
dataAll<- subset(dataAll,select=FeaturesMeanStd) 

install.packages(dplyr)
library(dplyr)
install.packages(gapminder)
library(gapminder)
dataAll <- merge(activity_labels, dataAll , by="activityNum", all.x=TRUE)
dataAll$activityName <- as.character(dataAll$activityName)
dataNew<- aggregate(. ~ subject - activityName, data = dataAll, mean) 
dataAll<- tbl_df(arrange(dataNew,subject,activityName))

head(str(dataAll),2)

write.table(dataAll, "TidyData.txt", row.name=FALSE)
