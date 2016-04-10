# Helper function. Download file provided in fileUrl parameter in cached fashion. 
# If file was already downloaded (detected by existence of file provided as destFile parameter) download is skipped
# this is to optimize download of huge data-set used in this project
# after download file is unzipped
downloadAndUnzipWithCaching <- function(fileUrl, destFile, mode = "wb", forceDownloadEvenIfCached = FALSE) {
  
  # check if data directory exists in wdir
  if (!file.exists("./UCI HAR Dataset")) {
    
    # if not, download packed data  - only if does not exist or forced download parameter is on
    if (!file.exists(destFile) || forceDownloadEvenIfCached) {
      download.file(fileUrl, destfile=destFile, mode = mode)
    }
    
    unzip(zipfile = destFile)
  }
}

run_analysis <- function() {
  
  library(dplyr)
  # Step 0: Download and unpack data-set if it is not already cached
  downloadAndUnzipWithCaching("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./packed.zip")
  
  # Step 1: Merges the training and the test sets to create one data set.

  # load feature names (all columns in train data set are named like that)
  feature_names <- read.table("./UCI HAR Dataset/features.txt")
  
  # load names of activities (1-6)
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
  
  # merge two tables for train data (first train, then test)
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
  x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
  x_total <- rbind(x_train,x_test)

  # Set appropriate names for each column 
  names(x_total) <- feature_names$V2
  
  # Step 2: Extracts only the measurements on the mean and standard deviation for each measurement
  # these are identified if column contains mean() or std() in the column name
  # but first we need to remove duplicated column names
  x_total <- x_total[,!duplicated(colnames(x_total))]
  x_total_selected <- select(x_total, matches("*mean()*|*std()*"))
  
  # merge two tables of activity data (first train, then test)
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
  y_total <- rbind(y_train, y_test)
  
  # Step 3: Uses descriptive activity names to name the activities in the data set
  # merge ids and activity names tables to get descriptrive ID's of activity
  # please note that 'merge' does not keep order of the X nor Y - so we do not use merge but we use
  # join instead 
  total_activity_labels <- left_join(x = y_total, y = activity_labels,by = "V1")
  
  # merge descriptive activity names with slected mean and std columns of total data set
  total_merged <- cbind(total_activity_labels$V2, x_total_selected)
  
  # Step 4: Appropriately labels the data set with descriptive variable names.  
  names(total_merged) <- c("Activity", names(x_total_selected))
  
  # for debug purposes, write resultant table as output1.txt
  write.table(x = total_merged, file = "./output1.txt", row.names = FALSE)
  
  # STEP 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  # read identification of subjects from both test and train data sets and merge these
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
  subject_total <- rbind(subject_train,subject_test)
  
  # bind subjects ids to allow agregate on subject
  second <- cbind(subject_total, total_merged)
  names(second) <- c("Subject", names(total_merged))
  
  # group by subject and then activity
  groupped <- group_by(second, Subject, Activity)
  
  # calculate averages for groupped data
  summarized <- summarise_each(groupped, funs(mean))
  
  # for debug purposes, write resultant table as output2.txt
  write.table(x = summarized, file = "./output2.txt", row.names = FALSE)
  
}