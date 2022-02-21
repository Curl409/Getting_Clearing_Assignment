---
title: "CodeBook.md"
author: ""
date: "2022/2/20"
output: html_document
---

The script "run_analysis.R" executes following.

### Read data in R

Read data X_test, y_test, subject_test, X_train, y_train, subject_train,
features, activity_labels using "read.table()" function,
and stored into variable same name respectively.

### 1. Merges the training and the test sets to create one data set.

X_test and X_train are seems actual data sets.
So I combined X_test and X_train using "rbind()" function
and stored "Data_all".

The dimension of "Data_all"" is (10299   561)
There are 10299 observations and 561 variables

### 3. Uses descriptive activity names to name the activities in the data set

Before step2, I added activity names to "Data_all".
Activities number are stored in "Data_all$activities".
Descriptive activity names are stored in "activity_label".

Merge "Data_all" with "activity_label" using merge().

### 4. Appropriately labels the data set with descriptive variable names. 

For step 2, I added descriptive variable names to "Data_all" using names() function. 
Descriptive variable names are stored in 2nd column of "features".
Last 2 colomns are named "subject" and activities".

### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

"measurements on the mean and standard deviation" has a variable name 
such as "tBodyAcc-mean()-X" or "tBodyAcc-std()-X"

I extracted column names contain "mean" or "std" using grep() function
from "features.
There are 79 columns matching criteria.

I extracted above columns and "activities", "subject" column from "Data_all",
and stored "Data_meadstd".

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Group by "activity" and "subject" using dplyr.
Calculate using "summarise_each" function.
Save result to "./result.txt".
