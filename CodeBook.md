Coursera-Getting and Cleaning Data
==================================
This is a Code Book that describes the variables in the data and the process undertaken to clean the data

* The data being cleaned is from experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. It was obtained from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
* The data for the project was downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

* To clean up the data, run_analysis.R script is run on the RStudio console. It carries out the following:

  1. It reads data in the 'train' folder that is within the 'UCIHARDataset' fo 
lder; X_train.txt is read as a table into trainingData variable (7352*561 table), y_train.txt is read as a table into trainingLabel variable (7352*1 table) and subject_train.txt is read as a table into trainingSubject variable (7352*1 table)
2. It reads data in the 'test' folder that is within the 'UCIHARDataset' fo 
lder: X_test.txt is read as a table into testData variable (2947*561 table), y_test.txt is read as a table into testLabel variable (2947*1 table) and subject_test.txt is read as a table into testSubject variable (2947*1 table)
3. Merges the data from the train and test folder: trainingData and testData are merged into mergedData variable (10299*561 table), trainingLabel and testLabel are merged into mergedLable variable (10299*1 table) and trainingSubject and testSubject are merged into mergedSubject variable (10299*561 table)
4. Reads the features.txt file in the UCIHARDataset and stores it in the featureData variable (it extracts only the measurements on the mean and standard deviation for each measurement) then cleans the column names of the subset by removing the "()" and "-" symbols in the names
5. Reads the activity_labels.txt file in the UCIHARDataset and stores it in the activityData variable, clean the activity names in the second column of activity.
6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject 
