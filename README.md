# Getting_And_Cleaning_Data
Coursera Course Project
___
1. __Problem Statement___ :
___

To create a R script called run_analysis.R that does the following.

1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement.
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names.
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
___
2. __Location of Data__ :
___

+ In the Data folder and more about data can be seen in Data/README.md
___
3. __About run_analysis.R__ :
___

+ Required Libraries
`library("dplyr")`

+ Extracting names of features
```
features <- readLines("Data/features.txt")
#> head(features,3)
#[1] "1 tBodyAcc-mean()-X" "2 tBodyAcc-mean()-Y" "3 tBodyAcc-mean()-Z"
#parsing features
features <- sub("[0-9]+ ","",features)
```

+ Extracting names of Activity Labels similarly
```
#Step 3 : Uses descriptive activity names to name the activities in the data set
act_lab <- sub("[0-9]+ ","",readLines("Data/activity_labels.txt"))
```
+ Exrtracting traing data
```
train_features <- read.table("Data/train/X_train.txt")
names(train_features) <- features
Step 2 done here itself due to duplicate names in features 
train_features <- select(train_features,grep("std\\(\\)|mean\\(\\)",features,value = T))
train_subject <- as.numeric(readLines("Data/train/subject_train.txt"))
train_labels <- readLines("Data/train/y_train.txt")
train_data <- mutate(train_features,activity = train_labels,subjects = train_subject)
#getting rid of redundant data
rm(train_features,train_subject,train_labels)
```

+ Similarly Extracting test Data
```
test_features <- read.table("Data/test/X_test.txt")
names(test_features) <- features
#Step 2 done here itself due to duplicate names in features 
test_features <- select(test_features,grep("std\\(\\)|mean\\(\\)",features,value = T))
test_subject <- as.numeric(readLines("Data/test/subject_test.txt"))
test_labels <- readLines("Data/test/y_test.txt")
test_data <- mutate(test_features,activity = test_labels,subjects = test_subject)
#getting rid of redundant data
rm(test_features,test_subject,test_labels)
```
+ Merging Testing and Training Data
```
data_set <- rbind(train_data,test_data)
#getting rid of redundant data
rm(train_data,test_data)
```
+ Appropriately labeling the data set with descriptive variable names and summarising w.r.t. all variable means
```
tidy_data <- 
  data_set %>%
  mutate(activity = act_lab[as.numeric(activity)]) %>%
  group_by(activity,subjects) %>%
  summarise_all(mean) 
#removing unwanted data
rm(data_set,act_lab,features)
```
+wiriting to a file 
`write.table(tidy_data,file = "tidy_data.txt",row.names = F)`
___
4. __Codebook for tidydata set "tidy_data.txt"__ :

> Available as Codebook.txt
___
