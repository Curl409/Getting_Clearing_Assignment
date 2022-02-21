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
    names(y_all) <- c("activities")
    subject_all <- rbind(subject_test, subject_train)
    names(subject_all) <- c("subject")
    
    Data_all <- cbind(X_all, subject_all, y_all)
    
    # Uses descriptive activity names to name the activities in the data set
    Data_all <- merge(Data_all, activity_label, by.x="activities", by.y="V1", sort=F)
    
    # Appropriately labels the data set with descriptive variable names. 
    names(Data_all) <- c("act", features$V2, "subject", "activities")
    
    # Extracts only the measurements on the mean and standard deviation for each measurement. 
    meanstdcol <- grep("mean|std", features$V2)
    meanstdcolname <- features[meanstdcol, 2]
    
    Data_meanstd <- Data_all[, c(meanstdcolname, "activities", "subject")]
    
    library(dplyr)
    Data_meanstd_grouped <- group_by(Data_meanstd, activities, subject)
    result <- summarise_each(Data_meanstd_grouped, funs(mean), everything())
    write.table(result, "./result.txt")
}