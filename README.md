# Getting and Cleaning Data Course Project

This repository contains my work for the course project for the Coursera course "Getting and Cleaning data"

The Raw Data:
The features are unlabeled and they are in the x_test.txt, where the labels are in y_test.txt file. The test subjects are in the subject_test.txt file. Same goes for the training sets

The script:

My script, run_analysis.R, will merge the test and training sets. Necessary is therefore that the UCI HAR Dataset is present in the folder "UCI HAR Dataset".

After merging, labels are added and only columns that relate to mean and standard deviation stay. 

The script will also create a tidy data set containing the means of all the columns per subject activity.
