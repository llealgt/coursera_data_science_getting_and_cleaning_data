
#Download the datasets
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
fileName <- "DataSet.zip";
resultDirectory <- "./UCI HAR Dataset";

download.file(fileUrl,fileName);

if(file.exists(resultDirectory))
{
  unlink(resultDirectory,recursive = TRUE);  
}  

#unzip the downloaded package
unzip(fileName);

setwd("./UCI HAR Dataset");

#read the datasets

##read the train sets
X_train_dataset  <- read.table("train/X_train.txt");
y_train_dataset <- read.table("train/y_train.txt");
subject_train_dataset <- read.table("train/subject_train.txt");  

##read the test sets
X_test_dataset <- read.table("test/X_test.txt");
y_test_dataset <- read.table("test/y_test.txt");
subject_test_dataset <- read.table("test/subject_test.txt");

##read the feature names
feature_names <- read.table("features.txt")[,2];

##read the activity names
activity_names <- read.table("activity_labels.txt");

#merge training and test sets
X_dataset <- rbind(X_train_dataset,X_test_dataset);
y_dataset <- rbind(y_train_dataset,y_test_dataset)
subject_dataset <- rbind(subject_train_dataset,subject_test_dataset);

#Give each variable a name taken from feature list
names(X_dataset) <- feature_names;

#get only the mean and std features
mean_and_std_features_variables <- grep(".*(mean|std)\\(\\)",feature_names);
X_dataset<- X_dataset[,mean_and_std_features_variables];

#Use descriptive activity names 
y_dataset <- merge(y_dataset,activity_names)[2]

#give more descriptive names to features(remove parentheses , change mean to Mean and std to Std)
names(X_dataset) <- gsub('[-()]', '', names(X_dataset));
names(X_dataset) <- gsub('mean', 'Mean', names(X_dataset));
names(X_dataset) <- gsub('std', 'StandardDeviation', names(X_dataset));
names(y_dataset) <- "Activity";
names(subject_dataset) <- "Subject";

#Get the resulting merged dataset:
#now contains the comobined test and train sets, only mean and std variables, activity names instead of number
#and descriptive labels for variable names
dataset <- cbind(X_dataset,y_dataset,subject_dataset);

#get the mean for each variable for each activity and each subject.
means <- aggregate(dataset,by = list(dataset$Activity,dataset$Subject),mean);

#remove the last activity and subject columns because  the first to "groups" are them
means <- means[,1:(ncol(means)-2)];
#give to group1 and group2 columns the corresponding activity and subject names
names(means)[c(1,2)] <- c("Activity","Subject");

#return to the original working directory
setwd("../");
write.table(means,file = "./means_dataset.txt",row.names = FALSE);
