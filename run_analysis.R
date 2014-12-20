#setwd("~/coursera-data-cleaning")

# Read and merge data in the train and test folders within the UCI HAR Dataset folder

trainingData <- read.table("./UCIHARDataset/train/X_train.txt") #7352*561

trainingLabel <- read.table("./UCIHARDataset/train/y_train.txt") #7352*1

trainingSubject <- read.table("./UCIHARDataset/train/subject_train.txt") #7352*1

testData <- read.table("./UCIHARDataset/test/X_test.txt") #2947*561

testLabel <- read.table("./UCIHARDataset/test/y_test.txt") #2947*1 

testSubject <- read.table("./UCIHARDataset/test/subject_test.txt") #2947*1

#merge trainingData and testData
mergedData <- rbind(trainingData, testData) #10299*561
#merge trainingLabel and testData
mergedLabel <- rbind(trainingLabel, testLabel) #10299*1
#merge trainingSubject and testSubject
mergedSubject <- rbind(trainingSubject, testSubject) #10299*1

#Extract only the measurements on the mean and standard deviation for each measurement. 
featuresData <- read.table("./UCIHARDataset/features.txt") #561*2

meanSD <- grep("mean\\(\\)|std\\(\\)", features[, 2]) #66

mergedData <- mergedData[, meanSD] #10299*66

names(mergedData) <- gsub("\\(\\)", "", featuresData[meanSD, 2]) # remove "()"

names(mergedData) <- gsub("-", "", names(mergedData)) # remove "-" in column names 

# Name the activities in the data set using descriptive names
activityData <- read.table("./UCIHARDataset/activity_labels.txt")
activityData[, 2] <- tolower(gsub("_", "", activityData[, 2]))
substr(activityData[2, 2], 8, 8) <- toupper(substr(activityData[2, 2], 8, 8))
substr(activityData[3, 2], 8, 8) <- toupper(substr(activityData[3, 2], 8, 8))
activityLabel <- activityData[mergedLabel[, 1], 2]
mergedLabel[, 1] <- activityLabel
names(mergedLabel) <- "activity"

# Label the data set with descriptive activity names
names(mergedSubject) <- "subject"
cleanData <- cbind(mergedSubject, mergedLabel, mergedData)
write.table(cleanData, "merged_data.txt") 

# Create a second, independent tidy data set with the average of 
# each variable for each activity and each subject 
subjectLength <- length(table(mergedSubject)) # 30
activityLength <- dim(activityData)[1] # 6
columnLength <- dim(cleanData)[2]
newData <- matrix(NA, nrow=subjectLength*activityLength, ncol=columnLength) 
newData <- as.data.frame(newData)
colnames(newData) <- colnames(cleanData)
row <- 1
for(i in 1:subjectLength) {
  for(j in 1:activityLength) {
    newData[row, 1] <- sort(unique(mergedSubject)[, 1])[i]
    newData[row, 2] <- activityData[j, 2]
    x <- i == cleanData$subject
    y <- activityData[j, 2] == cleanData$activityData
    newData[row, 3:columnLength] <- colMeans(cleanData[x&y, 3:columnLength])
    row <- row + 1
  }
}

write.table(newData, "meanData.txt") 
