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
4. About the raw data
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
The three "test" and the three "train" files were merged using the `cbind()` command to generate the dataframes "testmerged" and "trainmerged", respectively. These two dataframes were then merged together using the command `rbind()` to generate the dataframe "alldata". This table below lists these objects, as well as the number of observations and variables each contains. 

| R Object Name | No. Observations | No. Variables |
| ------------- | ---------------- | ------------- |
| testmerged    | 2947             | 563           | 
| trainmerged   | 7352             | 563           | 
| alldata       | 10299            | 563           |

 
### Extraction of mean and standard deviation for each measurement
To extract only the column names 

### Naming activities with descriptive activity names 
### Adding appropriate labels
### Generating a second, indepedent dataset containing average of each variable for each activity performed by each subject 
### Writing data to text file  

## 3. About the raw data 

### Description
A description of the "Human Activity Recognition Using Smartphones Data Set" can be found here: 
> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The raw data can be downloaded via this link:
> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

### Citation
> Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.
