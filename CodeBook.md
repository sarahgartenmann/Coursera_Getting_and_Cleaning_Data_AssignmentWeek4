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
- Generating a second, independent tidy dataset containing average of each variable for each activity performed by each subject 
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
Using `download.file()`, the zipfile containing the raw data was downloaded and directly saved in the appropriate directory (working directory). The following link was used to download the zipfile:  
"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

Using `unzip()`, the zipfile was unzipped and its contents were directly saved in the appropriate directory (working directory)

### Merging of raw data files
**1. Reading in the data**

Using `read.table()`, the relevant files were read into R. The table below lists the original file name, the R object name that each was assigned to upon reading it into R, as well as the number of observations and variables each contains. 

| File name           | R Object Name   | No. Observations | No. Variables | Description | 
| ------------------- | --------------- | ---------------- | ------------- | --------------
| "features.txt"      | features        | 561              | 2             | List of all features |
| "subject_test.txt"  | subject_test    | 2947             | 1             | Each row identifies the subject who performed the activity for each window sample. Its range is from 2 to 24. |
| "X_test.txt"        | x_test          | 2947             | 561           | Test set |
| "y_test.txt"        | y_test          | 2947             | 1             | Test labels |
| "subject_train.txt" | subject_train   | 7352             | 1             | Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. |
| "X_train.txt"       | x_test          | 7352             | 561           | Training set |
| "y_train.txt"       | y_train         | 7352             | 1             | Training labels |

Using `rename()` and `rename_all()`, the columns of the six test and train files were appropriately renamed. 

**2. Merging the data**
The three "test" and the three "train" files were merged using `cbind()` to generate the dataframes "testmerged" and "trainmerged", respectively. These two dataframes were then merged together using `rbind()` to generate the dataframe "alldata". This table below lists these dataframes, as well as the number of observations and variables each contains. 

| R Object Name | No. Observations | No. Variables |
| ------------- | ---------------- | ------------- |
| testmerged    | 2947             | 563           | 
| trainmerged   | 7352             | 563           | 
| alldata       | 10299            | 563           |

 
### Extraction of mean and standard deviation for each measurement
Using `grepl()`, the dataframe "alldata" was subsetted to include only columns which had the terms "mean" and "std" in their name. A vector named "names_subset" containing the terms "mean" and "std" was created to faciliate this subsetting step. The resulting dataframe was called "alldata_subset". A second subsetted dataframe was generated from the first and second columns of the "alldata" dataframe called "ID_type_subset". These columns contain the "activity_ID" and the "activity_type". Using `cbind()`, "ID_type_subset" and "alldata_subset" were merged to generate "alldata_meanstd", the dataframe containing only the mean measurements and the standard deviation of each measurement. This table below lists these objects, as well as the number of observations and variables each contains. 

| R Object Name   | No. Observations | No. Variables |
| --------------- | ---------------- | ------------- |
| alldata_subset  | 10299            | 46            | 
| ID_type_subset  | 10299            | 2             | 
| alldata_meanstd | 10299            | 48            |

### Naming activities with descriptive activity names 

The data for the activity labels was read in using `read.table()` and the columns were appropriately renamed using `rename()` to "activity_ID" and "activity_name". The dataframe "alldata_meanstd" was merged with the "activitylabs" by the shared column "activity_ID" the using `merge()`. This resulted in the dataframe "alldata_meanstd_actnames". The columns of this dataframe were then rearranged so that the column "activity_name" was placed in second position. This table below lists these objects, as well as the number of observations and variables each contains. 

| R Object Name            | No. Observations | No. Variables |
| ------------------------ | ---------------- | ------------- |
| acivitylabs              | 6                | 2             | 
| alldata_meanstd_actnames | 10299            | 49            |

### Adding appropriate labels

The vector "columnnames" was created using `colnames()` on the dataframe "alldata_meanstd_actnames" in order to extract all all column names. Using `str_replace_all()`, a new vector called "columnnames2" was created based off of the contents of the vector "columnnames". The following table summarises the changes performed by `str_replace_all()`: 
 
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

Using `group_by()`, the "alldata_meanstd_actnames" dataframe was grouped first by the variable "Subject_ID" and then by the variable "Activity_Name". Using `summarise_all()`, the mean of each variable for each activity performed by each subject was calculated. After ungrouping the dataframe using `ungroup()`, the rows were arranged by the variable "Subject_ID" and then by the variable "Activity_ID" using `arrange()`. The resulting dataframe was named "alldata_tidy", and the table below lists the number of observations and variables it contains. 

| R Object Name            | No. Observations | No. Variables |
| ------------------------ | ---------------- | ------------- |
| alldata_tidy             | 180              | 49            |

The definition of tidy data as stated on the cran.r-project.org website is as follows: 
1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.

(https://cran.r-project.org/web/packages/tidyr/vignettes/tidy-data.html, accessed 25.02.2021)

To this end, the datatable "alldata_tidy" was reorganised into the tidy format.

A vector "subID" containing the numbers 1 to 30, each repeated 276 times was created using `rep()` (there are 30 "Subject_ID"s, each of which performs 6 activities, and for each activity 46 measurements are taken; this means, there are 6x46 = 276 measurements for each "Subject_ID". Similarly, a vector "actID" containing the 6 "activity_name" terms from the "activitylabs" table, where each individual term was repeated 46 times, and the whole series was repeated 30 times, was created using `rep()` (there are 46 measurements for each of the 6 terms "Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", and "Laying" for each of the 30 subjects). The table below summaries the dimensions of these two vectors.

| R Object Name  | Dimensions |
| -------------- | ---------- | 
| subID          | [1:8280]   |
| actID          | [1:8280]   |

A vector "measurements" was created containing the names of the columns 4:49 from the "alldata_meanstd_actnames" dataframe using `colnames()`. This vector was repeated 180 times using `rep()` and converted to a dataframe using `as.data.frame()`. Subsequently, the vectors "subID" and "actID" and the dataframe "measurements" were merged together using `cbind()` to create the dataframe "tidy1", the columns of which were renamed using `rename()`; "subID", "actID" and "measurements" were renamed to "Subject_ID", "Activity_ID", and "Measurement_Type", respectively. The dataframe "alldata_tidy2" was created by transposing the dataframe "alldata_tidy" using `t()`. The first three rows of "alldata_tidy2" were then removed, before the entire dataframe was unlisted using `unlist()` to rearrange all measurement values into a single column. The table below summaries the dimensions of the dataframes.

| R Object Name  | No. Observations | No. Variables |
| -------------- | ---------------- | ------------- |
| measurements   | 8280             |1              |
| tidy1          | 8280             |3              |
| alldata_tidy2  | 8280             |1              | 

The final dataframe "finaldata_tidy" was created by merging the columns from the dataframes "tidy1" with "alldata_tidy2" together using `cbind()`. The table below summaries the dimensions of this final, tidy, dataframe.

| R Object Name  | No. Observations | No. Variables |
| -------------- | ---------------- | ------------- |
| finaldata_tidy | 8280             | 4             |

### Writing data to text file  

Using the command `write.table()`, the final tidy datatable "finaldata_tidy" was saved in the appropriate directory as a "txt" file. 

## 3. About the raw data 

### Description
A description of the "Human Activity Recognition Using Smartphones Data Set" can be found here: 
> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The raw data can be downloaded via this link:
> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

### Citation
> Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on  Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

