run_analysis <- function() {
    
    # Read data in R
    
    X_test <- read.table("data/UCI HAR Dataset/test/X_test.txt")
    y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt")
    subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt")

    X_train <- read.table("data/UCI HAR Dataset/train/X_train.txt")
    y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt")
    subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt")

    features <- read.table("data/UCI HAR Dataset/features.txt")

    activity_label <- read.table("data/UCI HAR Dataset/activity_labels.txt")

    # Merges the training and the test sets to create one data set.
    
    X_all <- rbind(X_test, X_train)
    y_all <- rbind(y_test, y_train)
    subject_all <- rbind(subject_test, subject_train)
    
    # Uses descriptive activity names to name the activities in the data set
    activities <- merge(y_all, activity_label, by.x="V1", by="V1", sort=FALSE)
    X_all <- cbind(X_all, activities$V2, subject_all$V1)
    
    # Appropriately labels the data set with descriptive variable names. 
    names(X_all) <- c(features$V2, "activities", "subject")
    
    # Extracts only the measurements on the mean and standard deviation for each measurement. 
    meanstdcol <- grep("mean|std", features$V2)
    meanstdcolname <- features[meanstdcol, 2]
    
    X_meanstd <- X_all[, c(meanstdcolname, "activities", "subject")]
    
    
    library(dplyr)
    X_meanstd_grouped <- group_by(X_meanstd, activities, subject)
    result <- summarise_each(X_meanstd_grouped, funs(mean), everything())
    write.csv(result, "./result.csv")
}