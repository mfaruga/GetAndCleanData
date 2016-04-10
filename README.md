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


# Definition of variables
Columns in data set (output2.txt)
1. Subject: identification of 
2. Activity: 
3. All columns defining mean and std from data set as described in "./UCI HAR Dataset\features_info.txt" 
