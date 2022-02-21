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
and stored "X_all".

The dimension of "X_all"" is (10299   561)
There are 10299 observations and 561 variables

### 3. Uses descriptive activity names to name the activities in the data set

Before step2, I added activity names to "X_all".
Activities are stored in "y_test"" and "y_train".
Descriptive activity names are stored in "activity_label".

So, I combined y_test and y_train using rbind().
And merge with "activity_label" using merge() ***with "sort=FALSE"***,
and stored "activities".
There are 10299 observations and 2 variables, 
and 2nd column is descriptive activity name.

I added 2nd column to X_all using cbind() function.
Now, X_all has 10299 observations and 562 variables.

For future use, I added "subject" column to X_all
and named "subject".

### 4. Appropriately labels the data set with descriptive variable names. 

For step 2, I added descriptive variable names to "X_all" using name() function. 
Descriptive variable names are stored in 2nd column of "features".
Last colomn is named "activities"

### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

"measurements on the mean and standard deviation" has a variable name 
such as "tBodyAcc-mean()-X" or "tBodyAcc-std()-X"

I extracted column names contain "mean" or "std" using grep() function
from "features.
There are 79 columns matching criteria.

I extracted above columns and "activities", "subject" column from "X_all",
and stored "X_meadstd".

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Group by "activity" and "subject" using dplyr.
Calculate using "summarise_each" function.
Save result to "./result.csv".
