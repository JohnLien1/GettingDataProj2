
#section 1 of the task
train.files <- dir("train/", pattern="txt")
subject<-lapply(paste0("train/",train.files[1]), read.table, sep="")
action<-lapply(paste0("train/",train.files[3]), read.table, sep="")
chunk<-read.table(paste0("train/",train.files[2]), sep="")
action<-as.numeric(unlist(action))
subject<-as.numeric(unlist(subject))
Data_train<-cbind(subject, action, chunk)
#extracting names from the list  
names<-read.table("features.txt")

#assigning coloumn name to the Data_train
colnames(Data_train)<-c(as.character(c("subject","action")), as.character(names[,2]) )



test.files <- dir("test/", pattern="txt")
subject<-lapply(paste0("test/",test.files[1]), read.table, sep="")
action<-lapply(paste0("test/",test.files[3]), read.table, sep="")
chunk<-read.table(paste0("test/",test.files[2]), sep="")
action<-as.numeric(unlist(action))
subject<-as.numeric(unlist(subject))
Data_test<-cbind(subject, action, chunk)

colnames(Data_test)<-c(as.character(c("subject","action")), as.character(names[,2]) )

Data<-rbind(Data_test, Data_train)

# section 2 of teh task
#selecting only the mean() andStd() excluding meanFreq()
Data2<-Data[,((intersect(grep(("subject|action|std()|mean()"), names(Data)), grep("meanFreq()", names(Data), invert=T))))]

#Section 3 activity changing name (named action here)
Data2$action[Data2$action==1]<-"WALKING"
Data2$action[Data2$action==2]<-"WALKING UPSTAIRS"
Data2$action[Data2$action==3]<-"WALKING DOWNSTAIRS"
Data2$action[Data2$action==4]<-"SITTING"
Data2$action[Data2$action==5]<-"STANDING"
Data2$action[Data2$action==6]<-"LAYING"

#Section 4 
names(Data2)<-gsub("-", ".", names(Data2))
names(Data2)<-gsub("[()]", "", names(Data2))
names(Data2)<-gsub("Acc", "Acceleration", names(Data2))
names(Data2)<-gsub("Gyro", "Angvelocity", names(Data2))
names(Data2)<-gsub("^[t]", "Time", names(Data2))
names(Data2)<-gsub("^[f]", "Freq", names(Data2))

#section 5
library(plyr)
library(dplyr)
NewData<-ddply(Data2, .(subject, action), colwise(mean))
#NewData2<-ddply(Data2, .(subject, action), colwise(sd))
names(NewData)[3:68]<-paste0("mean",names(NewData[3:68]))
#names(NewData2)[3:68]<-paste0("sd.",names(NewData2[3:68]))
Req_Data<-(NewData)

#writing the tidy data to a file...
write.table(Req_Data,"TidyData.txt", row.name=FALSE)


#writing the to a codebook 
mynames <- names(Req_Data)
description <- mynames
description<- gsub("subject", "Individual participating, can be any of the 30 particpating Individual", description)
description<- gsub("action", "action undrtaken by the participant (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
", description)
description <- gsub("sd.", "The standard Deviation ", description)
description <- gsub("Time", "of the Time domain signal ", description)
description <- gsub("Freq", "of the Frequency domain signal ", description)
description <- gsub("Body", "from the body", description)
description <- gsub("Gravity", "from the gravity", description)
description <- gsub("Acceleration", " acceleration signal", description)
description <- gsub("Angvelocity", " Angualar Velocity signal were obtained using", description)
description <- gsub("Jerk", " jerk signal", description)
description <- gsub("Mag", " Magnitude calculated using the Eculidean norm", description)
description <- gsub("mean.x", " mean value along the x-axis", description)
description <- gsub("mean.y", " mean value along the y-axis", description)
description <- gsub("mean.z", " mean value along the z-axis", description)
description <- gsub("std.x", " standard devation value along the x-axis", description)
description <- gsub("std.y", " standard devation value along the y-axis", description)
description <- gsub("std.z", " standard devation value along the z-axis", description)
description <- gsub("std.", " standard devation value", description)
codestart <- paste(mynames,":", description)
write.table(codestart, "codebook.md")