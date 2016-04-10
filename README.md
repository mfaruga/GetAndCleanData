# GetAndCleanData
Coursera Get and Clean Data Project by Michal Faruga

# Data that script operates on
Script assumes that UCI HAR Dataset is available in working directory
If this data set is not there (identified by existence of directory) downloads it from original location and unpacks to working directory
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Note: zip file is cached in packed.zip file in working directory

# Running script and output
Script can be run by executing run_analysis() function without parameters
As first step, script checks existence of target data set and prepare it if needed (as defined in previous point)
Script provides following outputs
1. File output1.txt in working directory that is a result of analysis up to step 4 described below
2. File output2.txt in working directory that is a result of analysis up to of step 5 described below
3. Function itself returns result of analysis up to of step 5 described below

# Data transformations
Step 1: 
Test and Training measurements data sets were merged (i.e. rows of test were added to train data set)
Names of columns were set based on features.txt file

Step 2:
As there were duplicated column names, these were removed
From resulting columns, only columns that has mean() or std() as part of the name were slected

Step 3:
Activity data set(s) (contained in y_train.txt, y_test.txt) were loaded and merged in the same order as this was done for measurements data set in step 1
Resulting table was merged with activity labels (V2 column from activity_labels.txt) to have descriptive names of activities instead of just activity ids. 
Note: standard merge function was not used as it does not preserve order of rows!

Step 4:
As a next step, resulting activities were merged with table created in step 2 to create single table with descriptive activity name and measurements.
Note: resultant table is written to output1.txt file

Step 5:
Subject dat set(s) (contained in subject_train.txt and subject_text.txt) were loaded and merged in the same order as this was done for measuremens data set in step 1
Resulting activities were merged with table created in step 4 to create single table with subject ids, descriptive activity name and measurements.
This table was groupped by Subject and Activity and then summarized through all measurements columns with mean function to have measurements per subject/activity.
Note: resultant table is written to output2.txt file

# Definition of variables
Columns in data set (output2.txt)
1. Subject: identification of 
2. Activity: 
3. All columns defining mean and std from data set as described in "./UCI HAR Dataset\features_info.txt" 
