# Peer-graded-Assignment-Getting-and-Cleaning-Data
Peer-graded Assignment: Getting and Cleaning Data Course Project

# Pre-processing
1. Script reads 3 test and 3 train datasets and also read reads features file which includes descriptive variable names
2. Rename of test and train dataset variables to descriptive ones (User ID, Activity Type)
3. Binding test and train data separately into 2 dataframes

# Creation of selection vector
4. Dataset features includes description so we can create a filter of mean/std with help of this dataset
5. Script creates a filter using grepl and then script gets subset of features dataframe
6. Then I use paste function to combine V and indexes which relate to variable discription
7. As a result I have dataframe which consist of 2 vectors - actual variable names (V1-V(n)) and discriptions.

# Data processing
8. Binding test and train sets together
9. Select vars in which mean or std count
10. Rename of vars in descriptive way
11. Rename of activity types

# Group by and summarize
12. Group by DatasetType,ActivityType,UserID and summarize mean with help of gplyr
