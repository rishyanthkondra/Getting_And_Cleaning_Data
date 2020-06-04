library("dplyr")

#Extracting names of features
features <- readLines("Data/features.txt")
#> head(features)
#[1] "1 tBodyAcc-mean()-X" "2 tBodyAcc-mean()-Y" "3 tBodyAcc-mean()-Z"
#[4] "4 tBodyAcc-std()-X"  "5 tBodyAcc-std()-Y"  "6 tBodyAcc-std()-Z"
#parsing features
features <- sub("[0-9]+ ","",features)
#> str(features)
#chr [1:561] "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" ...

#Extracting names of Labels similarly
act_lab <- sub("[0-9]+ ","",readLines("Data/activity_labels.txt"))

#Exrtracting traing data
train_features <- read.table("Data/train/X_train.txt")
names(train_features) <- features
train_subject <- readLines("Data/train/subject_train.txt")
train_labels <- readLines("Data/train/y_train.txt")
train_data <- mutate(train_features,activity = train_labels,subjects = train_subject)
#getting rid of redundant data
rm(train_features,train_subject,train_labels)

#Similarly Extracting test Data
test_features <- read.table("Data/test/X_test.txt")
names(train_features) <- features
test_subject <- readLines("Data/test/subject_test.txt")
test_labels <- readLines("Data/test/y_test.txt")
test_data <- mutate(test_features,activity = test_labels,subjects = test_subject)
#getting rid of redundant data
rm(test_features,test_subject,test_labels)

#1 :Merging Testing and Training Data
data_set <- rbind(train_data,test_data)
data_set <- 
  data_set %>%
  #2: only freatures mean and std
  select(grep("std|mean",features,value = T),activity,subjects) %>% 
  # 3 :Uses descriptive activity names
  mutate(activity = act_lab[as.numeric(activity)])
  
