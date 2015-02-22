# read the feature and label descriptions
features <- read.table('./UCI HAR Dataset/features.txt',
                       col.names=c('index', 'feature'),
                       colClasses=c('integer', 'character'))

activities <- read.table('./UCI HAR Dataset/activity_labels.txt',
                         col.names=c('value', 'label'),
                         colClasses=c('integer', 'character'))

# create col.names and colClasses vectors that will select only the features
# of interest (mean and std) and apply descriptive names
selected.features <-grepl('-mean()', features$feature, fixed=TRUE) |
    grepl('-std()', features$feature, fixed=TRUE)
features.col.names <-ifelse(selected.features,
                            sub('()', '', features$feature, fixed=TRUE),
                            c(''))
features.colClasses <- ifelse(selected.features, 'numeric', c('NULL'))

# convenience function to read and assemble a single subset
readDataset <- function(name) {
    # read the subjects table for the subset
    subjectsFile <-
        sprintf('./UCI HAR Dataset/%s/subject_%s.txt', name, name)
    subjects <- read.table(subjectsFile, col.names=c('subject'),
                           colClasses=c('integer'))
    
    # read the feature table for the subset
    xFile <- sprintf('./UCI HAR Dataset/%s/X_%s.txt', name, name)
    X <- read.table(xFile, col.names=features.col.names,
                    colClasses=features.colClasses)
    
    # read the label table for the subset
    yFile <- sprintf('./UCI HAR Dataset/%s/y_%s.txt', name, name)
    y <- read.table(yFile, col.names=c('activity'), colClasses=c('integer'))
    
    # bind the parts read into a single table
    cbind(subjects, y, X)
}

# read and combine the test and training subsets
test <- readDataset('test')
train <- readDataset('train')
data <- rbind(test, train)

# convert the activity variable into a properly-labeled factor
data$activity <- factor(data$activity, levels=activities$value,
                      labels=activities$label)

# create new data set consiting of means for each feature grouped by
# subject and activity
library(dplyr)
newdata <- summarise_each(group_by(data, subject, activity), funs(mean))
write.table(newdata, './feature_means.txt', row.names=FALSE)