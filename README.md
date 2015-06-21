# Getting and Cleaning Data Course Projec

## Samsung Analysis

This script downloads and clean the data collected from the accelerometers from the Samsung Galaxy S smartphone.

In the first place it downloads and merges the data sets containg:
1) Information of the accelerometers and gyroscopes
2) The regiter of each activity 
3) The identifier of each subject.

Second, it selects only the  variables reporting the means and std.

Finally, it tidies the data to report the average of each variable for each activity and subject.

This repository contains the final tidy table "tidy.txt" the sctipt "run_analysis.r" and the codebook of the variables "codebook.md"

