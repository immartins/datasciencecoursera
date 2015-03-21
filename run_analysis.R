# file URL
  fileURL <- 'http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
  
# local data file
  dataFile <- "./getdata-projectfiles-UCI-HAR-Dataset.zip"
  
# directory
  dir <- "./UCI HAR Dataset"
  
# directory and filenames
  tidyDataFile <- "./tidy-UCI-HAR-dataset.txt"
  tidyDataFileAVGtxt <- "./tidy-UCI-HAR-dataset-AVG.txt"
# download the dataset if it does not exist
  if (file.exists(dataFile) == FALSE) {
      download.file(fileURL, destfile = dataFile)
    }
  
# uncompress data file if it has not been uncompressed
  if (file.exists(dir) == FALSE) {
    unzip(dataFile)
  }
  
## 1. Merges the training and the test sets to create one data set:
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
  X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

# combine data tables by rows
  x <- rbind(x_train, X_test)
  y <- rbind(y_train, y_test)
  s <- rbind(subject_train, subject_test)
## 2. Extracts only the measurements on the mean and standard deviation for each measurement
# read features
  features <- read.table("./UCI HAR Dataset/features.txt")
# give names to features column
  names(features) <- c('feat_id', 'feat_name')
# search for matches to argument mean or standard deviation within each element of the character vector
  index_features <- grep("-mean\\(\\)|-std\\(\\)", features$feat_name) 
  x <- x[, index_features] 
# replace matches of string features 
  names(x) <- gsub("\\(|\\)", "", (features[index_features, 2]))

## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names
# read activity labels
  activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
# give names to activities column
  names(activities) <- c('act_id', 'act_name')
  y[, 1] = activities[y[, 1], 2]
  names(y) <- "Activity"
  names(s) <- "Subject"
# combine data table by columns
  tidyDataSet <- cbind(s, y, x)
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
  p <- tidyDataSet[, 3:dim(tidyDataSet)[2]] 
  tidyDataAVGSet <- aggregate(p,list(tidyDataSet$Subject, tidyDataSet$Activity), mean)
# activity and columns 
  names(tidyDataAVGSet)[1] <- "Subject"
  names(tidyDataAVGSet)[2] <- "Activity"
# write files
  write.table(tidyDataSet, tidyDataFile)
  write.table(tidyDataAVGSet, tidyDataFileAVGtxt)
