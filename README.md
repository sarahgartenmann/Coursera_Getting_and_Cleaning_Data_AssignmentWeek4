# Coursera_Getting_and_Cleaning_Data_AssignmentWeek4
## About this repository

This repository is for the peer-graded assignment of the "Getting and Cleaning Data" course from the Data Science Specialization offered by the John Hopkins University through Coursera. 

The course is taught by the following instructors: 
  - Jeff Leek, PhD
  - Roger D. Peng, PhD
  - Brian Caffo, PhD

As stated by the course instructors:
> The purpose of the assignment is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

#### Review Criteria:
> 1. The submitted data set is tidy. 
> 2. The Github repo contains the required scripts.
> 3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
> 4. The README that explains the analysis files is clear and understandable.
> 5. The work submitted for this project is the work of the student who submitted it.

## This repository includes the following files: 

#### CodeBook.md
The CodeBook.md file contains all of the information describing the data, the variables, and any transformations and work that was performed on the original dataset to generate the final tidy data set found in the tidydata.txt file. 

#### run_analysis.R
The run_analysis.R file contains all of the R code written to generate the tidydata.txt file. This process is broken down into the following five steps: 

> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
> 3. Uses descriptive activity names to name the activities in the data set
> 4. Appropriately labels the data set with descriptive variable names. 
> 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

#### tidydata.txt
The tidydata.txt file is the final output. 

#### AssignmentDescription.md
Additionally, the file AssignmentDescription.md provides the background information and the tasks for this assignment (taken from the Coursera course website).  
