install.packages("reshape2")
library(reshape2)
# Read in Column (variable) Names
cname<-read.table("features.txt")
cname<-as.factor(cname[,2])
# Clean up variable names
cname<-gsub(",","",cname)
cname<-gsub("-","",cname)
cname<-gsub(" ","",cname)
cname<-gsub("\\(","",cname)
cname<-gsub(")","",cname)
cname<-tolower(cname)
# Read in Activity labels for train and test data
atrain<-read.table("train/y_train.txt",col.names="activity")
atest<-read.table("test/y_test.txt",col.names="activity")
# Changing activity numbers to descriptive activity names
atrain[atrain$activity==1,]<-"walking"
atrain[atrain$activity==2,]<-"walkingupstairs"
atrain[atrain$activity==3,]<-"walkingdownstairs"
atrain[atrain$activity==4,]<-"sitting"
atrain[atrain$activity==5,]<-"standing"
atrain[atrain$activity==6,]<-"laying"
atest[atest$activity==1,]<-"walking"
atest[atest$activity==2,]<-"walkingupstairs"
atest[atest$activity==3,]<-"walkingdownstairs"
atest[atest$activity==4,]<-"sitting"
atest[atest$activity==5,]<-"standing"
atest[atest$activity==6,]<-"laying"

# Read in Training Data
xtrain<-read.table("train/X_train.txt",col.names=cname)
# Merging with activity labels
xtrain<-cbind(atrain,xtrain)
# Read in subject training data
strain<-read.table("train/subject_train.txt",col.names="subject")
# Merging training data and subject names
xtrain<-cbind(strain,xtrain)
# Read in Test Data
xtest<-read.table("test/X_test.txt",col.names=cname)
# Merge with activity labels
xtest<-cbind(atest,xtest)
# Read in test subject names
stest<-read.table("test/subject_test.txt",col.names="subject")
# Merging subject names and test data
xtest<-cbind(stest,xtest)
# Merge the two data sets
xtotal<-rbind(xtrain,xtest)
#Subset data for only means and standard deviation of each measurement
xdata<-subset(xtotal,,grepl("subject|activity|[Mm]ean|[Ss]td",names(xtotal)))
# Subset the column names to exclude first two columns (subject and activity)
cname<-subset(cname,grepl("subject|activity|[Mm]ean|[Ss]td",cname))
cname<-as.factor(cname)
# Melt the data 
xdatamelt<-melt(xdata,id=c("activity","subject"),measure.vars=cname)
tidydata<-dcast(xdatamelt,subject+activity~variable,mean)
write.table(tidydata,file="tidydata.txt",row.names=FALSE)