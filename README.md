# Course project for "Getting and Cleaning Data"

This repository contains a R script that will create a derivative data set
based on the Human Activity Recognition Using Smartphones Dataset.  The data
set is created by first combining the test and training subsets.  From this
combined data set, only feature variables for the mean and standard deviation
of each measurement are selected.  The activity variable is then transformed
into a factor with descriptive activity labels.  Finally, the data is
summarized to means for each feature variable grouped by subject and activity.

# Running the script

The script that creates this dataset can be found in `run_analysis.R`.  This
script assumes that the source data set has been unpacked into a directory
named `UCI HAR Dataset` in the current working directory.  An additional
script in `fetch_source_data.R` can download and unpack the source data set
if necessary.  Running `run_analysis.R` will output the derived data set in
a file named `activity_summary.txt` in the current working directory.

# Description of derived data set

Each row represents the means of feature measurements for a given subject
and activity.  The first two variables on each row identify the summary group.

- subject: Identifies the subject who performed the activity.  It is an integer
  in the range 1-30.
- activity: Identifies the type of activity associated with the feature
  measurements on this row.  It is a factor with six levels: `WALKING`,
    `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`,
    and `LAYING`.

The remaining columns are means grouped by the subject and activity variables
of the feature measurements as documented in the files `feature_info.txt` in
the source data set.  Only the variables for measurement means and standard
deviations are summarized in the derived data set.  Feature variable names were
derived from the feature names by removing parenthesis characters and
replacing dashes with periods.
