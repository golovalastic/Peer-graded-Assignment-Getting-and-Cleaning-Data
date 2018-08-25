#step 0: reading data
library(dplyr)
library(data.table)

#read files

x.test <- read.table("UCI HAR Dataset/test/X_test.txt")
y.test <- read.table("UCI HAR Dataset/test/y_test.txt")
s.test <- read.table("UCI HAR Dataset/test/subject_test.txt")

x.train <- read.table("UCI HAR Dataset/train/X_train.txt")
y.train <- read.table("UCI HAR Dataset/train/y_train.txt")
s.train <- read.table("UCI HAR Dataset/train/subject_train.txt")

feat <- read.table("UCI HAR Dataset/features.txt",stringsAsFactors=FALSE)

#steps 1:4

#rename var name to discriptive one
s.test <- s.test %>% rename(UserID = V1)
s.train <- s.train %>% rename(UserID = V1)

#rename var name to discriptive one
y.test <- y.test %>% rename(ActivityType = V1)
y.train <- y.train %>% rename(ActivityType = V1)

#bind test data set together (id,activity and measured data)
dat.test <- bind_cols(s.test,y.test,x.test)
dat.test <- dat.test %>% mutate(DatasetType = c("test"))

#bind train data set together (id,activity and measured data)
dat.train <- bind_cols(s.train,y.train,x.train)
dat.train <- dat.train %>% mutate(DatasetType = c("train"))

#working with set of descriptive variable names: 
#1.find variables which counts mean or std and create variable for filtering
#2. filter set of varnames by "filter" variable described above
#3. Create variable "varnames"
#4. Create vectors for select and rename: named.vector consist of new descriptive varnames and subsetting.vector which consists of original varnames for subsetting dataset. 
feat$filter <- ifelse(grepl("mean|std",x = feat$V2),1,0)
feat.sub <- filter(feat,filter==1)
feat.sub$varnames <- paste0("V",feat.sub$V1)
subsetting.vector <- feat.sub$varnames
named.vector <- feat.sub$V2

#bind test and train sets together
dat.full <- bind_rows(dat.test,dat.train)
#select vars in which mean or std count and rename of vars in descriptive way
dat.sub <- dat.full %>% select (UserID,ActivityType,DatasetType,subsetting.vector)
dat.sub <- setnames(dat.sub, old = subsetting.vector, new = named.vector)
#convert not quantitative vars to factors
dat.sub$ActivityType <- factor(dat.sub$ActivityType,levels=c(1,2,3,4,5,6),labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
dat.sub$DatasetType <- as.factor(dat.sub$DatasetType)

#step 5 - group by and summarize of mean
dat.sub2 <- dat.sub %>%
  group_by(DatasetType,ActivityType,UserID) %>%
  summarize_all(mean)

write.table(dat.sub2,"dat_step5.txt", row.names = FALSE)
