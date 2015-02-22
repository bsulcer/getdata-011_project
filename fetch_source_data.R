# download and unpack the dataset if necessary
if (!file.exists('./UCI HAR Dataset')) {
    download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
                  destfile='dataset.zip',
                  method='curl')
    unzip('./dataset.zip')
    unlink('./dataset.zip')
}