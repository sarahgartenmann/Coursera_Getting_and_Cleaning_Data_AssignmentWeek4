# Code Book for the "tidydata" datatable

## Table of Contents

1. Variable Description for the "tidydata" datatable

2. Steps taken to generate the "tidydata" datatable
- R packages used
- Loading raw data into R
- Merging of raw data files
- Extraction of mean and standard deviation for each measurement
- Naming activities with descriptive activity names 
- Adding appropriate labels
- Generating a second, indepedent dataset containing average of each variable for each activity performed by each subject 
- Writing data to text file 
 
3. About the raw data
- Description
- Citation


## 1. Variable Description for the "tidydata" datatable

## 2. Steps taken to generate the "tidydata" datatable

### R Packages used 
The following R packages were used for this assignment: 

**"tidyverse", package version 1.3.0**

Wickham et al., (2019). Welcome to the
  tidyverse. Journal of Open Source
  Software, 4(43), 1686,
  https://doi.org/10.21105/joss.01686
  
**"stringr", package version 1.4.0**

Hadley Wickham (2019). stringr:
  Simple, Consistent Wrappers for Common
  String Operations. R package version
  1.4.0.
  https://CRAN.R-project.org/package=stringr

**"plyr", package version 1.8.6**

Hadley Wickham, Romain François,
  Lionel Henry and Kirill Müller (2019).
  dplyr: A Grammar of Data Manipulation.
  R package version 0.8.3.
  https://CRAN.R-project.org/package=dplyr


### Loading raw data into R
Using the `download.file()` command in R, the zipfile containing the raw data was downloaded and directly saved in the appropriate directory (working directory). The following link was used to download the zipfile:  
"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

Using the `unzip()` command in R, the zipfile was unzipped and its contents were directly saved in the appropriate directory (working directory)

### Merging of raw data files
**1. Reading in the data**

Using the `read.table()` command, the relevant files were read into R. The table below lists the original file name, the R object name that each was assigned to upon reading it into R, as well as the number of observations and variables each contains. 

| File name           | R Object Name   | No. Observations | No. Variables |
| ------------------- | --------------- | ---------------- | ------------- |
| "features.txt"      | features        | 561              | 2             | 
| "subject_test.txt"  | subject_test    | 2947             | 1             | 
| "X_test.txt"        | x_test          | 2947             | 561           | 
| "y_test.txt"        | y_test          | 2947             | 1             | 
| "subject_train.txt" | subject_train   | 7352             | 1             | 
| "X_train.txt"       | x_test          | 7352             | 561           | 
| "y_train.txt"       | y_train         | 7352             | 1             | 

Using the `rename()` and `rename_all()` commands, the columns of the six test and train files were appropriately renamed 

**2. Merging the data**
The three "test" and the three "train" files were merged using the `cbind()` command to generate the dataframes "testmerged" and "trainmerged", respectively. These two dataframes were then merged together using the command `rbind()` to generate the dataframe "alldata". This table below lists these dataframes, as well as the number of observations and variables each contains. 

| R Object Name | No. Observations | No. Variables |
| ------------- | ---------------- | ------------- |
| testmerged    | 2947             | 563           | 
| trainmerged   | 7352             | 563           | 
| alldata       | 10299            | 563           |

 
### Extraction of mean and standard deviation for each measurement
Using the 'grepl()' command, the dataframe "alldata" was subsetted to include only columns which had the terms "mean" and "std" in their name. A vector named "names_subset" containing the terms "mean" and "std" was created to faciliate this subsetting step. The resulting dataframe was called "alldata_subset". 

A second subsetted dataframe was generated from the first and second columns of the "alldata" dataframe called "ID_type_subset". These columns contain the "activity_ID" and the "activity_type". 

Using the command 'cbind()', "ID_type_subset" and "alldata_subset" were merged to generate "alldata_meanstd", the dataframe containing only the mean measurements and the standard deviation of each measurement. 

This table below lists these objects, as well as the number of observations and variables each contains. 

| R Object Name   | No. Observations | No. Variables |
| --------------- | ---------------- | ------------- |
| alldata_subset  | 10299            | 46            | 
| ID_type_subset  | 10299            | 2             | 
| alldata_meanstd | 10299            | 48            |

### Naming activities with descriptive activity names 

The data for the activity labels was read in using the 'read.table()' command and the columns were appropriately renamed using the 'rename()' command to "activity_ID" and "activity_name".

The dataframe "alldata_meanstd" was merged with the "activitylabs" by the shared column "activity_ID" the using the 'merge()' command. This resulted in the dataframe "alldata_meanstd_actnames"

The columns of this dataframe were then rearranged so that the column "activity_name" was placed in second position.

This table below lists these objects, as well as the number of observations and variables each contains. 

| R Object Name            | No. Observations | No. Variables |
| ------------------------ | ---------------- | ------------- |
| acivitylabs              | 6                | 2             | 
| alldata_meanstd_actnames | 10299            | 49            |

### Adding appropriate labels

The vector "columnnames" was created using the 'colnames()' function on the dataframe "alldata_meanstd_actnames" in order to extract all all column names. 

Using the 'str_replace_all()' command, a new vector called "columnnames2" was created based off of the contents of the vector "columnnames". The following table summarises the changes performed by 'str_replace_all': 
 
| Pattern     | Replacement           |
| ----------- | --------------------- |
| "Acc"       | "Accelerometer_"      |
| "Gyro"      | "Gyroscope_"          | 
| "Mag"       | "Magnitude_"          |
| "Freq"      | "Frequency"           | 
| "mean()"    | "Mean"                |
| "std"       | "Standard_Deviation"  |
| "BodyBody"  | "Body_"               |
| "Body"      | "Body_"               |
| "Jerk"      | "Jerk_"               |
| "Gravity"   | "Gravity_"            |
| "X"         | "_X"                  |
| "Y"         | "_Y"                  |
| "Z"          | "_Z"                  |
| "MeanFrequency" | "Mean_Frequency"  |                  
| "Body__"       | "Body_"            |
| "activity_ID" | "Activity_ID"|
| "activity_name" | "Activity_Name"|
| "subject_ID" | "Subject_ID" |
| "^t" | "Time_Domain_"| 
| "^f" | "Frequency_Domain_" |
| "[\\(\\)-]" | "" |

The vector "columnnames2" was then used to replace the original column names in the dataframe "alldata_meanstd_actnames". 

### Generating a second, independent tidy dataset containing average of each variable for each activity performed by each subject 

ADD DESCRIPTION!

### Writing data to text file  

Using the command 'write.table()', the final tidy datatable "alldata_tidy" was saved in the appropriate directory as a "txt" file. 

## 3. About the raw data 

### Description
A description of the "Human Activity Recognition Using Smartphones Data Set" can be found here: 
> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The raw data can be downloaded via this link:
> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

### Citation
> Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.
