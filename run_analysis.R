library(plyr)
library(dplyr)
#1. Create and set working directory
if(!file.exists("./project")){dir.create("./project")}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile="./project/project.zip",method="curl")
unzip(zipfile="./project/project.zip",exdir="./project")
path <- file.path("./project" , "UCI HAR Dataset")
setwd(path)

#2.Read and bind files
##2.1 Read features names from Features file and store them as character-class
features <- read.table("features.txt")
features$V2 <- as.character(features$V2)

##2.2 Read and bind  data form test and train datasets and name variables with features
test_set<-read.table("test/X_test.txt")
train_set<-read.table("train/X_train.txt")
sets <- rbind(test_set, train_set)
names(sets)<- features$V2

##2.3 Select mean and std variables
sbf<-features$V2[grep("mean\\(|std\\(", features$V2)]
sets<-sets[,sbf]

##2.4 Read and bind activities codes form test and train 
act_test<-read.table("test/Y_test.txt")
act_train<-read.table("train/Y_train.txt")
acts <- rbind(act_test, act_train)
names(acts)<- c("activity")

##2.5 Read and bind subject info form test and train
sub_test<-read.table("test/subject_test.txt")
sub_train<-read.table("train/subject_train.txt")
subs<-rbind(sub_test, sub_train)
names(subs)<- c("subject")

##2.6 Bind data, activities and subject information.
fdb <- cbind(subs, acts, sets)

##2.7 Read activities names and merge wiht dataset
activities <- read.table("activity_labels.txt")
fdb <-(merge(activities, fdb, by.x="V1", by.y="activity"))

#3 Tidy data set
fdb<-select(fdb, -V1)
fdb<-rename(fdb, Activity=V2)

##3.1 Create averages of subjects and activities in second data set
tidy <-fdb %>% group_by(Activity, subject) %>% summarise_each(funs(mean))

##4 Write table
write.table(tidy, file="tidy.txt",row.name=FALSE)
