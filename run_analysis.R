# Step 1: Merge datasets

if (! exists("X")) {
    train_tmp <- read.table("train/X_train.txt")
    test_tmp  <- read.table("test/X_test.txt")
    X <- rbind(train_tmp, test_tmp)
}

if (! exists("S")) {
    train_tmp <- read.table("train/subject_train.txt")
    test_tmp  <- read.table("test/subject_test.txt")
    S <- rbind(train_tmp, test_tmp)
    names(S) <- "subject"
}

if (! exists("Y")) {
    train_tmp <- read.table("train/y_train.txt")
    test_tmp  <- read.table("test/y_test.txt")
    Y <- rbind(train_tmp, test_tmp)
    names(Y) <- "activity"
}

# Step 2: Select mean/standard deviation

features <- read.table("features.txt")
indices <- grep("-mean\\(|-std\\(", features[, 2], perl=TRUE)
X.meanstd <- X[, indices]
names(X.meanstd) <- features[indices, 2]
names(X.meanstd) <- gsub("\\(", "", names(X.meanstd))
names(X.meanstd) <- gsub("\\)", "", names(X.meanstd))
names(X.meanstd) <- chartr("-", "_", names(X.meanstd))
names(X.meanstd) <- tolower(names(X.meanstd))

# Step 3-4: Label activities appropriately using activity_labels.txt

activities <- read.table("activity_labels.txt")
activities[, 2] = tolower(activities[, 2])
Y$activity <- factor(Y$activity, levels=activities[,1], labels=activities[,2])

cleaned <- cbind(S, Y, X.meanstd)
write.table(cleaned, "merged_clean_data.txt")

# Step 5

library(dplyr)

# ;-)
cleaned_leaned_and_meaned <- cleaned %>% group_by(subject,activity) %>% summarise_each(funs(mean))

# write result tidy dataset
write.table(cleaned_leaned_and_meaned, file="tidy_data.txt", row.names=FALSE)
