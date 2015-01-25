setwd("d:/zhengcl/Datascience/Getting_and_cleaning/Project")
library(dplyr)

# Read training data into R and combine with subjects and activities
trainData <- read.table("./train/X_train.txt")
train_subject <- read.table("./train/subject_train.txt")
train_activity <- read.table("./train/y_train.txt")
train <- cbind(train_subject, train_activity, trainData)

# # Read test data into R and combine with subjects and activities
testData <- read.table("./test/X_test.txt")
test_subject <- read.table("./test/subject_test.txt")
test_activity <- read.table("./test/y_test.txt")
test <- cbind(test_subject, test_activity, testData)

# Merge training and test data into one dataset
features <- read.table("features.txt", sep="\t", colClasses="character")
feature <- as.vector(features[, 1])
colNames <- c("subject", "activity", feature)
names(test) <- colNames
names(train) <- colNames
allData <- merge(train, test, all=TRUE)
allData <- arrange(allData, subject, activity)

# Extract data with only mean and stadard deviation of each measurement
meanstdData <- select(allData, subject, activity, matches("mean\\()|std\\()"))

# Name activities using descriptive names
meanstdData$activity <- factor(meanstdData$activity, labels=c("walking", 
  "walking_upstair", "walking_downstair", "sitting", "standing", "laying"))

# Lable the dataset with descriptive varible names
colnames(meanstdData)[1] <- "1 subject"
colnames(meanstdData)[2] <- "2 activity"
splitNames = strsplit(names(meanstdData), " ")
secondElement <- function(x){x[2]}
names(meanstdData) <- sapply(splitNames, secondElement)  # Remove prefix numbers 

tidyCol <- names(meanstdData)
tidyCol <- gsub("-|\\()", "", tidyCol)  # Remove dash and brackets
tidyCol <- gsub("^t", "time", tidyCol)  # Replace fisrt "t" with "time"
tidyCol <- gsub("^f", "freq", tidyCol)  # Replace fisrt "f" with "freq"
tidyCol <- gsub("BodyBody", "Body", tidyCol)  ## Fix double "Body" error
names(meanstdData) <- tidyCol

# Generate tidy data
by_sub_ac <- group_by(meanstdData, subject, activity)
finalData <- summarise_each(by_sub_ac, funs(mean))
write.table(finalData, "tidyData.txt", row.names=FALSE)


