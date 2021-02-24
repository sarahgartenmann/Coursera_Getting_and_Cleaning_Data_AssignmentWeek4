### Coursera "Getting and Cleaning Data" Course, Week 4 Assignment
### Author: Sarah Gartenmann
### Date: February, 2021

### Description of Week 4 Assignment:

# This R Script is for the peer-graded assignment of the "Getting and Cleaning 
# Data" course from the Data Science Specialization offered by the John Hopkins 
# University through Coursera. As stated by the instructors of the course, "The 
# purpose of the assignment is to demonstrate your ability to collect, work with, 
# and clean a data set. The goal is to prepare tidy data that can be used for 
# later analysis". 

################################################################################
# load required packages 
library(tidyverse)
library(stringr)
library(plyr)

################################################################################
# setting the working directory and creating a new directory for the file
setwd("C:/Users/gartens1/Downloads")
  if(!file.exists("./coursera_getcleandata_assignment")) {
    dir.create("./coursera_getcleandata_assignment")
    }

# downloading the file (url)
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./coursera_getcleandata_assignment/dataset.zip")

# unzipping the zip file
unzip(zipfile = "./coursera_getcleandata_assignment/dataset.zip", 
      exdir = "./coursera_getcleandata_assignment")

################################################################################
# Assignment Part 1: merge the training and test set to create one data set

  # read in features.txt file using read.table() and change the variable type to 
  # character
    features <- read.table("./coursera_getcleandata_assignment/UCI HAR Dataset/features.txt")
    features_names <- as.character(features$V2)

  # read in the 3 test datasets (subject_test.txt, X_test.txt, and y_test.txt)
  # using read.table() and define the column names using rename() and 
  # rename_all()
    subject_test <- read.table("./coursera_getcleandata_assignment/UCI HAR Dataset/test/subject_test.txt") %>%
      rename(c("V1" = "subject_ID"))
    
    x_test <- read.table("./coursera_getcleandata_assignment/UCI HAR Dataset/test/X_test.txt") %>%
      rename_all(~features_names)
    
    y_test <- read.table("./coursera_getcleandata_assignment/UCI HAR Dataset/test/y_test.txt") %>%
      rename(c("V1" = "activity_ID"))
  
    # read in the 3 training datasets (X_train.txt, y_train.txt, and subject_train)
    # using read.table() and define the column names using rename() and rename_all()
    subject_train <- read.table("./coursera_getcleandata_assignment/UCI HAR Dataset/train/subject_train.txt") %>%
      rename(c("V1" = "subject_ID"))
  
    x_train <- read.table("./coursera_getcleandata_assignment/UCI HAR Dataset/train/X_train.txt") %>%
      rename_all(~features_names)
  
    y_train <- read.table("./coursera_getcleandata_assignment/UCI HAR Dataset/train/y_train.txt") %>%
      rename(c("V1" = "activity_ID"))
  
  # Merging
    # merging the test data sets together using cbind()  
    testmerged <- cbind(y_test, subject_test, x_test)
  
    # merging the train data sets together using cbind()  
    trainmerged <- cbind(y_train, subject_train, x_train)
    
    # merging testmerged and trainmerged data sets together using rbind()
    alldata <- rbind(testmerged, trainmerged)

################################################################################
# Assignment Part 2: extract only the measurements on the mean and standard 
# deviation for each measurement 

  # generate the vector names_subset with the terms "mean" and "std"  
  names_subset <- c("mean", "std")

  # use grepl to extract all columns containing the terms from the names_subset 
  # vector and save this as alldata_subset
  alldata_subset <- alldata[,grepl(names_subset, names(alldata))]

  # subset the columns activity_ID and activity_type from alldata and save it as 
  # ID_type_subset 
  ID_type_subset <- alldata[,1:2]

  # merge the two data sets together and save it as the object alldata_meanstd
  alldata_meanstd <- cbind(ID_type_subset, alldata_subset)

################################################################################
# Assignment Part 3: use descriptive activity names to name the activities in 
# the data set

    # read in the data for the activity lables and rename the columns to activity_ID 
    # and activity_name
    activitylabs <- read.table("./coursera_getcleandata_assignment/UCI HAR Dataset/activity_labels.txt") %>%
      rename(c("V1" = "activity_ID",
               "V2" = "activity_name"))
  
    # merge alldata_meanstd and activity_labs together by the column "activity_ID" 
    # on all columns from the first data set (i.e. x) 
    alldata_meanstd_actnames <- merge(x = alldata_meanstd, 
                                      y = activitylabs, 
                                      by = "activity_ID", 
                                      all.x = TRUE)
    
    # reorganise the columns so that the activity_name column is placed in 2nd 
    # (and not last) position 
    alldata_meanstd_actnames <- alldata_meanstd_actnames[, c(1, 49, 2:48)]
      
################################################################################
# Assignment Part 4: appropriately label the data set with descriptive variable 
# names

  # subset the column names from the original all_data 
  columnnames <- colnames(alldata_meanstd_actnames)
  
  # use str_replace_all to replace all abbreviations and include underscores 
  # in between all terms 
  columnnames2 <- columnnames %>%
    str_replace_all(c("Acc" = "Accelerometer_", 
                      "Gyro" = "Gyroscope_", 
                      "Mag" =  "Magnitude_",
                      "Freq" = "Frequency", 
                      "mean()" = "Mean",
                      "std" = "Standard_Deviation",
                      "BodyBody" = "Body_",
                      "Body" = "Body_",
                      "Jerk" = "Jerk_",
                      "Gravity" = "Gravity_",
                      "X" = "_X",
                      "Y" = "_Y",
                      "Z" = "_Z",
                      "MeanFrequency" = "Mean_Frequency", 
                      "Body__" = "Body_",
                      "activity_ID" = "Activity_ID",
                      "activity_name" = "Activity_Name",
                      "subject_ID" = "Subject_ID"))
      
  # change all "t"s and "f"s to "Time_Domain" and "Frequency_Domain", respectively,
  # and get rid of "()"
  columnnames2 <- columnnames2 %>%
    str_replace_all(c("^t" = "Time_Domain_", 
                        "^f" = "Frequency_Domain_",
                        "[\\(\\)-]" = ""))
  # Take a look to see if str_replace_all() worked like it should have 
  View(columnnames2)
                        
  # Use these new labels as the column names in alldata_meanstd_actnames dataset
  colnames(alldata_meanstd_actnames) <- columnnames2
      
################################################################################
# Assignment Part 5: from the data set in part 4, create a second, independent 
# tidy dataset with the average of each variable for each activity & each subject 

  # use the group_by() function to group the dataset by subject and activity
  alldata_tidy <- alldata_meanstd_actnames %>%
    group_by(Subject_ID, Activity_Name) %>%
    # calculate the mean of each column using summarise_all()
    summarise_all(.funs=mean) %>%
    ungroup() %>%
    # order the data by subject and activity_ID  
    arrange(Subject_ID, Activity_ID)
    
  # Create the output file "tidydata.txt" using wirte.table() 
  write.table(alldata_tidy, 
              "./coursera_getcleandata_assignment/tidydata.txt", 
              row.names = FALSE,
              col.names = TRUE,
              quote = FALSE)
      