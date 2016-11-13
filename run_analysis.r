
#reading information, so train results, train label and train subject

train = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
train[,562] = read.csv("UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
train[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

# same for testing

test = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
test[,562] = read.csv("UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
test[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

#reading activity labels and features

actLab = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
feat = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)

# Tidying names
feat[,2] = gsub('-mean', 'Mean', feat[,2])
feat[,2] = gsub('-std', 'Std', feat[,2])
feat[,2] = gsub('[-()]', '', feat[,2])

#binding data 
all = rbind(training, testing)

# Get only mean and std
cols <- grep(".*Mean.*|.*Std.*", feat[,2])

#get features
feat <- feat[cols,]
# Now add the last two columns
cols <- c(cols, 562, 563)
# take these columns from all data
all <- all[,cols]

# Add the column names (features) to all
colnames(all) <- tolower(c(feat$V2,"Activity","Subject"))


#Replacing the activity number in the activity column by the actual label corresponding to that number
actNumber = 1
for (label in actLab$V2) {
        all$activity <- gsub(actNumber, label, all$activity)
        actNumber <- actNumber + 1
}

all$activity <- as.factor(all$activity)
all$subject <- as.factor(all$subject)

tidy = aggregate(all, by=list(activity = all$activity, subject=all$subject), mean)
# Remove the subject and activity column, since a mean of those has no use
tidy[,90] = NULL
tidy[,89] = NULL
write.table(tidy, "tidy.txt", sep="\t")
